params ["_group","_markerarray"];

{
  
    _marker = _x;
    _speed = "FULL";
    _form = "LINE";
    _type = "SAD";
    _markerpos = getMarkerPos _marker;
    _behavior = "COMBAT";
    _combat = "RED";

    [_group, _markerpos, 20, _type, _behavior, _combat, _speed, _form, "", [0,0,0]] call CBA_fnc_addWaypoint;

} forEach _markerarray;
