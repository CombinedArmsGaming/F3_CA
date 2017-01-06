/*
 * Author: [Name of Author(s)]
 * [Description]
 *
 * Arguments:
 * 0: Argument Name <TYPE>
 *
 * Return Value:
 * none
 *
 * Example:
 * [["detendion","detendion_1","detendion_2","detendion_1_1"],"rhs_t72ba_tv",east] call p_fnc_spawnfortvehgroup
 *
 * Public: [Yes/No]
 */
params ["_markerarray","_tanktype","_side"];
//ex [["detendion","detendion_1","detendion_2","detendion_1_1"],"rhs_t72ba_tv",east] call p_fnc_spawnfortvehgroup


{
  _marker = _x;

  _tank =  [_marker,_tanktype] call p_fnc_spawnfortveh;

  _group = [["vc","vg","vd"],_marker,_side] call p_fnc_spawngroup;

  {
    _x moveInAny _tank;
  } forEach (units _group);


} forEach _markerarray;
