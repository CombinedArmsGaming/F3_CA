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
 * Array of all groups spawned
 *
 * Example:
 * [["hill_west","hill_north","hill_east"],["ftl","ar","r","r","r"],"attackmarker","C_Offroad_default_F",east] call ca_fnc_massvehicleattack
 *
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };

 params ["_locationarray","_unitarray","_attackposition","_vehicletype",["_side", ca_defaultside]];
 private ["_group","_grouparray"];

 _grouparray = [];
 {
   _grpvehicle = [_unitarray,_x,_attackposition,_vehicletype,_side] call ca_fnc_spawnvehicleattack;
   _group = _grpvehicle select 0;
   _grouparray pushback _group;
 } forEach _locationarray;
 _grouparray
