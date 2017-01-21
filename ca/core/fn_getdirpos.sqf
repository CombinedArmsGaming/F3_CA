/*
 * Author: Poulern & Wolfenswan
 * Return position and direction based on what datatype is given.
 *
 * Arguments:
 * 0: Data to be converted into position and direction
 *
 * Return Value:
 * [position,direction]
 *
 * Example:
 * ["marker1"] call ca_fnc_getdirpos
 *
 */
 params ["_position"];
 private ["_pos","_dir"];
 _pos = [];
 _dir = 0;
 switch (typename _position) do {
 case "STRING": {_pos = getMarkerPos _position; _dir = markerDir _position};
 case "OBJECT": {_pos = getPosATL _position; _dir = getDir _position};
 case "GROUP": {_pos = getPosATL (leader _position); _dir = getDir (leader _position)};
 case "LOCATION": {_pos = position _position; _dir = direction _position};
 case "ARRAY": {_pos append _position; if(count _this > 1) then { _dir = _this select 1 }else{_dir = 0}};
 case "SCALAR": { if(count _this > 1) then { _pos = _this; }else {_pos = locationNull;_dir = _position}};
 default {_pos = locationNull; _dir = 0};
 };
 [_pos,_dir]
