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
                ------------------------------------------------------------------------------------------------------------------------
                3:      (BOOL) Use Animations
                        OPTIONAL - Default: false

                        If enabled, the unit will use tactical movement animations when suppressing, allowing it to move while
			firing at its target. Best used in combination with Guerrilla AI.
			This is disabled by default because the AI will sometimes warp through (or into) objects/buildings/vehicles
			while playing the animations.

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
        ["_suppressionDurationMul", 1, [1]],
	["_useAnims", false, [false]]
];

// Exit if the unit is a player, or if it already uses suppressive AI
if (_unit getVariable ["Cre8ive_SuppressiveAI", false] or {isPlayer _unit}) exitWith {};

// Flag this unit as using the suppressive AI script
_unit setVariable ["Cre8ive_SuppressiveAI", true, true];

// Prevent zero divisor issues
_suppressionMul = _suppressionMul max 0.00001;
_suppressionDurationMul = _suppressionDurationMul max 0.00001;





// Wait for eventual AI loadout functions to finish gearing up the unit
sleep 0.5;





// Increase the unit's accuracy (helps with bursts fires)
//private _accuracy = _unit skill "aimingAccuracy";
//_unit setSkill ["aimingAccuracy", 1 - ((1 - _accuracy) / 2)];           //   50% -> 75%   /   0% -> 50%   /   80% -> 90%   /   etc.

// If the unit should use player animations while suppressing, flag it
if (_useAnims) then {
	_unit setVariable ["Cre8ive_SuppressiveAI_UseAnims", _useAnims, false];

	// Add an event handler to re-enable the move AI component after the unit finishes its animation
	_unit addEventHandler ["AnimDone", {
		params ["_unit"];

		if (_unit getVariable ["Cre8ive_SuppressiveAI_MoveDisabled", false]) then {
			_unit setVariable ["Cre8ive_SuppressiveAI_MoveDisabled", false, false];
			_unit enableAI "MOVE";
		};
	}];
};

// Add our event handler to handle weapon firing
_unit addEventHandler ["Fired", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine"];

        // Determine our cycle delay
        private _cycleDelay = missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_CycleDelay_%1", currentweapon _unit], 999];

        // If the unit is already doing suppressive fire, or doesn't have a weapon that's suited for suppressive fire, do nothing
        if (_cycleDelay >= 0.5 or {_unit getVariable ["Cre8ive_SuppressiveAI_Firing", false]}) exitWith {};

        // Make our unit fire bursts
        _unit setVariable ["Cre8ive_SuppressiveAI_Firing", true, false];
        [_unit, _weapon, _muzzle, _mode, _cycleDelay] spawn {
                params ["_unit", "_weapon", "_muzzle", "_mode", "_cycleDelay"];

		// Only continue if the weapon is a primary weapon
		if (_weapon != primaryWeapon _unit) exitWith {};

                // Determine the distance to our target
                private _unitPos = eyePos _unit;
                private _target = _unit findNearestEnemy ASLtoAGL _unitPos;
		private _targetPos = getPosASL _target;
                private _distSqr = 99999999;

                // If we have no target, check if we have a position we should suppress instead
                if (!alive _target) then {
                        _targetPos = _unit getVariable ["Cre8ive_SuppressiveAI_LastTargetPos", []];

                        if !(_targetPos isEqualTo []) then {
                                _distSqr = _unitPos distanceSqr _targetPos;
                        };
                } else {
                        _distSqr = _unitPos distanceSqr _targetPos;
                };

                // Determine how many rounds we can fire
                private _ammoCount = _unit ammo _muzzle;
                private _rounds = 0;

                // If the target is within 100 meters, fire long bursts
                if (_distSqr < 10000) then {
                        _rounds = _ammoCount min (1 + floor random 5);			// 1..5
		// Otherwise...
                } else {
			// If the target is within 300 meters, fire medium bursts
			if (_distSqr < 90000) then {
                        	_rounds = _ammoCount min (1 + floor random 3);		// 1..3
			// Otherwise, fire short bursts
			} else {
                        	_rounds = _ammoCount min floor random 3;		// 0..2
			};
                };

		// If enabled, use player animations to approach the target
		if (_unit getVariable ["Cre8ive_SuppressiveAI_UseAnims", false]) then {

			// Only player animations if we're not too close
			if (_distSqr > 100 and {random 1 < 0.5}) then {		// Only use animations 50% of the time

				// Only continue if the unit is standing or crouching
				private _stance = stance _unit;
				if (_stance == "STAND" or {_stance == "CROUCH"}) then {

					private _dir = _unit getRelDir _targetPos;
					if (_dir > 180) then {_dir = _dir - 360};

					// Only play an animation if the target is roughly infront of the unit
					if (abs _dir < 40) then {

						// Check if there is an obstacle infront of the unit
						private _doMove = false;
						private _unitPosASL = getPosASL _unit;
						private _moveDir = getDir _unit;

						private _animStand = "amovpercmtacsraswrfldf";
						private _animCrouch = "amovpknlmtacsraswrfldf";

						if (_dir > 20) then {
							_animStand = "amovpercmtacsraswrfldfr";
							_animCrouch = "amovpknlmtacsraswrfldfr";
							_moveDir = _moveDir + 45;
						};
						if (_dir < -20) then {
							_animStand = "amovpercmtacsraswrfldfl";
							_animCrouch = "amovpknlmtacsraswrfldfl";
							_moveDir = _moveDir - 45;
						};

						// Check for obstructions
						private _vecDir = [sin _moveDir, cos _moveDir, 0];
					        private _startPos = _unitPosASL vectorAdd [0, 0, 0.5];
					        private _endPos = _startPos vectorAdd (_vecDir vectorMultiply 3);
					        private _results = lineIntersectsSurfaces [_startPos, _endPos, _unit, objNull, true, 1, "GEOM", "VIEW"];

						// If there are no obstructions, play the animation
						if (_results isEqualTo []) then {
							_doMove = true;

							if (_stance == "STAND") then {
								_unit playMoveNow _animStand;
							} else {
								_unit playMoveNow _animCrouch;
							};

						// Otherwise, if we have an obstruction in the unit's direction (which isn't necessarily the same, due to the sidestep animations)
						} else {
							_vecDir = vectorDir _unit;
							_startPos = _unitPosASL vectorAdd [0, 0, 1];
							_endPos = _startPos vectorAdd (_vecDir vectorMultiply 1.5);
							_results = lineIntersectsSurfaces [_startPos, _endPos, _unit, objNull, true, 1, "GEOM", "VIEW"];

							// If there is no obstruction at this height, vaulting should be possible, but it isn't required just yet
							if (_results isEqualTo []) then {

								_startPos = _unitPosASL vectorAdd [0, 0, 0.5];
								_endPos = _startPos vectorAdd _vecDir;
								private _hitObj = ((lineIntersectsSurfaces [_startPos, _endPos, _unit, objNull, true, 1, "GEOM", "VIEW"]) param [0, []]) param [2, objNull];

								// If there is a stationary obstruction at low height that isn't terrain, we need to vault over it
								if !(isNull _hitObj or {_hitObj isKindOf "AllVehicles"}) then {
									_doMove = true;
									_unit playMoveNow "aovrpercmstpsraswrfldf";
								};
							};
						};

						// If we've overriden the unit's animation, temporarily disable its "MOVE" component to stop it from getting stuck
						if (_doMove) then {
							_unit disableAI "MOVE";
							_unit setVariable ["Cre8ive_SuppressiveAI_MoveDisabled", true, false];
						};
					};
				};
			};
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

	// Only refill primary weapon ammo (excluding UGLs)
	if (_muzzle == primaryWeapon _unit) then {

	        // Figure out the magazine classname
	        private _magClass = _oldMagazine param [0, ""];
	        if (_magClass == "") then {
	                _magClass = _newMagazine param [0, ""];
	        };

	        // Add a new magazine to the unit
	        _unit addMagazine _magClass;
	};
}];





// Set up some constants
private _groupID = group _unit call BIS_fnc_netId;
private _maxSuppressionTime = 30 * _suppressionDurationMul;     // Default time to suppress units for, in seconds
private _lastSeenVarName = format ["Cre8ive_SuppressiveAI_LastSeen_%1", _groupID];
private _targetPosVarName = format ["Cre8ive_SuppressiveAI_TargetPos_%1", _groupID];
private _targetAgeVarName = format ["Cre8ive_SuppressiveAI_TargetAge_%1", _groupID];
private _nextSuppressVarName = format ["Cre8ive_SuppressiveAI_NextSuppress_%1", _groupID];
private _maxIntersectDistSqr = 25 ^ 2;  // Don't suppress if there are more than 25m of obstruction between our unit and the target position
private _maxDispersion = 15;		// How much extra suppression dispersion to add to the target (radius around the target's last position), in meters
private _maxDispersionDuration = 10;	// How long it takes for the suppression dispersion to reach its maximum (without a LOS to the target), in seconds

// Set up some variables
private _lastVeh = objNull;
private _lastExec = 0;
private _lastTarget = objNull;
private _lastTargetPos = [];
private _currentTarget = objNull;
private _nextSuppress = 0;
private _nextLookAt = 0;
private _isSoftTarget = false;

// Set up functions
private _findNearestTarget = {
        params [["_sourcePos", [0,0,0], [[]]]];
        private _target = _unit findNearestEnemy _sourcePos;

        // Only proceed if we have a target that isn't an aircraft
        if (alive _target and {!(_target isKindOf "Air")}) then {

                // Get info about our target
                private _targetPosReal = [0,0,0];
                if (_target isKindOf "Man") then {
                        _targetPosReal = ASLtoATL eyePos _target;
                } else {
                        _targetPosReal = _target modelToWorldVisual [0, 0, 0];
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
};




// Detect targets and actively suppress them
while {alive _unit} do {

        // Get the time
        private _time = time;

        // Only continue if the unit is simulated
        if (simulationEnabled _unit) then {

                // Only continue if the unit is on foot
                if (vehicle _unit == _unit) then {

                        // If we just dismounted from a vehicle, clear some variables
                        if (!isNull _lastVeh) then {
                                _lastVeh = objNull;
                                _lastTarget = objNull;
                                _isSoftTarget = false;
                        };

                        // Get the weapon's firing rate
                        private _weapon = currentWeapon _unit;
                        private _cycleDelay = missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_CycleDelay_%1", _weapon], -1];
                        if (_cycleDelay < 0) then {

                                // We don't have a firing rate for this weapon yet, so we fetch it
                                private _weaponMode = "";
                                _cycleDelay = 999;
                                {
                                        scopeName "loop";

                                        private _parentClasses = [configFile >> "CfgWeapons" >> _weapon >> _x, true] call BIS_fnc_returnParents;
                                        if ("Mode_FullAuto" in _parentClasses) then {
                                                _weaponMode = _x;
                                                breakout "loop";
                                        };
                                } forEach ([configFile >> "CfgWeapons" >> _weapon, "modes", []] call BIS_fnc_returnConfigEntry);

                                // If a full-auto firemod was found, determine its fire rate
                                if (_weaponMode != "") then {
                                        _cycleDelay = [configFile >> "CfgWeapons" >> _weapon >> _weaponMode, "reloadTime", 999] call BIS_fnc_returnConfigEntry;

                                	// Some addons use strings/expressions instead of numbers, so we need to do an extra step
                                        switch (typeName _cycleDelay) do {
                                                case typeName 0: {};    // Do nothing
                                                case typeName "": {_cycleDelay = call compile _cycleDelay};     // Compile the string
                                                default {_cycleDelay = 999};    // Use fallback value
                                        };

                                        // Save the cycle delay for future calls
                                        missionNamespace setVariable [format ["Cre8ive_SuppressiveAI_CycleDelay_%1", _weapon], _cycleDelay, false];

                                // Otherwise, set the firing rate to something ridiculously low
                                } else {
                                        missionNamespace setVariable [format ["Cre8ive_SuppressiveAI_CycleDelay_%1", _weapon], 999, false];
                                };
                        };

                        // If the unit is on foot, only continue if it has an automatic weapon
                        if (_cycleDelay < 0.5) then {

                                // Scan for new targets
                                private _unitPos = eyePos _unit;
                                [ASLtoATL _unitPos] call _findNearestTarget;

                                // If we're allowed to suppress...
                                if (_time > _nextSuppress) then {

                                        // ...and if we have a target...
                                        if (alive _currentTarget) then {

                                                private _targetLastSeen = _currentTarget getVariable [_lastSeenVarName, -99999];
                                                private _threatLevel = (1 - (_time - _targetLastSeen) / _maxSuppressionTime) max 0;
                                                private _targetNextSuppress = _currentTarget getVariable [_nextSuppressVarName, 0];

                                                // If the target's threat level is above 0% and can be suppressed, suppress it
                                                if (_threatLevel > 0 and {_time > _targetNextSuppress}) then {

                                                        private _targetAge = _time - ((_unit targetKnowledge _currentTarget) select 2);
                                                        private _targetAgeGroup = _time - (_currentTarget getVariable [_targetAgeVarName, 0]);

                                                        // If anyone else in the group has more up-to-date information on the target, use their intel instead
                                                        if (_targetAgeGroup <= _targetAge) then {
                                                                _targetAge = _targetAgeGroup;
                                                                _lastTargetPos = _currentTarget getVariable [_targetPosVarName, _lastTargetPos];
                                                        };
                                                        private _lastTargetPosASL = ATLtoASL _lastTargetPos;
                                                        private _targetDist = _unitPos distance _lastTargetPosASL;
                                                        private _ageCutoff = 0.25 + _targetDist / 100;

                                                        // If the unit has a visual on the target's last position, but not the target, stop suppressing
                                                        if (_targetAge > _ageCutoff and {_targetDist < 200} and {([_unit, "VIEW", _currentTarget] checkVisibility [_unitPos, _lastTargetPosASL]) > 0.1}) then {
                                                                //systemChat format ["Lost target... (age: %1 / ageGroup: %2)", _time - ((_unit targetKnowledge _currentTarget) select 2), _targetAgeGroup];
                                                                _currentTarget setVariable [_lastSeenVarName, -9999, false];
                                                                _currentTarget = objNull;
                                                                _lastTargetPos = [];
                                                                _unit setVariable ["Cre8ive_SuppressiveAI_LastTargetPos", []];

                                                        // Otherwise, we either know, or assume the target is still there...
                                                        } else {
                                                                _unit setVariable ["Cre8ive_SuppressiveAI_LastTargetPos", _lastTargetPosASL];

                                                                // ...so unless the target position is too obstructed (e.g. behind a mountain), we suppress it
                                                                private _shouldSuppress = true;
                                                                private _intersectPosUnit = ((lineIntersectsSurfaces [_unitPos, _lastTargetPosASL, _unit, _currentTarget]) param [0, [], [[]]]) param [0, [], [[]]];
                                                                private _intersectPosTarget = ((lineIntersectsSurfaces [_lastTargetPosASL, _unitPos, _unit, _currentTarget]) param [0, [], [[]]]) param [0, [], [[]]];

                                                                if !(_intersectPosUnit isEqualTo [] or {_intersectPosTarget isEqualTo []}) then {
                                                                        if (_intersectPosUnit distanceSqr _intersectPosTarget > _maxIntersectDistSqr) then {
                                                                                _shouldSuppress = false;
                                                                        };
                                                                };

                                                                if (_shouldSuppress) then {
									private _targetPosFireAt = _lastTargetPos getPos [(((_time - _targetLastSeen) / _maxDispersionDuration) min 0.5) * 2 * ((_targetDist / 3) min (random _maxDispersion)), random 360];

                                                                        private _dummy = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
                                                                        _dummy hideObject true;
                                                                        _dummy setPosATL _targetPosFireAt;

                                                                        // Stop the unit
                                                                        if (speed _unit > 0.1) then {
                                                                                _unit doMove getPosATL _unit;
                                                                        };

                                                                        // Tell the unit to aim at the dummy
                                                                        _unit reveal _dummy;
                                                                        _unit doTarget objNull;
                                                                        _unit doTarget _dummy;

                                                                        // Wait until the unit is actually aiming at it
                                                                        private _timeOut = _time + 1.5;
                                                                        while {alive _unit and {time < _timeOut}} do {

                                                                                sleep 0.1;

                                                                                // Exit if the unit is already firing
                                                                                if (_unit getVariable ["Cre8ive_SuppressiveAI_Firing", false]) exitWith {};

                                                                                // Run in unscheduled to prevent any issues
                                                                                isNil {
                                                                                        private _dir = vectorNormalized ((ATLtoASL _targetPosFireAt) vectorDiff eyePos _unit);
                                                                                        private _dirWeapon = _unit weaponDirection currentWeapon _unit;

                                                                                        // Check if the unit is(roughly) aiming at the target position
                                                                                        if ((_dir vectorDotProduct _dirWeapon) > 0.995) then {

                                                                                                // If the target can be suppressed again, engage
                                                                                                if (time > _currentTarget getvariable [_nextSuppressVarName, 0]) then {
                                                                                                        _unit doTarget _dummy;
                                                                                                        private _fired = [_unit, currentMuzzle _unit, "Single"] MACRO_CALL(ca_fnc_fireWeaponSafe,"ca\ai\fn_fireWeaponSafe.sqf");

                                                                                                        // If we were able to suppress the target, mark it as being suppressed
                                                                                                        if (_fired) then {
                                                                                                                private _timeFired = time;
                                                                                                                _targetLastSeen = _currentTarget getVariable [_lastSeenVarName, -99999];
                                                                                                                _threatLevel = (1 - (_timeFired - _targetLastSeen) / _maxSuppressionTime) max 0;
                                                                                                                _nextSuppress = _timeFired + (2 + random 1) / _suppressionMul;

                                                                                                                _currentTarget setVariable [_nextSuppressVarName, _timeFired + (((1 - _threatLevel) ^ 2) * 2 + random 0.5) / _suppressionMul, false];
                                                                                                                //systemChat format ["Firing! (threat: %1)", _threatLevel];
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

                                _lastExec = _time;
                        };





                // If the unit is in a vehicle, check if it is simulated
                } else {
                        private _veh = vehicle _unit;

                        if (simulationEnabled _veh and {alive _veh}) then {

                                // Check if the unit is in a new vehicle
                                if (_veh != _lastVeh) then {
                                        _lastVeh = _veh;

                                        // If it hasn't been done yet, add an EH to this vehicle
                                        if !(_veh getVariable ["Cre8ive_SuppressiveAI_FiredEH", false]) then {
                                                _veh addEventHandler ["Fired", {
                                                        params ["_veh", "_weapon"];

                                                        // Save the time each weapon was last fired at
                                                        _veh setVariable [format ["Cre8ive_SuppressiveAI_LastFired_%1", _weapon], time, false];
                                                }];
                                                _veh setVariable ["Cre8ive_SuppressiveAI_FiredEH", true, false];
                                        };

                                        // If it hasn't been done yet, compile the vehicle's weapons
                                        if !(missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_IsCompiled", typeOf _veh], false]) then {
                                                [_veh] MACRO_CALL(ca_fnc_compileVehicleWeapons,"ca\ai\fn_compileVehicleWeapons.sqf");
                                        };
                                };

                                // Scan for new targets
                                private _vehPos = _veh modelToWorldVisualWorld [0,0,0];
                                [ASLtoATL _vehPos] call _findNearestTarget;

                                // If we're allowed to suppress...
                                if (_time > _nextSuppress and {alive _currentTarget}) then {

                                        // Check if the target is a soft or a hard target
                                        if (_lastTarget != _currentTarget) then {
                                                _lastTarget = _currentTarget;

                                                // TODO: Investigate suppression behaviour (without this script) of APCs with missiles against cars (will they fire missiles? or use cannons? if so, should it suppress?) -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                //private _targetClass = [configFile >> "CfgVehicles" >> typeOf _currentTarget, "vehicleClass", ""] call BIS_fnc_returnConfigEntry;
                                                //if (toLower _targetClass in ["men", "mensupport",]) then {
                                                if (_currentTarget isKindOf "Man") then {
                                                        _isSoftTarget = true;
                                                } else {
                                                        _isSoftTarget = false;
                                                };
                                        };

                                        // Only suppress soft targets
                                        if (_isSoftTarget) then {

                                                // If the target's threat level is above 0% and can be suppressed, suppress it
                                                private _targetLastSeen = _currentTarget getVariable [_lastSeenVarName, -99999];
                                                private _threatLevel = (1 - (_time - _targetLastSeen) / _maxSuppressionTime) max 0;
                                                private _targetNextSuppress = _currentTarget getVariable [_nextSuppressVarName, 0];

                                                // If the target's threat level is above 0% and can be suppressed, suppress it
                                                if (_threatLevel > 0 and {_time > _targetNextSuppress}) then {

                                                        private _targetAge = _time - ((_unit targetKnowledge _currentTarget) select 2);
                                                        private _targetAgeGroup = _time - (_currentTarget getVariable [_targetAgeVarName, 0]);

                                                        // If anyone else in the group has more up-to-date information on the target, use their intel instead
                                                        if (_targetAgeGroup <= _targetAge) then {
                                                                _targetAge = _targetAgeGroup;
                                                                _lastTargetPos = _currentTarget getVariable [_targetPosVarName, _lastTargetPos];
                                                        };
                                                        private _lastTargetPosASL = ATLtoASL _lastTargetPos;
                                                        private _targetDist = _vehPos distance _lastTargetPosASL;
                                                        private _ageCutoff = 1 + _targetDist / 70;

                                                        // If the unit has a visual on the target's last position, but not the target, stop suppressing
                                                        if (_targetAge > _ageCutoff and {_targetDist < 300} and {([_veh, "VIEW", _currentTarget] checkVisibility [_vehPos, _lastTargetPosASL]) > 0.1}) then {
                                                                //systemChat format ["Lost target... (age: %1 / ageGroup: %2)", _time - ((_unit targetKnowledge _currentTarget) select 2), _targetAgeGroup];
                                                                _currentTarget setVariable [_lastSeenVarName, -9999, false];
                                                                _currentTarget = objNull;
                                                                _lastTargetPos = [];
                                                                _unit setVariable ["Cre8ive_SuppressiveAI_LastTargetPos", []];

                                                        // Otherwise, we either know, or assume the target is still there...
                                                        } else {
                                                                _unit setVariable ["Cre8ive_SuppressiveAI_LastTargetPos", _lastTargetPosASL];

                                                                // ...so unless the target position is too obstructed (e.g. behind a mountain), we suppress it
                                                                private _shouldSuppress = true;
                                                                private _intersectPosUnit = ((lineIntersectsSurfaces [_vehPos, _lastTargetPosASL, _veh, _currentTarget]) param [0, [], [[]]]) param [0, [], [[]]];
                                                                private _intersectPosTarget = ((lineIntersectsSurfaces [_lastTargetPosASL, _vehPos, _veh, _currentTarget]) param [0, [], [[]]]) param [0, [], [[]]];

                                                                if !(_intersectPosUnit isEqualTo [] or {_intersectPosTarget isEqualTo []}) then {
                                                                        if (_intersectPosUnit distanceSqr _intersectPosTarget > _maxIntersectDistSqr) then {
                                                                                _shouldSuppress = false;
                                                                        };
                                                                };

                                                                if (_shouldSuppress) then {
									private _targetPosFireAt = _lastTargetPos getPos [(((_time - _targetLastSeen) / _maxDispersionDuration) min 0.5) * 2 * ((_targetDist / 3) min (random _maxDispersion)), random 360];

                                                                        // If the target is no longer in sight, stop looking at its last position
                                                                        if (_targetAge > _ageCutoff * 2) then {
                                                                                _unit forgetTarget _currentTarget;
                                                                        };

                                                                        // Look at the last known position
                                                                        if (_time > _nextLookAt) then {
                                                                                _unit lookAt _targetPosFireAt;
                                                                                _nextLookAt = _time + 3 + random 2;
                                                                        };

                                                                        // Fetch the vehicle's weapon data
                                                                        private _vehType = typeOf _veh;
                                                                        private _turretPath = (assignedVehicleRole _unit) param [1, [], [[]]];
                                                                        private _vehMags = missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_Mags_%2", _vehType, _turretPath], []];
                                                                        private _vehWeights = missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_Weights_%2", _vehType, _turretPath], []];
                                                                        private _vehWeapons = missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_Veh_%1_Weapons_%2", _vehType, _turretPath], []];
                                                                        private _cycleDelay = 1;

                                                                        // Pick a random weapon from the turret's pool
                                                                        private _rand = random 1;
                                                                        private _weapon = "";
                                                                        private _magazine = "";
                                                                        private _magazinesAmmo = magazinesAmmo _veh;
                                                                        {
                                                                                private _hasMagazine = false;
                                                                                if (_rand <= _x) then {
                                                                                        private _weaponX = _vehWeapons param [_forEachIndex, "", [""]];
                                                                                        _magazine = _vehMags param [_forEachIndex, "", [""]];
                                                                                        _cycleDelay = missionNamespace getVariable [format ["Cre8ive_SuppressiveAI_CycleDelay_%1", _weaponX], 1];

                                                                                        // Check when this weapon was last used
                                                                                        private _lastFired = _veh getVariable [format ["Cre8ive_SuppressiveAI_LastFired_%1", _weaponX], -999];
                                                                                        if (_time - _lastFired > _cycleDelay) then {

                                                                                                // Check if the vehicle has at least one magazine of this type with ammo left in it
                                                                                                {
                                                                                                        _x params ["_magX", "_ammoX"];

                                                                                                        if (_magazine == _magX) then {
                                                                                                                if (_ammoX > 0) exitWith {
                                                                                                                        _hasMagazine = true;
                                                                                                                        _weapon = _weaponX;
                                                                                                                };
                                                                                                        };
                                                                                                } forEach _magazinesAmmo;
                                                                                        };

                                                                                };

                                                                                // If we found a valid magazine, use this weapon and exit the loop
                                                                                if (_hasMagazine) exitWith {
                                                                                        //systemChat format ["- Rolled %1 < %2 - picked %3: %4", _rand, _x, _forEachIndex, _weapon];
                                                                                };
                                                                        } forEach _vehWeights;

                                                                        // If we found a weapon to use, try aiming at the target
                                                                        if (_weapon != "") then {

                                                                                // Select the weapon (used for AI calculations)
                                                                                _veh selectWeaponTurret [_weapon, _turretPath];

                                                                                // Wait until the unit is actually aiming at it
                                                                                private _timeOut = _time + 1;
                                                                                while {alive _unit and {_veh == vehicle _unit} and {time < _timeOut}} do {

                                                                                        sleep 0.1;

                                                                                        // Run in unscheduled to prevent any issues
                                                                                        private _timeNew = time;
                                                                                        private _canFire = false;
                                                                                        isNil {
                                                                                                private _vehPos = (_veh modelToWorldVisualWorld [0,0,0]);
                                                                                                private _dir = vectorNormalized ((ATLtoASL _targetPosFireAt) vectorDiff _vehPos);
                                                                                                private _dirTurret = [0,0,0];

                                                                                                // Calculate the direction the turret is aiming at
                                                                                                switch (_turretPath) do {
                                                                                                        case [0]: {
                                                                                                        	private _pitch = deg (_veh animationPhase "maingun");
                                                                                                        	private _yaw = 90 + deg (_veh animationPhase "mainturret");
                                                                                                        	_dirTurret = [_pitch, _yaw] call ca_fnc_math_anglesToVector;
                                                                                                                _dirTurret = (_veh modelToWorldVisualWorld _dirTurret) vectorDiff _vehPos;
                                                                                                        };
                                                                                                        default {
                                                                                                                private _yawTurret = deg (_veh animationPhase "mainturret");
                                                                                                        	private _pitch = deg (_veh animationPhase "obsgun");
                                                                                                        	private _yaw = 90 + _yawTurret + deg (_veh animationPhase "obsturret");
                                                                                                        	_dirTurret = [_pitch, _yaw] call ca_fnc_math_anglesToVector;
                                                                                                                _dirTurret = (_veh modelToWorldVisualWorld _dirTurret) vectorDiff _vehPos;
                                                                                                        };
                                                                                                };

                                                                                                // Check if the unit is(roughly) aiming at the target position
                                                                                                if ((_dir vectorDotProduct _dirTurret) > 0.98) then {
                                                                                                        _canFire = true;
                                                                                                };
                                                                                        };

                                                                                        if (_canFire) exitWith {

                                                                                                // Only continue if the target can be suppressed again
                                                                                                if (_timeNew > (_currentTarget getvariable [_nextSuppressVarName, 0])) then {

                                                                                                        // Get the weapon's state
                                                                                                        private _state = weaponState [_veh, _turretPath, _weapon];

                                                                                                        // Get the loaded magazine's type and ammo count
                                                                                                        _state params ["", "", "", ["_currentMag", "", [""]], ["_ammo", 0, [0]]];
                                                                                                        private _ID = -1;
                                                                                                        private _owner = 0;

                                                                                                        // If the currently loaded magazine is of the same type as the one we need, try to find it
                                                                                                        if (_magazine == _currentMag) then {

                                                                                                                // We need the ID of the magazine, for that we iterate through all magazines
                                                                                                                {
                                                                                                                        _x params ["_magazineX", "", "_ammoX", "_IDX", "_ownerX"];

                                                                                                                        // If we found a match, save the data
                                                                                                                        if (_ammo == _ammoX and {_magazine == _magazineX}) exitWith {
                                                                                                                                _ID = _IDX;
                                                                                                                                _owner = _ownerX;
                                                                                                                        };
                                                                                                                } forEach magazinesAllTurrets _veh;

                                                                                                        // Otherwise, we'll look for the magazine with the lowest amount of remaining ammo
                                                                                                        } else {
                                                                                                                _ammo = 999999;
                                                                                                                {
                                                                                                                        _x params ["_magazineX", "", "_ammoX", "_IDX", "_ownerX"];

                                                                                                                        // If we found a match, save the data
                                                                                                                        if (_magazine == _magazineX and {_ammoX < _ammo}) then {
                                                                                                                                _ID = _IDX;
                                                                                                                                _owner = _ownerX;
                                                                                                                                _ammo = _ammoX;
                                                                                                                        };
                                                                                                                } forEach magazinesAllTurrets _veh;
                                                                                                        };

                                                                                                        // Only continue if we found a match
                                                                                                        if (_ammo > 0 and {_ID > 0}) then {

                                                                                                                _ammo = round (((0.5 + random 0.5) / _cycleDelay) min _ammo) max 1;

                                                                                                                // If we are able to suppress the target, mark it as being suppressed
                                                                                                                _targetLastSeen = _currentTarget getVariable [_lastSeenVarName, -99999];
                                                                                                                _threatLevel = (1 - (_timeNew - _targetLastSeen) / _maxSuppressionTime) max 0;
                                                                                                                _nextSuppress = _timeNew + (1 + random 0.5) / _suppressionMul;

                                                                                                                _currentTarget setVariable [_nextSuppressVarName, _timeNew + (((1 - _threatLevel) ^ 2) * 4 + random 0.5) / _suppressionMul, false];
                                                                                                                //systemChat format ["Firing %1 rounds! - Cycle delay: %2 (threat: %3)", _ammo, _cycleDelay, _threatLevel];
                                                                                                                //systemChat " ";

                                                                                                                // Suppress the target
                                                                                                                for "_i" from 1 to _ammo do {
                                                                                                                        if (!alive _veh) exitWith {};

                                                                                                                        // Fire
                                                                                                                        _veh action ["UseMagazine", _veh, _unit, _owner, _ID];

                                                                                                                        // Sleep
                                                                                                                        if (_i < _ammo) then {
                                                                                                                                sleep _cycleDelay;
                                                                                                                        };
                                                                                                                };
                                                                                                        };
                                                                                                };
                                                                                        };
                                                                                };
                                                                        };
                                                                };
                                                        };
                                                };
                                        };
                                };

                                _lastExec = _time;
                        } else {
                                _lastTarget = objNull;
                        };
                };
        };

        sleep 0.45 + random 0.1;
};
