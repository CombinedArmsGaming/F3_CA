
/*
 * F3 CA edition
 * Function: Spawn Group 
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
 * [["ftl","rif","med","lat","ar","aar"],"spawnmarker","opf_f",west] spawn ca_fnc_spawngroup;
 * [["ftl","rif","med","lat","ar","aar"],player,"opf_f",west] spawn ca_fnc_spawngroup;
 * [["ftl","rif","med","lat","ar","aar"],[123,67,0],"blu_f",east] spawn ca_fnc_spawngroup;
 */

params ["_unitarray","_position",["_faction",""],["_side", ca_defaultside]];
private ["_spawnpos","_unittype","_unit","_group","_posdir","_unittype"];

//If the script is not executed on a server or a headless client, exit as it is likely to be executed on all clients, causing more spawns than intended. 
if (!isServer) exitWith {};


//Getting a good position from the parsed values
_posdir = _position call ca_fnc_getdirpos;
_spawnpos = _posdir select 0;

/* 
Unit identity options
Classnames to use for specific nationality combinations, gear is irrelevant as the unit gets stripped down by assignGear anyway
Be mindful of mod dependencies if editing Vanilla+, WW2, etc

American: rhsusf_usmc_marpat_wd_rifleman_m4
British: UK3CB_BAF_Rifleman_DPMW
Russian: rhs_vdv_rifleman
Greek: I_Soldier_F
African/ Tanoan French: O_GEN_Soldier_F
Middle Eastern: O_Soldier_F
African: UK3CB_ADA_B_RIF_1
East Asian: C_man_polo_1_F_asia

*/

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
