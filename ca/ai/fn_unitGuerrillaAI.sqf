/*
========================================================================================================================================
        AUTHOR:
                Cre8or
========================================================================================================================================
        DESCRIPTION:
                Enables guerrilla AI behaviour on a single unit.
========================================================================================================================================
        ARGUMENTS:
                0:      (OBJECT) Unit
                        Default: N/A
                        The unit to apply the guerrilla AI behaviour on.
                ------------------------------------------------------------------------------------------------------------------------
                1:      (BOOL) Flank only
                        Default: false
                        Whether or not the AI should only ever flank its target.
                        A group of AI that is set to only flank will frequently break up into two teams when approaching a target, with
                        one team approaching from the left, and one from the right. With flanking disabled, the group will scatter evenly
                        and attempt to approach as a line formation.
                ------------------------------------------------------------------------------------------------------------------------
                2:      (NUMBER) Maximum approach variation
                        Default: 45
                        Maximum angle (in degrees) that the AI is willing to deviate from the direct Line-Of-Sight to the target. Higher
                        values mean the AI will approach from further away (useful for flanking), while lower numbers will make it
                        approach more directly (useful for rushing/chasing).
                        NOTE: Do not set this to more than 90, or the AI will orbit around the target, or even run away from it.
                ------------------------------------------------------------------------------------------------------------------------
                3:      (NUMBER) Maximum search duration
                        Default: 30
                        Maximum duration (in seconds) that the AI will spend sweeping the last known location of a target before reporting
                        it as missing.
                        NOTE: If the target is still in the vicinity (but the AI can't see it) the AI will know about its presence, and
                        will not give up searching for it unless it manages to sneak away.
                ------------------------------------------------------------------------------------------------------------------------
                4:      (NUMBER) Maximum approach distance
                        Default: 1000
                        Guerrila units won't chase or approach targets that are farther away than this distance. Useful for making units
                        follow waypoints further before breaking off to go after hostiles (100 or 200 meters). Also useful for makin
                        units chase down snipers that are a few kilometers away (provided the AI is aware of the sniper), by setting the
                        distance to a really large number (like 5000 meters)

========================================================================================================================================
        EXAMPLES:
                        [this] spawn ca_fnc_unitGuerrillaAI                             // inside a unit's init field
                ------------------------------------------------------------------------------------------------------------------------
                        [_unit, true, 60] spawn ca_fnc_unitGuerrillaAI                  // inside a script, where _unit is a unit
                ------------------------------------------------------------------------------------------------------------------------
                        {
                                [_x, false, 30, 60] spawn ca_fnc_unitGuerrillaAI
                        } forEach allUnits;                                             // inside a script, where _unit is a unit
========================================================================================================================================
*/





// Fetch the paramters
params [["_unit", objNull, [objNull]], ["_flankOnly", false, [false]], ["_maxApproachVariation", 45, [45]], ["_maxApproachDistance", 1000, [1000]], ["_maxSearchDuration", 30, [30]]];

// Exit if the unit is a player, or if it already uses guerrilla AI
if (_unit getVariable ["Cre8ive_GuerrillaAI", false] or {isPlayer _unit}) exitWith {};

// If this function is being called by a client, offload it to the server (to compensate for disconnecting/crashing/game-freezing players)
if (!isServer) exitWith {_this remoteExec ["ca_fnc_unitGuerrillaAI", 2, false]};





// Set up some variables
private _hasTarget = false;
private _minDist = 50;
private _minDist2 = _minDist * 2;
private _minDistSqr = (_minDist + 10)  ^ 2;
private _approachVariation = 0;
private _timeOut = -1;
private _lastTargetHeight = 0;
private _lastTargetSpeedSqr = 0;
private _lastTargetIsAircraft = false;
private _maxApproachDistanceSqr = _maxApproachDistance ^ 2;

// Flag this unit to inform that it can use the guerrilla AI (future proofing)
_unit setVariable ["Cre8ive_GuerrillaAI", true, true];

// The meat of this function
while {alive _unit} do {

        // Only continue if the unit is simulated and currently on foot
        if (simulationEnabled _unit and {vehicle _unit == _unit}) then {

                private _unitPos = getPosATL _unit;
                private _group = group _unit;
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
                                _lastTargetHeight = _targetPosReal select 2;
                                _lastTargetSpeedSqr = vectorMagnitudeSqr velocity _target;
                                _lastTargetIsAircraft = typeOf _target isKindOf "Air";
                        };

                        // Only proceed if the target isn't a fast-moving vehicle (> 36 km/h) or in flight
                        if !((_lastTargetHeight > 20 and _lastTargetIsAircraft) or _lastTargetSpeedSqr > 100) then {

                                // If the unit just picked up a target, transition into guerrilla behaviour
                                if (!_hasTarget) then {
                                        _unit reveal [_target, 4];
                                        _group allowFleeing 0;

                                        // Pick an approach method depending on the provided settings
                                        if (_flankOnly) then {
                                                _approachVariation = [_maxApproachVariation, -_maxApproachVariation] select (random 1 < 0.5);
                                        } else {
                                                _approachVariation = _maxApproachVariation - random (_maxApproachVariation * 2);
                                        };
                                        _hasTarget = true;
                                };

                                // Make the AI get ready to run
                                _unit setUnitPos "AUTO";
                                _unit setBehaviour "AWARE";

                                // Give the AI infinite sprint to compensate for their slow path finding
                                _unit setStamina 0;

                                // Calculate the target distance (squared) and direction
                                private _targetDistSqr = _unitPos distanceSqr _targetPos;
                                private _targetDir = _unitPos getDir _targetPos;

                                // Add the approach variation into the equation
                                _approachVariation = ((_approachVariation + 5 - random 10) min _maxApproachVariation) max -_maxApproachVariation;
                                _targetDir = _targetDir + _approachVariation;

                                // Determine the AI's next position and move it there
                                private _newPos = [];
                                if (_targetDistSqr > _minDistSqr) then {
                                        _timeOut = -1;
                                        _newPos = _unitPos vectorAdd ([sin _targetDir, cos _targetDir, 0] vectorMultiply (30 + random 20));

                                // If the unit is close enough, make it roam the target area
                                } else {
                                        if (_timeOut < 0) then {
                                                _timeOut = time;
                                        } else {
                                                // Abort the search if it's taking too long, and forget the target
                                                if (time - _timeOut > _maxSearchDuration and {_unitPos distanceSqr _target > _minDistSqr}) then {
                                                        _unit forgetTarget _target;
                                                        _timeOut = -1;
                                                };
                                        };
                                        _newPos = _targetPos vectorAdd [_minDist - random _minDist2, _minDist - random _minDist2, 0];
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
                        };
                };
        };

        // Repeat only every 7 to 10 seconds for performance's sake
        sleep (7 + random 3);
};
