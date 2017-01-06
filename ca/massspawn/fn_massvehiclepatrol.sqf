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
 * Return Value:
 * Array of all groups spawned
 *
 * Example:
 * [["VC_BP","VC_BP_1","VC_BP_2","VC_BP_3","VC_BP_4","VC_BP_5"],["ftl","ar","r","r","r"],"C_Offroad_default_F",300,east] call ca_fnc_massvehiclepatrol
 *
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };


 params ["_locationarray","_unitarray","_vehicletype",["_radius", 200, [2]],["_side", ca_defaultside]];
 private ["_group","_grouparray"];

 _grouparray = [];
 {
   _grpvehicle = [_unitarray,_x,_vehicletype,_radius,_side] call ca_fnc_spawnvehicleattack;
   _group = _grpvehicle select 0;
   _grouparray pushback _group;
 } forEach _locationarray;
 _grouparray
