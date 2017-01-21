// F3 - Mission Maker Supply Drop
// Credits: Created by Volc, from the F3 mapClickTeleport script, and the dropit script by Kronzky http://www.kronzky.info/
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_textSelect","_textDone"];

// ====================================================================================

// SET KEY VARIABLES

f_telePositionSelected = false;
if (isNil "f_var_mapClickSupplyDrop_Used") then {f_var_mapClickSupplyDrop_Used = 0};

// ====================================================================================

// SET KEY VARIABLES
// Setup the localized strings for the various stages of the component
// Depending on the setting of the height variable the strings either use the SupplyDrop or the HALO option.

f_var_mapClickSupplyDrop_textAction = localize "STR_f_mapClickSupplyDropAction";
f_var_mapClickSupplyDrop_textDone = localize "STR_f_mapClickSupplyDropDone";
f_var_mapClickSupplyDrop_textSelect = localize "STR_f_mapClickSupplyDropSelect";

// ====================================================================================

// SUPPLY DROP FUNCTIONALITY
// Open the map for the player and display a notification, then set either the player's vehicle
// or the unit to the new position. If the group needs to be SupplyDroped too, set the group's position
// as well.

["MapClickSupplyDrop",[f_var_mapClickSupplyDrop_textSelect]] call BIS_fnc_showNotification;
openMap [true, false];
onMapSingleClick "f_var_mapClickSupplyDrop_telePos = _pos; f_telePositionSelected = true";
waitUntil {f_telePositionSelected};

// Drop - set height
// If a Drop height is set, modify the clicked position accordingly

if (f_var_mapClickSupplyDrop_Height != 0) then {
	f_var_mapClickSupplyDrop_telePos = [f_var_mapClickSupplyDrop_telePos select 0,f_var_mapClickSupplyDrop_telePos select 1,f_var_mapClickSupplyDrop_Height];
};

openMap false;

["MapClickSupplyDrop",[f_var_mapClickSupplyDrop_textDone]] call BIS_fnc_showNotification;

// EXECUTE AIRDROP OF SINGLE CRATE, NO AIRCRAFT

_dropitem = createVehicle ["B_CargoNet_01_ammo_F", [0,0,1000], [], 0, "CAN_COLLIDE"];

_playerfaction = player getVariable ["f_var_assignGear_Faction",toLower (faction player)];

["crate_med",_dropitem,_playerfaction] call f_fnc_assignGear;

_orgitem = _dropitem;
_orgitem allowDammage false;

_drop=.2;
_delay=.01;

_pos=f_var_mapClickSupplyDrop_telePos;
_vel=[0,0];
_vel=[(_vel select 0) min 20,(_vel select 1) min 20,-10];

_dropitem setDir 0;
_z=(_pos select 2)-2;
_zoff=((boundingBox _dropitem select 1) select 2);
_z=_z-_zoff;
_yoff=((boundingBox _dropitem select 1) select 1);
_velfact=.5;

_chute = "B_Parachute_02_F" createVehicle [_pos select 0,_pos select 1,_z];
_chute setvelocity [(_vel select 0)*_velfact,(_vel select 1)*_velfact,10];
_pos=f_var_mapClickSupplyDrop_telePos;
_dir=0;
_pos=[(_pos select 0)-sin(_dir)*_yoff,(_pos select 1)-cos(_dir)*_yoff,_z];
_chute setpos [_pos select 0, _pos select 1, _z];
_dropitem setpos [_pos select 0, _pos select 1, _z];
_dropitem setvelocity [(_vel select 0)*_velfact,(_vel select 1)*_velfact,10];

_chute attachTo [_dropitem];

while {_z > 0.2} do {
  _dropitem setpos [getpos _dropitem select 0, getpos _dropitem select 1, _z];
  _z=_z-_drop;
  sleep _delay;
};

_orgitem setpos [getpos _dropitem select 0, getpos _dropitem select 1, 0];
_orgitem setVelocity [0,0,0];
_orgitem setVectorUp [0,0,1];
_orgitem allowDammage true;

if !(isNull _chute) then {
  _chute setPos [(getpos _orgitem select 0)+1,(getpos _orgitem select 1)+1,0];
  _chute setvelocity [0,0,0];
};

_orgitem setVectorUp [0,0,1];

// ====================================================================================

// REMOVE AND READD ACTION
// Remove the action and re-add if we have uses left (or if they are infinite)

if (!isNil "f_mapClickSupplyDropAction") then {
player removeAction f_mapClickSupplyDropAction;
};

f_var_mapClickSupplyDrop_Used = f_var_mapClickSupplyDrop_Used + 1;

if (f_var_mapClickSupplyDrop_Uses == 0 || f_var_mapClickSupplyDrop_Used < f_var_mapClickSupplyDrop_Uses) then {
	f_mapClickSupplyDropAction = player addaction [f_var_mapClickSupplyDrop_textAction,{[] spawn f_fnc_mapClickSupplyDropUnit},"", 0, false,true,"","_this == player"];
};
