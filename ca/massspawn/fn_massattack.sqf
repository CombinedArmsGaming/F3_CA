/*
 * Author: Poulern
 * Spawns ai at different markers at makes them attack the same position. Attack position can either be point(marker, location etc) or area marker.
 *
 * Arguments:
 * 0: Spawn positions, marker, object, group, location, array
 * 1: F3 group array
 * 2: Marker or point to attack.
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["SC1_CA","SC1_CA_1","SC1_CA_2"],["ftl","ar","r","r","r"],"SC1_CA_A","opf_f",east] spawn ca_fnc_massattack
 *
 */
params ["_locationarray","_unitarray","_attackposition",["_faction",""],["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
  [_unitarray,_x,_attackposition,_faction,_side] call ca_fnc_spawnattack;
} forEach _locationarray;
