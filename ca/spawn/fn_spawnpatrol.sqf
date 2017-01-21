/*
 * Author: Poulern
 * Spawns a group that patrols an area
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 2: radius of area to patrol eg 200
 * 3: Faction of group used in F3.
 * 4: side of group eg west east independent
 *
 * Return Value:
 * Group.
 *
 * Example:
 * [["ftl","r","m","rat","ar","aar"],"SC1_FT_AP",200,"opf_f",east] spawn ca_fnc_spawnpatrol;
 *
 */
_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if there is no headless client, and is player, spawn on the server instead.
if (!ca_hc && hasInterface && !isServer) exitWith {
    [_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

params ["_unitarray","_position",["_radius", 200, [2]],["_faction",""],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
_posdir = _position call ca_fnc_getdirpos;
_patrolpos = _posdir select 0;

[_group, _patrolpos,_radius] call CBA_fnc_taskPatrol;

_group
