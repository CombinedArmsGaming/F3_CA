/*
 * Author: Poulern
 * Spawns a group that patrols an area
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 2: radius of area to patrol eg 200
 * 3: side of group eg west east independent
 *
 * Return Value:
 * Group.
 *
 * Example:
 * [["ftl","r","m","rat","ar","aar"],"spawnmarker",200,independent] call ca_fnc_spawnpatrol;
 *
 */
 _ishc = !hasInterface && !isDedicated;
 //Use headless instead?
 if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 //if no headless, and is player, spawn on server instead
 if (!ca_hc && hasInterface) then {
 	if (!isServer) exitWith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
 };

params ["_unitarray","_position",["_radius", 200, [2]],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_side] call ca_fnc_spawngroup;
_posdir = _position call ca_fnc_getdirpos;
_patrolpos = _posdir select 0;

[_group, _patrolpos,_radius] call CBA_fnc_taskPatrol;

_group
