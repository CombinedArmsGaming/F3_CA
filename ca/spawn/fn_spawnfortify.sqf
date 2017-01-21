/*
 * Author: Poulern
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
 * [["ftl","r","m","rat","ar","aar"],"SC1_FT_BF","opf_f",east] spawn ca_fnc_spawnfortify;
 *
 */
_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if there is no headless client, and is player, spawn on the server instead.
if (!ca_hc && hasInterface && !isServer) exitWith {
		[_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

params ["_unitarray","_position",["_faction",""],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
[_group,_group,50,1,false] call CBA_fnc_taskDefend;

_group
