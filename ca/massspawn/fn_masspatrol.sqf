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
 * Nothing
 *
 * Example:
 * [["FT_AP","FT_AP_1","FT_AP_2","FT_AP_3","FT_AP_4","FT_AP_5"],["ftl","ar","r","r","r"],300,east] call ca_fnc_masspatrol
 *
 */
params ["_locationarray","_unitarray",["_radius", 200, [2]],["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
  [_unitarray,_x,_radius,_side] call ca_fnc_spawnpatrol;
} forEach _locationarray;
