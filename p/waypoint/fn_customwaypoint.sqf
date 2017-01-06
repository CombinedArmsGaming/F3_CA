params ["_group","_markerarray","_radius","_type","_behavior","_combat","_speed","_form","_code","_timeout","_comprad"];

{
    _marker = _x;
    _markerpos = getMarkerPos _marker;

  [_group, _markerpos, _radius, _type, _behavior, _combat, _speed, _form, _code, _timeout,_comprad] call CBA_fnc_addWaypoint;

} forEach _markerarray;

/*
params [
    ["_group", objNull, [objNull,grpNull]],
    ["_area", "", ["",objNull]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_onComplete", "", [""]],
    ["_timeout", [0,0,0], [[]], 3]
];
[_x,_marker,_]

CBA_fnc_taskSearchArea
*/
