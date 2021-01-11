// CA ACE selfinteraction 

// Base interaction
_CAmenu = ['ca_action','CA','\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa',{},{true},{}] call ace_interact_menu_fnc_createAction;

// Full Hierarchy menu
_hierachyaction = ['ca_hierachy_action','Full Hierarchy Menu','\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa',{_handle=createdialog 'ca_hierarchydialog';},{true},{}] call ace_interact_menu_fnc_createAction;

// Wave respwan interface
_waverespawn = ['ca_waverespawn_action','Show Wave respawn Menu','\A3\ui_f\data\igui\cfg\simpleTasks\types\getin_ca.paa',{if(rankid player >= ca_corank || serverCommandAvailable '#kick') then {_handle=createdialog 'ca_respawndiag'; } else {systemchat 'You are not CO rank and thus cant wave respawn!'}},{true},{}] call ace_interact_menu_fnc_createAction;

// Change callsign
_callsign = ['ca_callsign_action','Edit squad markers','\A3\ui_f\data\igui\cfg\simpleTasks\types\move_ca.paa',{ca_selectedgroup = group player; _groupiddialog=createdialog 'ca_groupid'},{true},{}] call ace_interact_menu_fnc_createAction;

// Get group radios - Repurposed from clientinit
_getradios = ['ca_getradios_action','Get radio channels','\A3\ui_f\data\igui\cfg\simpleTasks\types\radio_ca.paa',{
_unit = player;
_shortrangeCH = (group _unit) getVariable ["ca_SRradioCH",1];
_longrangeArray = (group _unit) getVariable ["ca_LRradioarray",[1]];

_presetLRArray = switch (side _unit) do {
	case blufor: {f_radios_settings_acre2_lr_groups_blufor};
	case opfor: {f_radios_settings_acre2_lr_groups_opfor};
	case independent: {f_radios_settings_acre2_lr_groups_indfor};
	default {f_radios_settings_acre2_lr_groups_blufor};
};

_radioSR = [f_radios_settings_acre2_standardSHRadio] call acre_api_fnc_getRadioByType;
//Workaround if f_radios_settings_acre2_standardSHRadio = []
if(isnil {_radioSR}) then {
_radioSR = "";
};
_radiolist = [] call acre_api_fnc_getCurrentRadioList;
_radiolist deleteAt (_radiolist find _radioSR);

_hasSR = ((!isNil {_radioSR}) && {_radioSR != ""});

if (_hasSR) then {
	[_radioSR, _shortrangeCH] call acre_api_fnc_setRadioChannel;
};

if (count _radiolist > 0) then {
	{
				[_x, (_longrangeArray select _foreachindex)] call acre_api_fnc_setRadioChannel;
	} forEach _radiolist;
	systemChat format ["You have changed your 343 channel to CH%1 and your long range channels to %2 (If less LR radios, then apply from left to right)",_shortrangeCH,_longrangeArray];
} else {
	systemChat format ["You have changed your 343 channel to CH%1",_shortrangeCH];
};


},{true},{}] call ace_interact_menu_fnc_createAction;

// ====================================================================================
[player, 1, ['ACE_SelfActions'], _CAmenu] call ace_interact_menu_fnc_addActionToObject;
[player, 1, ['ACE_SelfActions','ca_action'], _hierachyaction] call ace_interact_menu_fnc_addActionToObject;
[player, 1, ['ACE_SelfActions','ca_action'], _waverespawn] call ace_interact_menu_fnc_addActionToObject;
[player, 1, ['ACE_SelfActions','ca_action'], _callsign] call ace_interact_menu_fnc_addActionToObject;
[player, 1, ['ACE_SelfActions','ca_action'], _getradios] call ace_interact_menu_fnc_addActionToObject;


// =================================
