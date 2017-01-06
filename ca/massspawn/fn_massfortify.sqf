/*
 * Author: Poulern
 * Spawns a group of ai at location for each location. Groups will mount nearby static machine guns and bunker in nearby buildings.
 *
 * Arguments:
 * 0: Spawn positions, marker, object, group, location, array
 * 1: F3 group array
 * 2: side, west east independent
 *
 * Return Value:
 * Array of all groups spawned
 *
 * Example:
 * [["FT_AF","FT_AF_1","FT_AF_2","FT_AF_3"],["ftl","ar","r","r","r"],east] call ca_fnc_massfortify
 *
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };

params ["_locationarray","_unitarray",["_side", ca_defaultside]];
  private ["_group","_grouparray"];

  _grouparray = [];
{
  _group = [_unitarray,_x,_side] call ca_fnc_spawngroup;

  [_group,_group,50,1,false] call CBA_fnc_taskDefend;
  _grouparray pushback _group;
} forEach _locationarray;
_grouparray
