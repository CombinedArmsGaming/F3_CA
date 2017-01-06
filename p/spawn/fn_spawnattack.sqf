/*
 * Author: Poulern
 * Spawns a group that attacks an area
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 2: side of group
 * 3: area marker to attack/search
 * 4: behaviour of group, eg "CARELESS","SAFE","AWARE","COMBAT","STEALTH"
 * 5: combat mode, eg "BLUE","GREEN","WHITE","YELLOW","RED"
 * 6: speed of group "LIMITED","NORMAL","FULL"
 * 7: formation aka "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE" or "LINE"
 * 8: Oncomplete code to run when done: aka ignore this
 * 9: timeout, but ignore this one as well.
 * Return Value:
 * Nothing.
 *
 * Example:
 * [["ftl","r","m","rat","ar","aar"],"spawnmarker",independent,"attackmarker","SAFE","GREEN","FULL","STAG COLUMN"] call p_fnc_spawnattack;
 *
 * Public: [Yes/No]
 */

params ["_unitarray","_position","_side","_marker",
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_onComplete", "", [""]],
    ["_timeout", [0,0,0], [[]], 3]];
private ["_group"];
_group = [_unitarray,_position,_side] call p_fnc_spawngroup;


[_group,_marker,_behaviour,_combat,_speed,_formation,_onComplete,_timeout] call CBA_fnc_taskSearchArea;
