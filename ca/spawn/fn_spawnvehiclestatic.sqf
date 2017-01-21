/*
 * Author: Poulern
 * Creates a static vehicle that sort of sits there idle because its out of fuel.
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Vehicle classname
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Array of [group,vehicle]
 *
 * Example:
 * [["ftl","r","ar","m"],"SC1_VC_S","C_Offroad_default_F","opf_f",east] spawn ca_fnc_spawnvehiclestatic;
 *
 */
_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if there is no headless client, and is player, spawn on the server instead.
if (!ca_hc && hasInterface && !isServer) exitWith {
     [_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

params ["_unitarray","_position","_vehicletype",["_faction",""],["_side", ca_defaultside]];
private ["_grpvehicle","_vehicle","_spawnpos"];


_grpvehicle = [_unitarray,_position,_vehicletype,_faction,_side] call ca_fnc_spawnvehiclegroup;
_group = _grpvehicle select 0;
_vehicle = _grpvehicle select 1;
_vehicle setFuel 0;
_group call CBA_fnc_clearWaypoints;

_grpvehicle
