//	Zeus extensions for CA, by Bubbus.
//
//	This function is called from ca_fnc_zeusDeployment.
//	Waits for the zeus display to be created (id = 312), then creates a spawn menu for gearscripted squads.

if (isDedicated) exitWith {};
disableSerialization;

[] call ca_fnc_zeusSetupUnits;

_ctrls = missionNamespace getVariable ["ca_zeus_ctrls", []];
missionNamespace setVariable ["ca_zeus_ctrls", _ctrls];
_id = 500;

{ ctrlDelete _x } forEach _ctrls;

_fn_newCtrl =
{
	params ["_type"];

	_ctrl = _display ctrlCreate [ _type, _id ];

	_id = _id + 1;
	_ctrls pushBack _ctrl;

	_ctrl

};

private ["_display"];

waitUntil { sleep 0.1; _display = findDisplay 312; !isNull _display };




_bg = ["RscButton"] call _fn_newCtrl;
//ZU_BG = _bg;
_bg ctrlSetPosition [ -0.06, 0.91, 0.3, 0.285 ];
_bg ctrlSetText "";
_bg ctrlEnable false;
_bg ctrlCommit 0;




_btn = ["RscButton"] call _fn_newCtrl;
//ZU_BTN = _btn;
_btn ctrlSetPosition [ -0.05, 1.025, 0.28, 0.06 ];
_btn ctrlSetText "Spawn units";
_btn buttonSetAction 'if (!isNil "ca_zeus_defToSpawn") then {[ca_zeus_defToSpawn] call ca_fnc_zeusDoSpawn;};';
_btn ctrlCommit 0;




_unitsList = ["RscCombo"] call _fn_newCtrl;
//ZU_UNITS = _unitsList;
_unitsList ctrlSetPosition [ -0.05, 0.975, 0.28, 0.041 ];
_unitsList ctrlAddEventHandler ["LBSelChanged",
{
	params ["_list", "_sel"];

	if (lbSize _list > 0) then
	{
		_type = _list lbText _sel;

		_defs = ca_zeus_listUnits;
		_def = _defs select _sel;

		ca_zeus_defToSpawn = _def;

	};

}];
_unitsList ctrlCommit 0;

ca_zeus_unitsList_idc = ctrlIDC _unitsList;




_categoriesList = ["RscCombo"] call _fn_newCtrl;
//ZU_CATS = _categoriesList;
_categoriesList ctrlSetPosition [ -0.05, 0.929, 0.28, 0.041 ];
[ctrlIDC _categoriesList] call ca_fnc_zeusFillCategories;
_categoriesList ctrlAddEventHandler ["LBSelChanged",
{
	params ["_list", "_sel"];
	if (_sel < 0) exitWith {};

	_unitsListIDC = ca_zeus_unitsList_idc;
	[_unitsListIDC, _sel] call ca_fnc_zeusFillUnits;

}];
_categoriesList ctrlCommit 0;




if (isNil "zeus_spawn_guerrillas") then { zeus_spawn_guerrillas = false; };

_guerrillaBtn = ["RscButton"] call _fn_newCtrl;
ca_zeus_guerrillaBtn_idc = ctrlIDC _guerrillaBtn;
//ZU_GUER = _guerrillaBtn;
_guerrillaBtn ctrlSetPosition [ -0.05, 1.095, 0.134, 0.04 ];
_guerrillaBtn ctrlSetText "Guerrilla";
_guerrillaBtn ctrlSetTooltip "Press to give spawned units Guerrilla AI (default settings).";
_guerrillaBtn buttonSetAction '[ca_zeus_guerrillaBtn_idc, "zeus_spawn_guerrillas", !zeus_spawn_guerrillas, "Guerrilla"] call ca_fnc_updateButtonToggleState;';
[ca_zeus_guerrillaBtn_idc, "zeus_spawn_guerrillas", zeus_spawn_guerrillas, "Guerrilla"] call ca_fnc_updateButtonToggleState;

_guerrillaBtn ctrlCommit 0;




if (isNil "zeus_spawn_suppress") then { zeus_spawn_suppress = false; };

_suppressBtn = ["RscButton"] call _fn_newCtrl;
ca_zeus_suppressBtn_idc = ctrlIDC _suppressBtn;
//ZU_SUPP = _suppressBtn;
_suppressBtn ctrlSetPosition [ -0.05, 1.144, 0.134, 0.04 ];
_suppressBtn ctrlSetText "Guerrilla";
_suppressBtn ctrlSetTooltip "Press to give spawned units Guerrilla AI (default settings).";
_suppressBtn buttonSetAction '[ca_zeus_suppressBtn_idc, "zeus_spawn_suppress", !zeus_spawn_suppress, "Suppressive"] call ca_fnc_updateButtonToggleState;';
[ca_zeus_suppressBtn_idc, "zeus_spawn_suppress", zeus_spawn_suppress, "Suppressive"] call ca_fnc_updateButtonToggleState;

_suppressBtn ctrlCommit 0;




if (isNil "zeus_hide_ui") then { zeus_hide_ui = false; };

_hideBtn = ["RscButton"] call _fn_newCtrl;
ca_zeus_hideBtn_idc = ctrlIDC _hideBtn;
//ZU_HIDE = _hideBtn;
_hideBtn ctrlSetPosition [ 0.095, 1.144, 0.134, 0.04 ];
_hideBtn ctrlSetText "Hide";
_hideBtn buttonSetAction '[ca_zeus_hideBtn_idc, "zeus_hide_ui", !zeus_hide_ui, "Hide"] call ca_fnc_updateButtonToggleState; [zeus_hide_ui] spawn ca_fnc_setZeusUiHidden;';
[ca_zeus_hideBtn_idc, "zeus_hide_ui", zeus_hide_ui, "Hide"] call ca_fnc_updateButtonToggleState;
[zeus_hide_ui] spawn ca_fnc_setZeusUiHidden;

_hideBtn ctrlCommit 0;




if (isNil "zeus_spawn_vcom") then { zeus_spawn_vcom = true; };

_vcomBtn = ["RscButton"] call _fn_newCtrl;
ca_zeus_vcomBtn_idc = ctrlIDC _vcomBtn;
//ZU_VCOM = _vcomBtn;
_vcomBtn ctrlSetPosition [ 0.095, 1.094, 0.134, 0.04 ];
_vcomBtn ctrlSetText "Hide";
_vcomBtn buttonSetAction '[ca_zeus_vcomBtn_idc, "zeus_spawn_vcom", !zeus_spawn_vcom, "VCOM"] call ca_fnc_updateButtonToggleState;';
[ca_zeus_vcomBtn_idc, "zeus_spawn_vcom", zeus_spawn_vcom, "VCOM"] call ca_fnc_updateButtonToggleState;
[zeus_spawn_vcom] spawn ca_fnc_setZeusUiHidden;

_vcomBtn ctrlCommit 0;



waitUntil { sleep 0.2; _display = findDisplay 312; isNull _display };
[] spawn ca_fnc_zeusSpawnButtons;
