/*
 * F3 CA edition
 * Function: Spawn fortify.
 * Spawns a group that fortifies a location or area.
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Group.
 *
 * Example:
 * [["ftl","rif","med","lat","ar","aar"],"SC1_FT_BF","opf_f",east] spawn ca_fnc_spawnfortify;
 *
 */

//If the script is not executed on a server or a headless client, exit as it is likely to be executed on all clients, causing more spawns than intended. 
if (!isServer) exitWith {};


params ["_unitarray","_position",["_faction",""],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
[_group,_position,50] call lambs_wp_fnc_taskGarrison;

_group
