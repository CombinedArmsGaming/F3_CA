/*
 * F3 CA edition
 * Function: Spawn patrol
 * Spawns a group that patrols an area
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 2: radius of area to patrol eg 200
 * 3: Faction of group used in F3.
 * 4: side of group eg west east independent
 *
 * Return Value:
 * Group.
 *
 * Example:
 * [["ftl","rif","med","lat","ar","aar"],"SC1_FT_AP",200,"opf_f",east] spawn ca_fnc_spawnpatrol;
 *
 */

//If the script is not executed on a server or a headless client, exit as it is likely to be executed on all clients, causing more spawns than intended. 
if (!isServer) exitWith {};


params ["_unitarray","_position",["_radius", 200, [2]],["_faction",""],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
_posdir = _position call ca_fnc_getdirpos;
_patrolpos = _posdir select 0;

_group setBehaviour "SAFE";

[_group, _patrolpos,_radius,4,[],true] call lambs_wp_fnc_taskPatrol;

_group
