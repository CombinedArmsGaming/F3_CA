/*
 * Author: Poulern
 * Spawns a group of ai at location for each location. Groups will mount nearby static machine guns and bunker in nearby buildings.
 *
 * Arguments:
 * 0: Spawn positions, marker, object, group, location, array
 * 1: F3 group array
 * 2: side, west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["FT_AF","FT_AF_1","FT_AF_2","FT_AF_3"],["ftl","ar","r","r","r"],east] call ca_fnc_massfortify
 *
 */
params ["_locationarray","_unitarray",["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
  [_unitarray,_x,_side] call ca_fnc_spawnfortify;
} forEach _locationarray;
