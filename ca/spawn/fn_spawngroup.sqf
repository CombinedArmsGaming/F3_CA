
/*
 * Author: Poulern
 * Spawns a group according to F3 assign gear
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Faction of group used in F3.
 * 2: Side west east independent
 *
 * Return Value:
 * Group
 *
 * Example:
 * [["ftl","r","ar","m"],"spawnmarker","opf_f",west] spawn ca_fnc_spawngroup;
 * [["ftl","r","ar","m"],player,"opf_f",west] spawn ca_fnc_spawngroup;
 * [["ftl","r","ar","m"],[123,67,0],"blu_f",east] spawn ca_fnc_spawngroup;
 */

params ["_unitarray","_position",["_faction",""],["_side", ca_defaultside]];
private ["_spawnpos","_unittype","_unit","_group","_posdir","_unittype"];

_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if there is no headless client, and is player, spawn on the server instead.
if (!ca_hc && hasInterface && !isServer) exitWith {
     [_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

//Getting a good position from the parsed values
_posdir = _position call ca_fnc_getdirpos;
_spawnpos = _posdir select 0;

switch(_side) do {
	case west: {_group = createGroup [west,true]; _unittype = "B_Soldier_F";};
	case east: {_group = createGroup [east,true]; _unittype = "O_Soldier_F";};
	case independent: {_group = createGroup [independent,true]; _unittype = "I_Soldier_F";};
	default {_group = createGroup [east,true]};
};


{
	_unit = "";
	_unit = _group createUnit [_unittype, _spawnpos, [], 0, "FORM"];
  if (_faction == "") then { _faction = faction _unit; };
	_type = _x;
	[_type,_unit,_faction] call f_fnc_assignGear;
} forEach _unitarray;

[_group] call CBA_fnc_clearWaypoints;
_group setFormation "LINE";
_group
