/*
 * Author: Poulern
 * Spawns patrolling AI on each of the markers provided in an array.
 *
 * Arguments:
 * 0: An array of markers ["mkr","mkr_1","mkr_2","mkr_3"]
 * 1: array of units according to F3 ["ftl","r","ar","aar","rat"]
 * 2: side of group eg west east independent
 * 3: radius of area to patrol eg 200
 * Return Value:
 * Nothing.
 *
 * Example:
 * [["mkr","mkr_1","mkr_2","mkr_3"],["ftl","r","m","rat","ar","aar"],independent,"rhs_uaz_spg9_chdkz",200] call p_fnc_massvehicle;
 *
 * Public: [Yes/No]
 */


params ["_markerarray","_unitarray","_side","_tanktype",
      ["_radius", 200, [2]]
      ];
  private ["_group"];
{
  _group = [_unitarray,_x,_side,_radius] call p_fnc_spawnpatrol;

  _marker = _x;
  _spawnpos = markerPos _marker;
  _dir = markerDir _marker;
  _vehicle = createVehicle  [_tanktype, _spawnpos, [], 15, "NONE"];
  _vehicle setDir _dir;
  _vehicle lock 3;
  clearWeaponCargoGlobal _vehicle;
  clearMagazineCargoGlobal _vehicle;
  clearItemCargoGlobal _vehicle;
  clearBackpackCargoGlobal _vehicle;
  {
    _x moveInAny _vehicle;
  } forEach (units _group);


} forEach _markerarray;
