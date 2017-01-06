/*
 * Author: Poulern
 * Spawns ai at different markers at makes them attack the same position. Attack position
 *
 * Arguments:
 * 0: Spawn positions, marker, object, group, location, array
 * 1: F3 group array
 * 2: Marker or point to attack.
 * 3: side, west east independent
 *
 * Return Value:
 * Array of groups spawned.
 *
 * Example:
 * [["hill_west","hill_north","hill_east"],["ftl","ar","r","r","r"],"attackmarker",east] call ca_fnc_massattack
 *
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };

params ["_locationarray","_unitarray","_attackposition",["_side", ca_defaultside]];
private ["_group","_grouparray"];

_grouparray = [];
{
  _group = [_unitarray,_x,_attackposition,_side] call ca_fnc_spawnattack;
  _grouparray pushback _group;
} forEach _locationarray;
_grouparray
