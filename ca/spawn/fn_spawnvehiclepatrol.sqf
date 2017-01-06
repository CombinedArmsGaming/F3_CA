//ex [["detendion","detendion_1","detendion_2","detendion_1_1"],"rhs_t72ba_tv",east] call p_fnc_spawnfortvehgroup

params ["_unitarray","_marker","_side","_radius","_tanktype"
      ];
  private ["_group"];


  _group = [_unitarray,_marker,_side,_radius] call p_fnc_spawnpatrol;

  _spawnpos = markerPos _marker;
  _dir = markerDir _marker;
  _vehicle = createVehicle  [_tanktype, _spawnpos, [], 15, "NONE"];
  _vehicle setDir _dir;
  {
    _x moveInAny _vehicle;
  } forEach (units _group);
  _vehicle lock 3;
  clearWeaponCargoGlobal _vehicle;
  clearMagazineCargoGlobal _vehicle;
  clearItemCargoGlobal _vehicle;
  clearBackpackCargoGlobal _vehicle;
