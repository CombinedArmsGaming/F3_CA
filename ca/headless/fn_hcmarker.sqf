/*
 * Author: Lib & Poulern
 * Create markers to show fps on each headless client and the server. Spawn on Headless client and server only.
 *
 * Example:
 * [] spawn ca_fnc_hcmarker;
 *
 */
if (hasInterface && !isServer) exitWith {};
 private [ "_sourcestr", "_position", "_myfpsmarker", "_myfps", "_localunits", "_localvehicles" ];

 if ( isServer ) then {
 	_sourcestr = "Server";
 	_position = 0;
 } else {
   {
   if (!isNil "_x") then {
 		if (!isNull _x) then {
 			if (local _x) then {
 				_sourcestr = str _x;
 				_position = _forEachIndex + 1;
 			};
 		};
 	};
  } forEach (entities "HeadlessClient_F");

 };
_mkrname = format ["fpsmarker%1", _sourcestr ];
if (_mkrname in allMapMarkers) then {
    _myfpsmarker = _mkrname;
} else {
  _myfpsmarker = createMarker [ format ["fpsmarker%1", _sourcestr ], [ 500, 500 + (500 * _position) ] ];
  _myfpsmarker setMarkerType "loc_Transmitter";
  _myfpsmarker setMarkerSize [ 0.7, 0.7 ];
};

while { true } do {
  _myfps = diag_fps;
  _localunits = { local _x } count allUnits;
  _localvehicles = { local _x } count vehicles;

  _myfpsmarker setMarkerColor "ColorGREEN";
  if ( _myfps < 30 ) then { _myfpsmarker setMarkerColor "ColorYELLOW"; };
  if ( _myfps < 20 ) then { _myfpsmarker setMarkerColor "ColorORANGE"; };
  if ( _myfps < 10 ) then { _myfpsmarker setMarkerColor "ColorRed"; };
  if (!ca_hcshowmarkers) then {
      _myfpsmarker setMarkerAlpha 0;
  }else {
    _myfpsmarker setMarkerAlpha 1;
  };

  _myfpsmarker setMarkerText format [ "%1: %2 fps, %3 units, %4 vehicles", _sourcestr, ( round ( _myfps * 100.0 ) ) / 100.0 , _localunits, _localvehicles ];

  uisleep 15;
};
