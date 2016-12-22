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

// Move player
// If the player is in a vehicle and not HALO-ing, the complete vehicle is moved. Otherwise the player is teleported.

if (vehicle player != player && f_var_mapClickSupplyDrop_Height == 0) then {
	(vehicle player) setPos (f_var_mapClickSupplyDrop_telePos findEmptyPosition [0,150,typeOf (vehicle player)]);
} else {
	player setPos f_var_mapClickSupplyDrop_telePos;
};

openMap false;

["MapClickSupplyDrop",[f_var_mapClickSupplyDrop_textDone]] call BIS_fnc_showNotification;

// ====================================================================================

// HALO functionality
// If the players are parajumping spawn the following code to add a backpack and restore the old backpack on landing

if (f_var_mapClickSupplyDrop_Height > 0) then {
	[player] spawn {
		private ["_unit","_bp","_bpi"];
		_unit = _this select 0;
		_bp = backpack _unit;
		_bpi = backPackItems _unit;

		removeBackpack _unit;
		_unit addBackpack "B_parachute";
		waitUntil {sleep 0.1;isTouchingGround _unit;};
		removeBackpack _unit;
		_unit addBackPack _bp;
		{
			(unitbackpack _unit) addItemCargoGlobal [_x,1];
		} forEach _bpi;
	};
};

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
