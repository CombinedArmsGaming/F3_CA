/*
 * Author: Poulern
 * Spawns a group that charges(attacks without formation, often in a line) a position a set distance away from the origin.
 * You must include a direction in the location parameter(IE have it be a marker, object or make the array look like this: [[2334,3242,0],90]) or else the group will charge north.
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 3: Distance to charge. Recommended fall just a bit short of target. Set in meters
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Group.
 *
 * Example:
 * [["ftl","r","m","rat","ar","aar"],"SC1_CA",300,"opf_f",east] spawn ca_fnc_spawncharge;
 *
 */
_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if there is no headless client, and is player, spawn on the server instead.
if (!ca_hc && hasInterface && !isServer) exitWith {
		[_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

params ["_unitarray","_position","_attackdistance",["_faction",""],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
_posdir = _position call ca_fnc_getdirpos;
_origo = _posdir select 0;
_attackdir = _posdir select 1;

_attackvector = _origo getpos [_attackdistance,_attackdir];
[_group,_attackvector] spawn {
	params ["_group","_attackvector"];
	[_group] call CBA_fnc_clearWaypoints;
	[_group, _attackvector, 50, "SAD", "AWARE", "RED","FULL","LINE","this spawn CBA_fnc_searchNearby"] call CBA_fnc_addWaypoint;
	uisleep 5;
	{
	  _x allowFleeing 0;
		_x doMove _attackvector;
	  _x setspeedmode "FULL";
	  _x setbehaviour "AWARE";
	  _x setskill ["spotDistance",0.1];
	  _x setskill ["spotTime",0.1];
	  _x setskill ["courage",1];
	  _x setskill ["commanding",0.1];
	  _x setskill ["general",0.1];
	} forEach (units _group);
};
_group
