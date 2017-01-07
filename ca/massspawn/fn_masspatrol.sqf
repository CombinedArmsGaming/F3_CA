/*
 * Author: Poulern
 * Spawns ai at each location specified. Each Ai will patrol in the area around it specified by the radius.
 *
 * Arguments:
 * 0: Spawn positions, marker, object, group, location, array
 * 1: F3 group array
 * 2: radius of area to patrol eg 200
 * 3: side of group eg west east independent
 *
 * Return Value:
 * Array of groups spawned.
 *
 * Example:
 * [["FT_AP","FT_AP_1","FT_AP_2","FT_AP_3","FT_AP_4","FT_AP_5"],["ftl","ar","r","r","r"],300,east] call ca_fnc_masspatrol
 *
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };

params ["_locationarray","_unitarray",["_radius", 200, [2]],["_side", ca_defaultside]];
private ["_group","_grouparray"];
_grouparray = [];
{
  _group = [_unitarray,_x,_radius,_side] call ca_fnc_spawnpatrol;
  _grouparray pushback _group;
} forEach _locationarray;
_grouparray
