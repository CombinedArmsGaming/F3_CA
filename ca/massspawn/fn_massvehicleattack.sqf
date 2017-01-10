/*
 * Author: Poulern
 * Spawns a vehicle that attacks a location or area.
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Marker, position or location to attack. If marker is type of area, then it will use that instead.
 * 3: Vehicle classname
 * 4: Side, west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["hill_west","hill_north","hill_east"],["ftl","ar","r","r","r"],"attackmarker","C_Offroad_default_F",east] call ca_fnc_massvehicleattack
 *
 */
params ["_locationarray","_unitarray","_attackposition","_vehicletype",["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
 [_unitarray,_x,_attackposition,_vehicletype,_side] call ca_fnc_spawnvehicleattack;
} forEach _locationarray;
