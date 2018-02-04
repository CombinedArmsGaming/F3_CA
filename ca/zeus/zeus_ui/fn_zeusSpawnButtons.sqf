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

_bg ctrlSetPosition [ -0.06, 0.995, 0.3, 0.2 ];
_bg ctrlSetText "";
_bg ctrlEnable false;
_bg ctrlCommit 0;


_btn = ["RscButton"] call _fn_newCtrl;
_btn ctrlSetPosition [ -0.05, 1.12, 0.28, 0.06 ];
_btn ctrlSetText "Spawn units";
_btn buttonSetAction '[ca_zeus_defToSpawn] call ca_fnc_zeusDoSpawn;';
_btn ctrlCommit 0;


_unitsList = ["RscCombo"] call _fn_newCtrl;
_unitsList ctrlSetPosition [ -0.05, 1.061, 0.28, 0.041 ];
_unitsList ctrlAddEventHandler ["LBSelChanged", 
{
	params ["_list", "_sel"];
	_type = _list lbText _sel;
	
	_defs = ca_zeus_listUnits;
	_def = _defs select _sel;
	
	ca_zeus_defToSpawn = _def;
	
}];
_unitsList ctrlCommit 0;

ca_zeus_unitsList_idc = ctrlIDC _unitsList;


_categoriesList = ["RscCombo"] call _fn_newCtrl;
_categoriesList ctrlSetPosition [ -0.05, 1.007, 0.28, 0.041 ];
[ctrlIDC _categoriesList] call ca_fnc_zeusFillCategories;
_categoriesList ctrlAddEventHandler ["LBSelChanged", 
{
	params ["_list", "_sel"];
	if (_sel < 0) exitWith {};
	
	_unitsListIDC = ca_zeus_unitsList_idc;
	[_unitsListIDC, _sel] call ca_fnc_zeusFillUnits;
	
}];
_categoriesList ctrlCommit 0;


waitUntil { sleep 0.2; _display = findDisplay 312; isNull _display };
[] spawn ca_fnc_zeusSpawnButtons;