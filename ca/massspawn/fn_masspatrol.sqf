/*
 * Author: Poulern
 * Spawns ai at each location specified. Each Ai will patrol in the area around it specified by the radius.
 *
 * Arguments:
 * 0: Spawn positions, marker, object, group, location, array
 * 1: F3 group array
 * 2: radius of area to patrol eg 200
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["SC1_FT_AP","SC1_FT_AP_1","SC1_FT_AP_2","SC1_FT_AP_3","SC1_FT_AP_4"],["ftl","ar","r","r","r"],300,"opf_f",east] spawn ca_fnc_masspatrol
 *
 */
params ["_locationarray","_unitarray",["_radius", 200, [2]],["_faction",""],["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
  [_unitarray,_x,_radius,_faction,_side] call ca_fnc_spawnpatrol;
} forEach _locationarray;
