/*
 * Author: Poulern
 * Spawns a group that charges(attacks without formation, often in a line) a position a set distance away from the origin.
 * You must include a direction in the location parameter(IE have it be a marker, object or make the array look like this: [[2334,3242,0],90]) or else the group will charge north.
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 2: side of group
 * 3: Distance to charge. Recommended fall just a bit short of target. Set in meters
 *
 * Return Value:
 * Group.
 *
 * Example:
 * [["ftl","r","m","rat","ar","aar"],"spawnmarker",300,independent] call ca_fnc_spawncharge;
 *
 */
_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if no headless, and is player, spawn on server instead
if (!ca_hc && hasInterface) then {
	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
};

params ["_unitarray","_position","_attackdistance",["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_side] call ca_fnc_spawngroup;
_posdir = _position call ca_fnc_getdirpos;
_origo = _posdir select 0;
_attackdir = _posdir select 1;

_attackvector = _origo getpos [_attackdistance,_attackdir];
{
  _x allowFleeing 0;
	_x doMove _attackvector;
  _x setspeedmode "FULL";
  _x setbehaviour "SAFE";
  _x setskill ["spotDistance",0.1];
  _x setskill ["spotTime",0.1];
  _x setskill ["courage",1];
  _x setskill ["commanding",0.1];
  _x setskill ["general",0.1];
} forEach (units _group);

_group
