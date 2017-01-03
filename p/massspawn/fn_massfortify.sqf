params ["_markerarray","_unitarray","_side"      ];
  private ["_group"];
{
  _group = [_unitarray,_x,_side] call p_fnc_spawngroup;

  _marker = _x;
  _spawnpos = markerPos _marker;

  [_group] call CBA_fnc_taskDefend;



} forEach _markerarray;
