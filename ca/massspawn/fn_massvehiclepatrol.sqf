/*
 * Author: Poulern
 * Spawns patrolling vehicle borne AI on each of the markers provided in an array.
 *
 * Arguments:
 * 0: An array of markers ["mkr","mkr_1","mkr_2","mkr_3"]
 * 1: array of units according to F3 ["ftl","r","ar","aar","rat"]
 * 2: Vehicle classname
 * 3: radius of area to patrol eg 200
 * 4: Faction of group used in F3 Assigngear.
 * 5: Side of units spawned, west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["SC1_VC_P","SC1_VC_P_1","SC1_VC_P_2","SC1_VC_P_3","SC1_VC_P_4","SC1_VC_P_5"],["ftl","ar","r","r","r"],"C_Offroad_default_F",300,"opf_f",east] spawn ca_fnc_massvehiclepatrol
 *
 */
params ["_locationarray","_unitarray","_vehicletype",["_radius", 200, [2]],["_faction",""],["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
 [_unitarray,_x,_vehicletype,_radius,_faction,_side] call ca_fnc_spawnvehiclepatrol;
} forEach _locationarray;
