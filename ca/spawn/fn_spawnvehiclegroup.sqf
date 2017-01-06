/*
 * Author: Poulern
 * Spawns a vehicle with a crew inside of it
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Vehicle classname
 * 3: Side, west east independent
 *
 * Return Value:
 * Array of [group,vehicle]
 *
 * Example:
 * [["ftl","r","ar","m"],"spawnmarker","C_Offroad_default_F",independent] call ca_fnc_spawnvehiclegroup;
 *
 * Public: [Yes/No]
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };

params ["_unitarray","_position","_vehicletype",["_side", ca_defaultside]];


_vehicle = [_position,_vehicletype] call ca_fnc_spawnvehicle;
_group = [_unitarray,_position,_side,_vehicle] call ca_fnc_spawngroup;
{
_x moveInAny _vehicle;
} forEach (units _group);


[_group,_vehicle]
