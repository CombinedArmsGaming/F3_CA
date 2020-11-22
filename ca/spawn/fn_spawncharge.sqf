/*
 * F3 CA edition
 * Function: Spawn CHAAARGE!
 * Spawns a group that charges (attacks without formation, often in a line) a position a set distance away from the origin.
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
 * [["ftl","rif","med","lat","ar","aar"],"SC1_CA",300,"opf_f",east] spawn ca_fnc_spawncharge;
 *
 */

//If the script is not executed on a server or a headless client, exit as it is likely to be executed on all clients, causing more spawns than intended. 
if (!isServer) exitWith {};


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
	[_group, 3, 2] spawn ca_fnc_groupSuppressiveAI;
	[_group] spawn ca_fnc_groupGuerrillaAI;  
};
_group
