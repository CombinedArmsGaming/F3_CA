/* ======================================================================================
  Air Drop
  Version: 1.1.4 (ArmA)
  Author: Kronzky (www.kronzky.info / kronzky@gmail.com)
 ======================================================================================

  Parachutes an item from a plane.

  Place into your mission folder, and call at the desired drop-off point via:
  nul=[plane,object] execVM "dropit.sqf";

  Required parameters:
    'plane'  - Name of the air vehice the item should be dropped out of.
    'object' - Name of the item to be dropped. This item has to be exist somewhere on the map.
    
  Optional parameters:
    "smoke"   - Will create a smoke plume at the landing point.
    "message" - Will display a message with drop-off and landing coordinates.
    "usebox"  - Eject item inside heavier shipping box.

 ====================================================================================== */
 
_carrier = _this select 0;
if (isNil ("_carrier")) exitWith {hint format["Plane not found"]};
_dropitem = _this select 1;
if (isNil ("_dropitem")) exitWith {hint format["Item not found"]};
_orgitem = _dropitem;
_orgitem allowDammage false;
_message = (("message" in _this) || ("MESSAGE" in _this));

_drop=.2;
_delay=.01;

_forceDrop = (getText (configFile >> "cfgVehicles" >> typeof _dropitem >> "simulation")=="House");
if (("usebox" in _this) || ("USEBOX" in _this)) then {_forceDrop=true};
_velfact=.5;
if (_forceDrop) then {
  _dropitem = "ReammoBox" createVehicle [0,0]; 
  _velfact=.25;
};

_pos=position _carrier;
_vel=velocity _carrier;
_vel=[(_vel select 0) min 20,(_vel select 1) min 20,-10];

_dropitem setDir getDir _carrier;
_z=(_pos select 2)-2;
if (_z<50) then {
  _z=abs((_carrier worldToModel position _carrier) select 2);
};
_zoff=((boundingBox _dropitem select 1) select 2);
_z=_z-_zoff;
_yoff=((boundingBox _dropitem select 1) select 1) - ((boundingBox _carrier select 0) select 1)+2;

if (_message) then {player sidechat format["%1: Dropped at %2 (height: %3m)",getText (configFile >> "CfgVehicles" >> typeof _orgitem >> "displayName"), (_pos),round(_z)]};

_chute = "ParachuteWest" createVehicle [_pos select 0,_pos select 1,_z];
_chute setvelocity [(_vel select 0)*_velfact,(_vel select 1)*_velfact,10];
_pos=getpos _carrier;
_dir=direction _carrier;
_pos=[(_pos select 0)-sin(_dir)*_yoff,(_pos select 1)-cos(_dir)*_yoff,_z];
_chute setpos [_pos select 0, _pos select 1, _z];
_dropitem setpos [_pos select 0, _pos select 1, _z];
_dropitem setvelocity [(_vel select 0)*_velfact,(_vel select 1)*_velfact,10];

while {_z > 0.2} do {
  _dropitem setpos [getpos _dropitem select 0, getpos _dropitem select 1, _z];
  _z=_z-_drop;
  _chute setvelocity [velocity _chute select 0,velocity _chute select 1,10];
  _chute setpos [getpos _dropitem select 0, getpos _dropitem select 1, _z];
  sleep _delay;
};
if (_forceDrop) then {
  sleep .5;
  deleteVehicle _dropitem;
};
_orgitem setpos [getpos _dropitem select 0, getpos _dropitem select 1, 0];
_orgitem setVelocity [0,0,0];
_orgitem setVectorUp [0,0,1];
_orgitem allowDammage true;
if (_message) then {player sidechat format["%1: Landed at %2",getText (configFile >> "CfgVehicles" >> typeof _orgitem >> "displayName"), (position _orgitem)]};
sleep 5;
if !(isNull _chute) then {
  _chute setPos [(getpos _orgitem select 0)+1,(getpos _orgitem select 1)+1,0];
  _chute setvelocity [0,0,0];
};
_orgitem setVectorUp [0,0,1];

if (("smoke" in _this) || ("SMOKE" in _this)) then {
  _smoke = "Logic" createVehicle [(getpos _orgitem select 0)+2,(getpos _orgitem select 1)+2,.5];
  _ps = "#particlesource" createVehicleLocal position _smoke;
  _ps setParticleCircle [0, [0, 0, 0]];
  _ps setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
	_ps setParticleParams [["\Ca\Data\ParticleEffects\FireAndSmokeAnim\SmokeAnim.p3d", 8, 3, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 1], 0, 10, 10, 0.1, [2, 6, 12], [[1, 1, 1, 0.7], [1, 1, 1, 0.15], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _orgitem];
  _ps setDropInterval 0.05;
  sleep 30;
  deleteVehicle _ps;
	deleteVehicle _smoke;
};