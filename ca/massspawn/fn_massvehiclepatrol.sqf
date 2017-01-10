/*
 * Author: Poulern
 * Spawns patrolling vehicle borne AI on each of the markers provided in an array.
 *
 * Arguments:
 * 0: An array of markers ["mkr","mkr_1","mkr_2","mkr_3"]
 * 1: array of units according to F3 ["ftl","r","ar","aar","rat"]
 * 2: Vehicle classname
 * 3: radius of area to patrol eg 200
 * 4: side of group eg west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["VC_BP","VC_BP_1","VC_BP_2","VC_BP_3","VC_BP_4","VC_BP_5"],["ftl","ar","r","r","r"],"C_Offroad_default_F",300,east] call ca_fnc_massvehiclepatrol
 *
 */
params ["_locationarray","_unitarray","_vehicletype",["_radius", 200, [2]],["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
 [_unitarray,_x,_vehicletype,_radius,_side] call ca_fnc_spawnvehiclepatrol;
} forEach _locationarray;
