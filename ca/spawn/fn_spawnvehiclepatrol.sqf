/*
 * Author: Poulern
 * Spawns a vehicle that patrols an area in a radius from spawnpoint.
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Vehicle classname
 * 2: radius of area to patrol eg 200
 * 3: side of group eg west east independent
 *
 * Return Value:
 * Array of [group,vehicle]
 *
 * Example:
 * [["ftl","r","ar","m"],"spawnmarker","C_Offroad_default_F",500,independent] call ca_fnc_spawnvehiclepatrol;
 *
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };

params ["_unitarray","_position","_vehicletype",["_radius", 200, [2]],["_side", ca_defaultside]];

private ["_group"];
_grpvehicle = [_unitarray,_position,_vehicletype,_side] call ca_fnc_spawnvehiclegroup;
_group = _grpvehicle select 0;
_posdir = _position call ca_fnc_getdirpos;
_patrolpos = _posdir select 0;

[_group, _patrolpos,_radius] call CBA_fnc_taskPatrol;

_grpvehicle
