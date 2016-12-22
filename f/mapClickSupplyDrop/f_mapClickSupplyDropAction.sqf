// F3 - Mission Maker Supply Drop
// Credits: Created by Volc, from the F3 mapClickTeleport script, and the dropit script by Kronzky http://www.kronzky.info/ 
// ====================================================================================

// Only run this for players
if (isDedicated) exitWith{};

// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================

// SET UP VARIABLES
// Make sure all global variables are initialized
if (isNil "f_var_mapClickSupplyDrop_Uses") then {f_var_mapClickSupplyDrop_Uses = 0};
if (isNil "f_var_mapClickSupplyDrop_Units") then {f_var_mapClickSupplyDrop_Units = []};
if (isNil "f_var_mapClickSupplyDrop_Height") then {f_var_mapClickSupplyDrop_Height = 1000};

// Make sure that no non-existing units have been parsed
{
	if (isNil _x) then {
		f_var_mapClickSupplyDrop_Units set [_forEachIndex,objNull];
	} else {
		f_var_mapClickSupplyDrop_Units set [_forEachIndex,call compile format ["%1",_x]];
	};
} forEach f_var_mapClickSupplyDrop_Units;

// Reduce the array to valid units only
f_var_mapClickSupplyDrop_Units = f_var_mapClickSupplyDrop_Units - [objNull];

// ====================================================================================

// CHECK IF COMPONENT SHOULD BE ENABLED
// We end the script if it is not running on a server or if the player is not the leader of his/her group

if (count f_var_mapClickSupplyDrop_Units > 0 && !(player in f_var_mapClickSupplyDrop_Units)) exitWith {};
if (player != leader group player)  exitWith {};

// ====================================================================================

// SET KEY VARIABLES
// Setup the localized strings for the various stages of the component
// Depending on the setting of the height variable the strings either use the SupplyDrop or the HALO option.

f_var_mapClickSupplyDrop_textAction = localize "STR_f_mapClickSupplyDropAction";
f_var_mapClickSupplyDrop_textDone = localize "STR_f_mapClickSupplyDropDone";
f_var_mapClickSupplyDrop_textSelect = localize "STR_f_mapClickSupplyDropSelect";

// ====================================================================================

// ADD SupplyDrop ACTION TO PLAYER ACTION MENU
// Whilst the player is alive we add the SupplyDrop action to the player's action menu.
// If the player dies we wait until he is alive again and re-add the action.

f_mapClickSupplyDropAction = player addaction [f_var_mapClickSupplyDrop_textAction,{[] spawn f_fnc_mapClickSupplyDropUnit},"", 0, false,true,"","_this == player"];