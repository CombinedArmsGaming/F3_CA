/*
 * Function: spawnvehiclestatic
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
 * [["ftl","rif","med","lat","ar","aar"],"SC1_VC_S","C_Offroad_default_F","opf_f",east] spawn ca_fnc_spawnvehiclestatic;
 *
 */

//If the script is not executed on a server or a headless client, exit as it is likely to be executed on all clients, causing more spawns than intended. 
if (!isServer) exitWith {};


params ["_unitarray","_position","_vehicletype",["_faction",""],["_side", ca_defaultside]];
private ["_grpvehicle","_vehicle","_spawnpos"];


_grpvehicle = [_unitarray,_position,_vehicletype,_faction,_side] call ca_fnc_spawnvehiclegroup;
_group = _grpvehicle select 0;
_vehicle = _grpvehicle select 1;
_vehicle setFuel 0;
_group call CBA_fnc_clearWaypoints;

_grpvehicle
