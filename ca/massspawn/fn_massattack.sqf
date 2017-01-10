/*
 * Author: Poulern
 * Spawns ai at different markers at makes them attack the same position. Attack position can either be point(marker, location etc) or area marker.
 *
 * Arguments:
 * 0: Spawn positions, marker, object, group, location, array
 * 1: F3 group array
 * 2: Marker or point to attack.
 * 3: side, west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["hill_west","hill_north","hill_east"],["ftl","ar","r","r","r"],"attackmarker",east] call ca_fnc_massattack
 *
 */
params ["_locationarray","_unitarray","_attackposition",["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
  [_unitarray,_x,_attackposition,_side] call ca_fnc_spawnattack;
} forEach _locationarray;
