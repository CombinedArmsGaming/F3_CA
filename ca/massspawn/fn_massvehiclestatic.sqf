/*
 * Author: Poulern
 * Spawns a static vehicle on each location specified. Vehicle has no fuel, so cannot move.
 *
 * Arguments:
 * 0: An array of markers ["mkr","mkr_1","mkr_2","mkr_3"]
 * 1: array of units according to F3 ["ftl","r","ar","aar","rat"]
 * 2: Vehicle classname
 * 2: side of group eg west east independent
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [["VC_BF","VC_BF_1","VC_BF_2","VC_BF_3","VC_BF_4","VC_BF_5"],["ftl","ar","r","r","r"],"C_Offroad_default_F",east] call ca_fnc_massvehiclestatic
 *
 */
params ["_locationarray","_unitarray","_vehicletype",["_side", ca_defaultside]];
private ["_group","_grouparray"];

{
  [_unitarray,_x,_vehicletype,_side] call ca_fnc_spawnvehiclestatic;
} forEach _locationarray;
