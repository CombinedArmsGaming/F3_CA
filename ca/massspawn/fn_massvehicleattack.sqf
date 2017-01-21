/*
 * Author: Poulern
 * Spawns a vehicle that attacks a location or area.
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Marker, position or location to attack. If marker is type of area, then it will use that instead.
 * 3: Vehicle classname
 * 4: Faction of group used in F3 Assigngear.
 * 5: Side of units spawned, west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["SC1_CA","SC1_CA_1","SC1_CA_2"],["ftl","ar","r","r","r"],"SC1_CA_A","C_Offroad_default_F","opf_f",east] spawn ca_fnc_massvehicleattack
 *
 */
params ["_locationarray","_unitarray","_attackposition","_vehicletype",["_faction",""],["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
 [_unitarray,_x,_attackposition,_vehicletype,_faction,_side] call ca_fnc_spawnvehicleattack;
} forEach _locationarray;
