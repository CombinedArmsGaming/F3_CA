/*
 * Author: Poulern
 * Spawns a group that attacks an area
 *
 * Arguments:
 * 0: array of units
 * 1: spawn marker
 * 2: Vehicle classname.
 * 3: side of group
 * 4: area marker to attack/search
 * 5: behaviour of group, eg "CARELESS","SAFE","AWARE","COMBAT","STEALTH"
 * 6: combat mode, eg "BLUE","GREEN","WHITE","YELLOW","RED"
 * 7: speed of group "LIMITED","NORMAL","FULL"
 * 8: formation aka "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE" or "LINE". ignore
 * 9: Oncomplete code to run when done: aka ignore this
 * 10: timeout, but ignore this one as well.
 * Return Value:
 * Nothing.
 *
 * Example:
 * [["vc","vg","vd"],"spawnmarker","rhs_uaz_spg9_chdkz",independent,"attackmarker"] call p_fnc_spawnvehattack;
 * [["ftl","r","m","rat","ar","aar"],"spawnmarker",independent,"attackmarker"] call p_fnc_spawnattack;
 * Public: [Yes/No]
 */

params ["_unitarray","_spawnmarker","_classname","_side","_attackmarker"];
private ["_group","_attackmarkerpos"];
_group = [_spawnmarker,_classname,_side,_unitarray] call p_fnc_spawnvehicle;

_attackmarkerpos = getMarkerPos _attackmarker;
[_group,_attackmarkerpos] call BIS_fnc_taskAttack;
