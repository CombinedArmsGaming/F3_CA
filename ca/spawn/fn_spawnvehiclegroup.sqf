/*
 * Author: Poulern
 * Spawns a vehicle with a crew inside of it
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
 * [["ftl","r","ar","m"],"SC1_VC_S","C_Offroad_default_F","opf_f",east] spawn ca_fnc_spawnvehiclegroup;
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


_vehicle = [_position,_vehicletype] call ca_fnc_spawnvehicle;
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
{
_x moveInAny _vehicle;
} forEach (units _group);


[_group,_vehicle]
