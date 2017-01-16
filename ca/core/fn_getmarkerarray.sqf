/*
 * Author: Poulern
 * Returns array of markers in the fashion you get when you copy paste markers in the editor.
 *
 * Arguments:
 * 0: Marker, String
 * 1: Number of additional markers(Exclusive input marker), number
 *
 * Return Value:
 * [Array of markers]
 *
 * Example:
 * ["FT_AP",4] call ca_fnc_getmarkerarray;
 * Example returns: ["FT_AP","FT_AP_1","FT_AP_2","FT_AP_3","FT_AP_4"]
 */
params ["_marker","_markercount"];

_markerarray = [_marker];

for "_i" from 1 to _markercount do {
  _markerarray pushBackUnique format ["%1_%2", _marker,_i]
};
_markerarray
