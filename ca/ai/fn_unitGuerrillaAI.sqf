/*
========================================================================================================================================
        AUTHOR:
                Cre8or

========================================================================================================================================
        DESCRIPTION:
                Enables guerrilla AI behaviour on a single unit.

                NOTE: LOCALITY REMAINS UNCHANGED - the script will execute on the same machine that called this function.
                Because of this, if you disconnect, or if your game crashes, the AI will stop working!
                Therefore you really shouldn't use this function, unless you REALLY know what you are doing!

                I recommend using ca_fnc_groupGuerrillaAI instead, so you won't have to worry about this weird stuff.

========================================================================================================================================
        ARGUMENTS:
                0:      (OBJECT) Unit
                        Default: N/A

                        The unit to apply the guerrilla AI behaviour on.
                ------------------------------------------------------------------------------------------------------------------------
                1:      (BOOL) Flank only
                        Default: false

                        A group of AI that is set to only flank will tend to break up into two teams when approaching a target, with one
                        team approaching from the left, and one from the right. With flanking disabled, the group will scatter evenly and
                        attempt to approach the target in a line formation.
                ------------------------------------------------------------------------------------------------------------------------
                2:      (NUMBER) Maximum approach variation
                        Default: 45

                        Maximum angle (in degrees) that the AI is willing to deviate from the direct Line-Of-Sight to the target. Higher
                        values mean the AI will approach from further away (useful for flanking), while lower numbers will make it
                        approach more directly (useful for rushing/chasing).
                        NOTE: Do not set this to more than 90, or the AI might orbit around the target, or even run away from it.
                ------------------------------------------------------------------------------------------------------------------------
                3:      (NUMBER) Minimum approach distance
                        Default: 50

                        Guerrilla units that are closer than this value (in meters) to their target will stop leaping forward, and instead
                        rush directly to their target.
                        Useful for urban environments, as the AI seems to have trouble pathfinding around buildings while flanking.
                ------------------------------------------------------------------------------------------------------------------------
                4:      (NUMBER) Maximum approach distance
                        Default: 1000

                        Guerrilla units won't chase or approach targets that are farther away than this distance (in meters).
                        Small numbers are useful for making AI follow waypoints longer, before breaking off to go after hostiles
                        (e.g. 100-200 meters). Large numbers (e.g. 1000-5000 meters) are useful for making AI chase down very distant
                        targets (such as snipers), provided the AI is aware of their presence.
                ------------------------------------------------------------------------------------------------------------------------
                5:      (NUMBER) Maximum search duration
                        Default: 30

                        Maximum duration (in seconds) that the AI will spend sweeping the last known location of a target before reporting
                        it as missing.
                        NOTE: If the target is still in the vicinity (but the AI can't see it) the AI will still be aware of its presence
                        and refuse to walk away, even if exceeding the maximum search duration. However, if the target manages to move out
                        of the AI's search area (see "minimum approach distance"), it will finally be reported as missing. The AI will then
                        stop searching and resume normal behaviour.
                ------------------------------------------------------------------------------------------------------------------------
                6:      (NUMBER) Search area size
                        Default: 30

                        Determines the size (in meters) of the area that the AI will search, upon arriving at a target's last known position.
                        NOTE: The search area is a square centered on the last known position, with a side length equal to twice this value.
                        As an example, 30 meters means the AI will search a 60m*60m large square (= 3600m²) centered on the target's
                        last known position.

========================================================================================================================================
        EXAMPLES:
                        [this] spawn ca_fnc_unitGuerrillaAI                             // inside a unit's init field
                ------------------------------------------------------------------------------------------------------------------------
                        [_unit, true, 60] spawn ca_fnc_unitGuerrillaAI                  // inside a script, where _unit is a unit
                ------------------------------------------------------------------------------------------------------------------------
                        {
                                [_x, false, 30, 60] spawn ca_fnc_unitGuerrillaAI
                        } forEach allUnits;                                             // inside a script, where _unit is a unit
                ------------------------------------------------------------------------------------------------------------------------
                        [this, false, 0, 100, 5000] spawn ca_fnc_unitGuerrillaAI        // inside a unit's init field
                                                                                        // example preset for a chasing AI

========================================================================================================================================
*/





// Fetch the paramters
params [
        ["_unit", objNull, [objNull, grpNull]],
        ["_flankOnly", false, [false]],
        ["_maxApproachVariation", 45, [45]],
        ["_minApproachDistance", 50, [50]],
        ["_maxApproachDistance", 1000, [1000]],
        ["_maxSearchDuration", 30, [30]],
        ["_searchAreaSize", 30, [30]]
];

// Exit if the unit is a player, or if it already uses guerrilla AI
if (_unit getVariable ["Cre8ive_GuerrillaAI", false] or {isPlayer _unit}) exitWith {};





// Set up some variables
private _group = group _unit;
private _hasTarget = false;
private _minApproachDistanceSqr = (_minApproachDistance + 10)  ^ 2;
private _approachVariation = 0;
private _timeOut = -1;
private _lastTargetPos = [0,0,0];
private _lastTargetHeight = 0;
private _lastTargetSpeedSqr = 0;
private _lastTargetIsVehicle = false;
private _lastTargetIsAircraft = false;
private _maxApproachDistanceSqr = _maxApproachDistance ^ 2;
private _searchAreaSize2 = _searchAreaSize * 2;
private _searchAreaSizeSqr = _searchAreaSize ^ 2;
private _targetPosVisited = false;
private _toggleTargeting = false;

// Flag this unit to inform that it can use the guerrilla AI (future proofing)
_unit setVariable ["Cre8ive_GuerrillaAI", true, true];

// Boost some of the unit's skills for improved decision making, movement speed and morale
_unit setSkill ["courage", 1];
_unit setSkill ["commanding", 1];
_unit setSkill ["endurance", 1];
_unit setSkill ["spotTime", 1];

// Prevent the AI from going into combat mode (to stop them from covering too much)
_unit disableAI "AUTOCOMBAT";

// Wait for eventual AI loadout functions to finish gearing up the unit
sleep 0.5;





// If this unit has a full-auto weapon (AR, SMG, LMG, etc.), add guerrilla-style suppressive fire
private _weapon = currentWeapon _unit;
private _weaponMode = "";
private _cycleDelay = 999;

if (_weapon != "") then {
        {
                scopeName "loop";

                private _parentClasses = [(configFile >> "CfgWeapons" >> _weapon >> _x), true] call BIS_fnc_returnParents;
                if ("Mode_FullAuto" in _parentClasses) then {
                        _weaponMode = _x;
                        breakout "loop";
                };
        } forEach ([(configFile >> "CfgWeapons" >> _weapon), "modes", []] call BIS_fnc_returnConfigEntry);

        _cycleDelay = [(configFile >> "CfgWeapons" >> _weapon >> _weaponMode), "reloadTime", 999] call BIS_fnc_returnConfigEntry;

	// Some addons use strings/expressions instead of numbers, so we need to do an extra step
	if (typeName _cycleDelay == typeName "") then {
	        _cycleDelay = call compile _cycleDelay;
	};
};

// If the delay between 2 rounds is greater than this value, we don't consider the unit's weapon as being full-auto
if (_cycleDelay < 0.5) then {

        // Save the weapon's cycling delay so we can reuse it later
        _unit setVariable ["Cre8ive_GuerrillaAI_CycleDelay", _cycleDelay * (1.05 - random 0.1), false];

        // Increase the unit's accuracy (helps with bursts fires)
        private _accuracy = _unit skill "aimingAccuracy";
        _unit setSkill ["aimingAccuracy", 1 - ((1 - _accuracy) / 2)];           //   50% -> 75%   /   0% -> 50%   /   80% -> 90%   /   etc.

        // Add our event handler to handle weapon firing
        _unit addEventHandler ["Fired", {
                params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine"];

                // If the unit is already doing suppressive fire, do nothing
                if (_unit getVariable ["Cre8ive_GuerrillaAI_Firing", false]) exitWith {};

                // Make our unit fire bursts
                _unit setVariable ["Cre8ive_GuerrillaAI_Firing", true, false];
                [_unit, _weapon, _muzzle, _mode, _unit getVariable ["Cre8ive_GuerrillaAI_CycleDelay", 0.1]] spawn {
                        params ["_unit", "_weapon", "_muzzle", "_mode", "_cycleDelay"];

                        // Determine the distance to our target
                        private _unitPos = getPosASL _unit;
                        private _target = _unit findNearestEnemy _unitPos;
                        private _distSqr = _unitPos distanceSqr (getPosASL _target);

                        // Determine how many rounds we can fire
                        private _ammoCount = _unit ammo _muzzle;
                        private _rounds = 0;

                        // If the target is within 200 meters, fire long bursts, otherwise short bursts
                        if (_distSqr > 40000) then {
                                _rounds = _ammoCount min (0 + floor random 3);
                        } else {
                                _rounds = _ammoCount min (2 + floor random 5);
                        };

                        // Fire our burst
                        if (_rounds > 0) then {
                                for "_i" from 1 to _rounds do {
                                        // Sleep a bit
                                        sleep _cycleDelay;

                                        // Fire the weapon
                                        _unit setWeaponReloadingTime [_unit, _weapon, 0];
                                        _unit forceWeaponFire [_muzzle, _mode];
                                };
                        };

                        sleep (0.5 + random 1);

                        // Reset the guerrilla suppression
                        _unit setVariable ["Cre8ive_GuerrillaAI_Firing", false, false];
                };
        }];

        // Ensure that the unit never runs out of ammo
        _unit addEventHandler ["Reloaded", {
                params ["_unit", "_weapon", "_muzzle", ["_newMagazine", []], ["_oldMagazine", []]];

                // Figure out the magazine classname
                private _magClass = _oldMagazine param [0, ""];
                if (_magClass == "") then {
                        _magClass = _newMagazine param [0, ""];
                };

                // Add a new magazine to the unit
                _unit addMagazine _magClass;
        }];
};





// Handle guerrilla AI decision making, tactics and movement
while {alive _unit} do {

        // Only continue if the unit is simulated and currently on foot
        if (simulationEnabled _unit and {vehicle _unit == _unit}) then {

                private _unitPos = getPosATL _unit;
                private _target = _unit findNearestEnemy _unitPos;
                private _targetPosReal = getPosATL _target;
                private _targetDistRealSqr = _unitPos distanceSqr _targetPosReal;

                // Only proceed if we have a target, and if it is within approach range (1km by default)
                if (alive _target and {_targetDistRealSqr < _maxApproachDistanceSqr}) then {

                        // Get info about our target
                        private _targetKnowledge = _unit targetKnowledge _target;
                        private _targetPos = ASLtoATL (_targetKnowledge select 6);

                        // If anyone in the group can see the target, get extensive info about it
                        if (_targetPos distanceSqr _targetPosReal < 100) then {
                                _targetPosVisited = false;
                                _lastTargetPos = _targetPosReal;
                                _lastTargetHeight = _targetPosReal select 2;
                                _lastTargetSpeedSqr = vectorMagnitudeSqr velocity _target;
                                _lastTargetIsVehicle = (vehicle _target != _target);
                                _lastTargetIsAircraft = typeOf _target isKindOf "Air";
                        };

                        // Only proceed if the target isn't a fast-moving vehicle (> 36 km/h) or in flight
                        if !((_lastTargetHeight > 20 and _lastTargetIsAircraft) or _lastTargetSpeedSqr > 100) then {

                                // If the unit just picked up a target, transition into guerrilla behaviour
                                if (!_hasTarget) then {
                                        _unit reveal [_target, 4];

                                        // Pick an approach method depending on the provided settings
                                        if (_flankOnly) then {
                                                _approachVariation = [_maxApproachVariation, -_maxApproachVariation] select (random 1 < 0.5);
                                        } else {
                                                _approachVariation = _maxApproachVariation - random (_maxApproachVariation * 2);
                                        };
                                        _hasTarget = true;
                                };

                                // Make the AI get ready to run
                                _unit setBehaviour "AWARE";

                                // Calculate the target distance (squared) and direction
                                private _targetDistSqr = _unitPos distanceSqr _lastTargetPos;
                                private _targetDir = _unitPos getDir _lastTargetPos;

                                // Add the approach variation into the equation
                                _approachVariation = ((_approachVariation + 5 - random 10) min _maxApproachVariation) max -_maxApproachVariation;
                                _targetDir = _targetDir + _approachVariation;

                                // Determine the AI's next position and move it there
                                private _newPos = [];
                                if (_targetDistSqr > _minApproachDistanceSqr or !_targetPosVisited) then {
                                        _timeOut = -1;
/*
                                        // Toggle targeting AI to allow units to push further towards the enemy
                                        _toggleTargeting = !_toggleTargeting;
                                        if (_toggleTargeting) then {
                                                _unit disableAI "TARGET";
                                                _unit disableAI "AUTOTARGET";
                                        } else {
                                                _unit enableAI "TARGET";
                                                _unit enableAI "AUTOTARGET";
                                        };
*/
                                        // Approach the target position
                                        if (_targetDistSqr > _minApproachDistanceSqr) then {
                                                _newPos = _unitPos vectorAdd ([sin _targetDir, cos _targetDir, 0] vectorMultiply (30 + random 20));
                                        } else {
                                                // Determine how close we should approach the last known position
                                                private _approachRadius = [3, 10] select _lastTargetIsVehicle;

                                                // If the unit is within ~3 meters of the last known position, consider it as "visited" and roam the area
                                                if (_unitPos distance2D _lastTargetPos < _approachRadius) then {
                                                        _targetPosVisited = true;
                                                        _newPos = _lastTargetPos vectorAdd [_searchAreaSize - random _searchAreaSize2, _searchAreaSize - random _searchAreaSize2, 0];
                                                } else {
                                                        _newPos = _lastTargetPos;
                                                };
                                        };

                                // If the unit is close enough, make it roam the target area
                                } else {
/*
                                        // Reactivate targeting when close
                                        if (_toggleTargeting) then {
                                                _toggleTargeting = false;
                                                _unit enableAI "TARGET";
                                                _unit enableAI "AUTOTARGET";
                                        };
*/
                                        // Start the timeOut countdown
                                        if (_timeOut < 0) then {
                                                _timeOut = time;
                                        } else {
                                                // Abort the search if it's taking too long, and forget the target
                                                if (time - _timeOut > _maxSearchDuration and {_unitPos distanceSqr _target > _searchAreaSizeSqr}) then {
                                                        _unit forgetTarget _target;
                                                        _timeOut = -1;
                                                };
                                        };
                                        _newPos = _lastTargetPos vectorAdd [_searchAreaSize - random _searchAreaSize2, _searchAreaSize - random _searchAreaSize2, 0];

/*
                                        // Find the closest house to the new move position
                                        private _house = (_newPos nearObjects ["Building", 10]) param [0, objNull];
                                        if (!isNull _house) then {
                                                private _positions = (_house buildingPos -1);
                                                private _count = count _positions;

                                                // If the house is enterable, breach it
                                                if (_count > 0) then {
                                                        systemChat "Breaching house...";
                                                        _newPos = _positions param [random floor _count, _newPos];
                                                };
                                        };
                                        // NOTE: Commented out for being too performance heavy for what it does
*/
                                };
                                _unit doMove _newPos;

                        // If the unit lost its target, reset the guerrilla behaviour
                        } else {
                                if (_hasTarget) then {
                                        _hasTarget = false;
                                        _timeOut = -1;
                                        _lastTargetHeight = 0;
                                        _lastTargetSpeedSqr = 0;
                                        _lastTargetIsAircraft = false;

                                        _unit doMove _unitPos;

//                                        _unit enableAI "TARGET";
//                                        _unit enableAI "AUTOTARGET";
                                };
                        };

                // Same as above
                } else {
                        if (_hasTarget) then {
                                _hasTarget = false;
                                _timeOut = -1;
                                _lastTargetHeight = 0;
                                _lastTargetSpeedSqr = 0;
                                _lastTargetIsAircraft = false;

                                _unit doMove _unitPos;

//                                _unit enableAI "TARGET";
//                                _unit enableAI "AUTOTARGET";
                        };
                };
        };

        // Repeat only every 5 to 7 seconds for performance's sake
        sleep (5 + random 2);
};
