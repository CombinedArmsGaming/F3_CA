params ["_group","_markerarray"];

{
    _marker = _x;
    _speed = "NORMAL";
    _form = "STAG COLUMN";
    _type = "MOVE";
    _markerpos = getMarkerPos _marker;
    _behavior = "AWARE";
    _combat = "WHITE";
    _markerarraycount = count _markerarray -1;
    _lastmarker =  _forEachIndex == _markerarraycount;

    [_group, _markerpos, 20, _type, _behavior, _combat, _speed, _form, "", [0,0,0]] call CBA_fnc_addWaypoint;

      if (_lastmarker) then {
      _origmarker = _markerarray select 0;
      _markerpos1 = getMarkerPos _origmarker;
      [_group, _markerpos1, 20, "CYCLE", _behavior, _combat, _speed, _form, "", [0,0,0]] call CBA_fnc_addWaypoint;
      };

} forEach _markerarray;
