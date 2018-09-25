#include "macros.hpp"

/*
========================================================================================================================================
        AUTHOR:
                Cre8or

========================================================================================================================================
        DESCRIPTION:
                Enables suppressive AI behaviour on a single unit.

                NOTE: LOCALITY REMAINS UNCHANGED - this function will execute on the machine that called it, rather than offloading it
                to the server. Because of this, if you disconnect, or if your game crashes, this AI script will stop working!
                Therefore you really shouldn't use this function, unless you REALLY know what you are doing!

                I recommend using ca_fnc_groupSuppressiveAI instead, so you won't have to worry about this weird stuff.

========================================================================================================================================
        ARGUMENTS:
                0:      (OBJECT) Unit
                        REQUIRED

                        The unit to apply the suppressive AI behaviour to.
                ------------------------------------------------------------------------------------------------------------------------
                1:      (NUMBER) Suppression Multiplier
                        OPTIONAL - Default: 1

                        A multiplier to increase or decrease the amount of suppressive fire the unit will lay down on targets. This
                        value primarily affects suppression on covering targets, with higher (or lower) numbers making the unit suppress
                        more (or less), respectively.
                ------------------------------------------------------------------------------------------------------------------------
                2:      (NUMBER) Suppression Duration Multiplier
                        OPTIONAL - Default: 1

                        A multiplier to increase or decrease the duration that the AI will  suppress hidden targets for (30 seconds, by
                        default). Higher numbers increase that duration, lower numbers decrease it.

========================================================================================================================================
        EXAMPLES:
                        [this] spawn ca_fnc_unitSuppressiveAI				// inside a unit's init field in 3DEN,
                                                                                        // or inside a unit's execution field in Zeus
                        // Using the minimum amount of parameters, everything not specified will use default values
                ------------------------------------------------------------------------------------------------------------------------
                        [_unit, 10, 2] spawn ca_fnc_unitSuppressiveAI                 // inside a script, where _unit is a unit
                        // Intense suppression with long duration (useful for base defense, or just covering elements)

========================================================================================================================================
*/





// Fetch the parameters
params [
        ["_unit", objNull, [objNull]],
        ["_suppressionMul", 1, [1]],
        ["_suppressionDurationMul", 1, [1]]
];

// Exit if the unit is a player, or if it already uses suppressive AI
if (_unit getVariable ["Cre8ive_SuppressiveAI", false] or {isPlayer _unit}) exitWith {};





// Wait for eventual AI loadout functions to finish gearing up the unit
sleep 0.5;





// If this unit has a full-auto weapon (AR, SMG, LMG, etc.), add suppressive fire
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

        // If a full-auto firemod was found, determine its fire rate
        if (_weaponMode != "") then {
                _cycleDelay = [(configFile >> "CfgWeapons" >> _weapon >> _weaponMode), "reloadTime", 999] call BIS_fnc_returnConfigEntry;

        	// Some addons use strings/expressions instead of numbers, so we need to do an extra step
                switch (typeName _cycleDelay) do {
                        case typeName 0: {};    // Do nothing
                        case typeName "": {_cycleDelay = call compile _cycleDelay};     // Compile the string
                        default {_cycleDelay = 999};    // Use fallback value
                };
        };
};

// If the delay between 2 rounds is greater than this value, we don't consider the unit's weapon as being full-auto
if (_cycleDelay < 0.5) then {

        // Flag this unit as using the suppressive AI script
        _unit setVariable ["Cre8ive_SuppressiveAI", true, true];

        // Save the weapon's cycling delay so we can reuse it later
        _unit setVariable ["Cre8ive_SuppressiveAI_CycleDelay", _cycleDelay * (1.05 - random 0.1), false];

        // Increase the unit's accuracy (helps with bursts fires)
        //private _accuracy = _unit skill "aimingAccuracy";
        //_unit setSkill ["aimingAccuracy", 1 - ((1 - _accuracy) / 2)];           //   50% -> 75%   /   0% -> 50%   /   80% -> 90%   /   etc.

        // Add our event handler to handle weapon firing
        _unit addEventHandler ["Fired", {
                params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine"];

                // If the unit is already doing suppressive fire, do nothing
                if (_unit getVariable ["Cre8ive_SuppressiveAI_Firing", false]) exitWith {};

                // Make our unit fire bursts
                _unit setVariable ["Cre8ive_SuppressiveAI_Firing", true, false];
                [_unit, _weapon, _muzzle, _mode, _unit getVariable ["Cre8ive_SuppressiveAI_CycleDelay", 0.1]] spawn {
                        params ["_unit", "_weapon", "_muzzle", "_mode", "_cycleDelay"];

                        // Determine the distance to our target
                        private _unitPos = eyePos _unit;
                        private _target = _unit findNearestEnemy ASLtoAGL _unitPos;
                        private _distSqr = 99999999;

                        // If we have no target, check if we have a position we should suppress instead
                        if (!alive _target) then {
                                private _targetPos = _unit getVariable ["Cre8ive_SuppressiveAI_LastTargetPos", []];

                                if !(_targetPos isEqualTo []) then {
                                        _distSqr = _unitPos distanceSqr _targetPos;
                                };
                        } else {
                                _distSqr = _unitPos distanceSqr (getPosASL _target);
                        };

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
                                        [_unit, _muzzle, _mode] MACRO_CALL(ca_fnc_fireWeaponSafe,"ca\ai\fn_fireWeaponSafe.sqf");
                                };
                        };

                        sleep (0.5 + random 1);

                        // Reset the suppression tag
                        _unit setVariable ["Cre8ive_SuppressiveAI_Firing", false, false];
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





        // Set up some constants
        private _groupID = group _unit call BIS_fnc_netId;
        private _maxSuppressionTime = 30 * _suppressionDurationMul;     // Default time to suppress units for, in seconds
        private _lastSeenVarName = format ["Cre8ive_SuppressiveAI_LastSeen_%1", _groupID];
        private _targetPosVarName = format ["Cre8ive_SuppressiveAI_TargetPos_%1", _groupID];
        private _targetAgeVarName = format ["Cre8ive_SuppressiveAI_TargetAge_%1", _groupID];
        private _nextSuppressVarName = format ["Cre8ive_SuppressiveAI_NextSuppress_%1", _groupID];
        private _maxIntersectDistSqr = 50 ^ 2;  // Don't suppress if there are more than 50m of obstruction between our unit and the target position

        // Set up some variables
        private _lastExec = 0;
        private _lastTargetPos = [];
        private _currentTarget = objNull;
        private _nextSuppress = 0;

        // Detect targets and actively suppress them
        while {alive _unit} do {

                private _time = time;

                // Only continue if the unit is simulated and currently on foot
                if (simulationEnabled _unit and {vehicle _unit == _unit}) then {

                        // Scan for new targets
                        private _unitPos = eyePos _unit;
                        private _target = _unit findNearestEnemy ASLtoATL _unitPos;

                        // Only proceed if we have a target that isn't an aircraft
                        if (alive _target and {!(_target isKindOf "Air")}) then {

                                // Get info about our target
                                private _targetPosReal = _target modelToWorldVisual [0, 0, 0];
                                if (_target isKindOf "Man") then {
                                        _targetPosReal = ASLtoATL eyePos _target;
                                };
                                private _targetKnowledge = _unit targetKnowledge _target;
                                private _targetPos = ASLtoATL (_targetKnowledge select 6);
                                private _targetAge = _targetKnowledge select 2;

                                // If anyone in the group can see the target, get extensive info about it
                                if (_targetAge > _lastExec and {vectorMagnitudeSqr velocity _target < 100}) then {
                                        _lastTargetPos = _targetPosReal;

                                        // Broadcast the position to the group, along with a timestamp (so we always use the most up to date value)
                                        _target setVariable [_targetPosVarName, _lastTargetPos, false];
                                        _target setVariable [_targetAgeVarName, _time, false];

                                        // Set the threat level to 100% because we can see the target
                                        _currentTarget = _target;
                                        group _unit reveal [_target, 4];
                                        _target setVariable [_lastSeenVarName, _time, false];
                                };
                        };

                        // If we're allowed to suppress...
                        if (_time > _nextSuppress) then {

                                // ...and if we have a target...
                                if (alive _currentTarget) then {

                                        // If the target's threat level is above 0% and can be suppressed, suppress it
                                        private _targetLastSeen = _currentTarget getVariable [_lastSeenVarName, -99999];
                                        private _threatLevel = (1 - (_time - _targetLastSeen) / _maxSuppressionTime) max 0;
                                        private _targetNextSuppress = _currentTarget getVariable [_nextSuppressVarName, 0];

                                        if (_threatLevel > 0 and {_time > _targetNextSuppress}) then {

                                                private _targetAge = _time - ((_unit targetKnowledge _currentTarget) select 2);
                                                private _targetAgeGroup = _time - (_currentTarget getVariable [_targetAgeVarName, 0]);

                                                // If anyone else in the group has more up-to-date information on the target, use their intel instead
                                                if (_targetAgeGroup <= _targetAge) then {
                                                        //systemChat "Group has more up-to-date info, taking their intel...";
                                                        _targetAge = _targetAgeGroup;
                                                        _lastTargetPos = _currentTarget getVariable [_targetPosVarName, _lastTargetPos];
                                                };
                                                private _lastTargetPosASL = ATLtoASL _lastTargetPos;
                                                private _targetDist = _unitPos distance _lastTargetPosASL;
                                                private _ageCutoff = 0.25 + _targetDist / 100;

                                                // If the unit has a visual on the target's last position, but not the target, stop suppressing
                                                if (_targetAge > _ageCutoff and {([_unit, "VIEW", _currentTarget] checkVisibility [eyePos _unit, _lastTargetPosASL]) > 0.5}) then {

                                                        //systemChat format ["Lost target... (age: %1 / ageGroup: %2)", _time - ((_unit targetKnowledge _currentTarget) select 2), _targetAgeGroup];
                                                        _currentTarget setVariable [_lastSeenVarName, -9999, false];
                                                        _currentTarget = objNull;
                                                        _lastTargetPos = [];
                                                        _unit setVariable ["Cre8ive_SuppressiveAI_LastTargetPos", []];

                                                // Otherwise, we either know, or assume the target is still there...
                                                } else {
                                                        _unit setVariable ["Cre8ive_SuppressiveAI_LastTargetPos", _lastTargetPosASL];

                                                        // ...so unless the target position is way out of reach (e.g. behind a mountain), we suppress it
                                                        private _shouldSuppress = true;
                                                        private _intersectPosUnit = ((lineIntersectsSurfaces [_unitPos, _lastTargetPosASL, _unit, _currentTarget]) param [0, [], [[]]]) param [0, [], [[]]];
                                                        private _intersectPosTarget = ((lineIntersectsSurfaces [_lastTargetPosASL, _unitPos, _unit, _currentTarget]) param [0, [], [[]]]) param [0, [], [[]]];

                                                        if !(_intersectPosUnit isEqualTo [] or {_intersectPosTarget isEqualTo []}) then {
                                                                if (_intersectPosUnit distanceSqr _intersectPosTarget > _maxIntersectDistSqr) then {
                                                                        _shouldSuppress = false;
                                                                };
                                                        };

                                                        if (_shouldSuppress) then {
                                                                private _dummy = "Sign_Sphere25cm_F" createVehicleLocal [0,0,0];
                                                                _dummy hideObject true;
                                                                _dummy setPosATL _lastTargetPos;

                                                                // Stop the unit
                                                                _unit doMove getPosATL _unit;

                                                                // Tell the unit to aim at the dummy
                                                                _unit reveal _dummy;
                                                                _unit doTarget objNull;
                                                                _unit doTarget _dummy;

                                                                // Wait until the unit is actually aiming at it
                                                                private _timeOut = _time + 1.5;
                                                                while {alive _unit} do {

                                                                        sleep 0.1;

                                                                        // Exit if the unit is already firing, if it's taking too long
                                                                        if (_unit getVariable ["Cre8ive_SuppressiveAI_Firing", false] or {time > _timeOut}) exitWith {};

                                                                        // Run in unscheduled to prevent any issues
                                                                        isNil {
                                                                                private _dir = vectorNormalized (_lastTargetPosASL vectorDiff eyePos _unit);
                                                                                private _dirWeapon = _unit weaponDirection currentWeapon _unit;

                                                                                // Check if the unit is(roughly) aiming at the target position
                                                                                if ((_dir vectorDotProduct _dirWeapon) > 0.995) then {

                                                                                        // If the target can be suppressed again, engage
                                                                                        if (time > _currentTarget getvariable [_nextSuppressVarName, 0]) then {
                                                                                                _unit doTarget _dummy;
                                                                                                private _fired = [_unit, currentMuzzle _unit, "Single"] MACRO_CALL(ca_fnc_fireWeaponSafe,"ca\ai\fn_fireWeaponSafe.sqf");

                                                                                                // If we were able to suppress the target, lower its threat value
                                                                                                if (_fired) then {
                                                                                                        private _timeFired = time;
                                                                                                        _targetLastSeen = _currentTarget getVariable [_lastSeenVarName, -99999];
                                                                                                        _threatLevel = (1 - (_timeFired - _targetLastSeen) / _maxSuppressionTime) max 0;
                                                                                                        _nextSuppress = _timeFired + (2 + random 1) / _suppressionMul;

                                                                                                        _currentTarget setVariable [_nextSuppressVarName, _timeFired + (((1 - _threatLevel) ^ 2) * 2 + random 0.5) / _suppressionMul];
                                                                                                        systemChat format ["Firing! (threat: %1)", _threatLevel];
                                                                                                };

                                                                                                // If the unit is also running guerrilla AI, send it back on its way
                                                                                                private _movePos = _unit getVariable ["Cre8ive_GuerrillaAI_MovePos", []];
                                                                                                if !(_movePos isEqualTo []) then {
                                                                                                        _unit doMove _movePos;
                                                                                                };
                                                                                        };
                                                                                };
                                                                        };
                                                                };

                                                                // Delete the dummy
                                                                deleteVehicle _dummy;
                                                        };
                                                };
                                        };


                                } else {
                                        if !(_lastTargetPos isEqualTo []) then {
                                                _lastTargetPos = [];
                                                _unit setVariable ["Cre8ive_SuppressiveAI_LastTargetPos", []];
                                        };
                                };
                        };
                };

                _lastExec = _time;
                sleep 0.9 + random 0.2;
        };
};
