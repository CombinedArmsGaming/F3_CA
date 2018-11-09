/*
        Provides information to the suppressive AI when deciding which vehicle weapon (and magazine) to use when engaging a target.

        Among this information is:
                - Which magazine types a turret can use, and in which weapon
                - ROF of each magazine's associated weapon (to decide on the duration of bursts) (?)
                - Weight for each magazine to be randomly picked

        NOTE: Exclude anti-armour magazines and children of MissileBase/MissileCore/SmokeLauncherAmmo from the list
        NOTE: Separate magazines by turret path



*/

params [
        ["_veh", objNull, [objNull]]
];






// Set up some functions
private _namespaces = [];
private _createNamespace = {
        private _location = createLocation ["NameVillage", [0,0], 0, 0];
        _namespaces pushBack _location;
        _location;
};

// Set up some constants
private _correctionFactor = 3;          // Lower numbers increase the chance for special magazines to be used (tank cannons, autocannons, etc.), higher numbers decrease it
private _maxAmmoPerMag = 500;            // Don't consider more than this many bullets per magazine (useful for magazines with thousands of bullets throwing the weights off)

// Set up some variables
private _turretPaths = call _createNamespace;
private _associatedWeapons = call _createNamespace;





// Run in unscheduled environment
isNil {

        // Calculate our total ammo counts by turret path and magazine type
        {
                _x params ["_magType", "_turretPath", "_ammo", "_ID", "_owner"];

                // Exclude the driver position
                if !(_turretPath isEqualTo [-1]) then {

                        // Fetch the ammo counts for this turret path
                        private _turretPathStr = str _turretPath;
                        private _magCounts = _turretPaths getVariable [_turretPathStr, locationNull];

                        // If this turret path has no magazine counts yet, create a new namespace
                        if (isNull _magCounts) then {
                                _magCounts = call _createNamespace;
                        };

                        // Add 1 to the magazine count
                        private _magCount = _magCounts getVariable [_magType, 0];
                        _magCounts setVariable [_magType, _magCount + 1];

                        // Save the turret path
                        _turretPaths setVariable [_turretPathStr, _magCounts];
                };

        } forEach magazinesAllTurrets _veh;


        // Filter out unwanted types
        {
                private _magCounts = call _createNamespace;
                private _magCountsOld = _turretPaths getVariable [_x, locationNull];

                {
                        // Fetch the bullet class from the magazine
                        private _bulletType = [configfile >> "CfgMagazines" >> _x, "ammo", ""] call BIS_fnc_returnConfigEntry;

                        // If the string is non-empty
                        if (_bulletType != "") then {

                                // Filter out unwanted parent classes
                                private _isValidClass = true;
                                {
                                        if (_bulletType isKindOf _x) exitWith {
                                                _isValidClass = false;
                                        };
                                } forEach [
                                        "MissileCore",
                                        "SmokeLauncherAmmo",
                                        "CMflareAmmo",
                                        "BombCore",
                                        "TimeBombCore",
                                        "FlareCore",
                                        "FakeAmmo"
                                ];

                                // If the ammo type is a valid class (e.g. bullets), we continue
                                if (_isValidClass) then {

                                        // Fetch the AI usage flags
                                        private _isAP = true;
                                        private _AIusage = [configfile >> "CfgAmmo" >> _bulletType, "aiAmmoUsageFlags", ""] call BIS_fnc_returnConfigEntry;

                                        if (typeName _AIusage == typeName "") then {
                                                _isAP = (_AIusage find "512") > 0;
                                        } else {
                                                _isAP = (_AIUsage >= 512);
                                        };

                                        // Only keep this magazine type if it doesn't hold anti-tank ammo (such as AP rounds)
                                        if (!_isAP) then {
                                                private _magCount = _magCountsOld getVariable [_x, 0];
                                                _magCounts setVariable [_x, _magCount];
                                        };
                                };
                        };
                } forEach allVariables _magCountsOld;

                // Save the new ammo count
                _turretPaths setVariable [_x, _magCounts];

        } forEach allVariables _turretPaths;


        // Determine which magazine goes with which weapon
        {
                private _magCounts = _turretPaths getVariable [_x, locationNull];
                {
                        private _weapon = _x;
                        private _muzzles = [configfile >> "CfgWeapons" >> _weapon, "muzzles", []] call BIS_fnc_returnConfigEntry;
                        private _compatibleMags = [];

                        // Iterate through all muzzles to get the full list of magazines this weapon accepts
                        {
                                if (toLower _x == "this") then {
                                        private _compatibleMagsMuzzle = [configfile >> "CfgWeapons" >> _weapon, "magazines", []] call BIS_fnc_returnConfigEntry;
                                        _compatibleMags append _compatibleMagsMuzzle;
                                } else {
                                        private _compatibleMagsMuzzle = [configfile >> "CfgWeapons" >> _weapon >> _x, "magazines", []] call BIS_fnc_returnConfigEntry;
                                        _compatibleMags append _compatibleMagsMuzzle;
                                };
                        } forEach _muzzles;

                        // See if any of this turret's magazines fit into this weapon
                        private _found = false;
                        _compatibleMags = _compatibleMags apply {toLower _x};
                        {
                                if ((toLower _x) in _compatibleMags) then {
                                        //systemChat format ["- Associated magazine %1 to weapon %2", _x, _weapon];
                                        _associatedWeapons setVariable [_x, _weapon];
                                        _found = true;
                                };
                        } forEach allVariables _magCounts;

                        if (!_found) then {
                                //systemChat format ["ERROR: Couldn't find a matching weapon for %1!", _x];
                        };

                        // Fetch the firing rate
                        private _cycleDelay = missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_CycleDelay_%1", _weapon], -1];

                        // If we don't have any data for this weapon yet, we generate it
                        if (_cycleDelay < 0) then {
                                _cycleDelay = 999;

                                // Find the firing mode with the highest rate of fire
                                {
                                        private _cycleDelayNew = [configFile >> "CfgWeapons" >> _weapon >> _x, "reloadTime", 999] call BIS_fnc_returnConfigEntry;

                                        // Some addons use strings/expressions instead of numbers, so we need to do an extra step
                                        switch (typeName _cycleDelayNew) do {
                                                case typeName 0: {};    // Do nothing
                                                case typeName "": {_cycleDelayNew = call compile _cycleDelayNew};     // Compile the string
                                                default {_cycleDelayNew = 999};    // Use fallback value
                                        };

                                        // If this firing mode has a faster rate of fire than the previous one, switch to it
                                        if (_cycleDelay > _cycleDelayNew) then {
                                                _cycleDelay = _cycleDelayNew;
                                        };

                                } forEach ([configFile >> "CfgWeapons" >> _weapon, "modes", []] call BIS_fnc_returnConfigEntry);

                                // Save the data for later use
                                missionNamespace setVariable [format ["Cre8ive_SuppressiveAI_CycleDelay_%1", _weapon], _cycleDelay, false];
                                //systemChat format ["Generated firing rate for %1! (%2 RPM)", _weapon, round (60 / _cycleDelay)];
                        };

                } forEach (_veh weaponsTurret (call compile _x));
        } forEach allVariables _turretPaths;


        // Save the generated data
        private _vehType = typeOf _veh;
        {
                // Fetch the ammo counts
                private _magCounts = _turretPaths getVariable [_x, locationNull];
                private _magTypes = allVariables _magCounts;

                // Calculate the weights
                private _weights = [];
                private _weightTotal = 0;
                private _weapons = [];
                {
                        private _magCount = _magCounts getVariable [_x, 0];
                        private _ammoPerMag = [configfile >> "CfgMagazines" >> _x, "count", 0] call BIS_fnc_returnConfigEntry;
                        private _weight = _magCount * (_ammoPerMag min _maxAmmoPerMag) / (_magCount + _correctionFactor);
                        _weightTotal = _weightTotal + _weight;

                        _weights pushBack _weightTotal;

                        private _weapon = _associatedWeapons getVariable [_x, ""];
                        _weapons pushBack _weapon;
                } forEach _magTypes;

                // Normalise the weights
                _weights = _weights apply {_x / _weightTotal};

                missionNamespace setVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_IsCompiled", _vehType], true, false];
                missionNamespace setVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_Mags_%2", _vehType, _x], _magTypes, false];
                missionNamespace setVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_Weights_%2", _vehType, _x], _weights, false];
                missionNamespace setVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_Weapons_%2", _vehType, _x], _weapons, false];
        } forEach allVariables _turretPaths;


        // Clean up
        {deleteLocation _x} forEach _namespaces;
        //systemChat "Finished!";
};
