// F3 - ACRE Clientside Initialisation
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_presetName","_ret","_unit","_typeOfUnit"];

// ====================================================================================

// Set up the radio presets according to side.
_presetName = switch(side player) do {
	case west:{"default2"};
	case east:{"default3"};
	case resistance:{"default4"};
	default {"default"};
};
if (f_radios_settings_acre2_disableFrequencySplit) then {
	_presetName = "default";
};

_ret = ["ACRE_PRC343", _presetName ] call acre_api_fnc_setPreset;
_ret = ["ACRE_PRC148", _presetName ] call acre_api_fnc_setPreset;
_ret = ["ACRE_PRC152", _presetName ] call acre_api_fnc_setPreset;
_ret = ["ACRE_PRC117F", _presetName ] call acre_api_fnc_setPreset;
_ret = ["ItemRadio", _presetName ] call acre_api_fnc_setPreset;


// if dead, set spectator and exit
if(!alive player) exitWith {[true] call acre_api_fnc_setSpectator;};

_unit = player;

// ====================================================================================

// Set language of the units depending on side (BABEL API)
switch (side _unit) do {
	case blufor: {
		f_radios_settings_acre2_language_blufor call acre_api_fnc_babelSetSpokenLanguages;
		[f_radios_settings_acre2_language_blufor select 0] call acre_api_fnc_babelSetSpeakingLanguage;
	};
	case opfor: {
		f_radios_settings_acre2_language_opfor call acre_api_fnc_babelSetSpokenLanguages;
		[f_radios_settings_acre2_language_opfor select 0] call acre_api_fnc_babelSetSpeakingLanguage;
	};
	case independent: {
		f_radios_settings_acre2_language_indfor call acre_api_fnc_babelSetSpokenLanguages;
		[f_radios_settings_acre2_language_indfor select 0] call acre_api_fnc_babelSetSpeakingLanguage;
	};
	default {
		f_radios_settings_acre2_language_indfor call acre_api_fnc_babelSetSpokenLanguages;
		[f_radios_settings_acre2_language_indfor select 0] call acre_api_fnc_babelSetSpeakingLanguage;
	};
};

// ====================================================================================

// RADIO ASSIGNMENT

// Wait for gear assignation to take place
waitUntil{(player getVariable ["f_var_assignGear_done", false])};
_typeOfUnit = _unit getVariable ["f_var_assignGear", "NIL"];

// REMOVE ALL RADIOS
// Wait for ACRE2 to initialise any radios the unit has in their inventory, and then
// remove them to ensure that duplicate radios aren't added by accident.
waitUntil{uiSleep 0.3; !("ItemRadio" in (items _unit + assignedItems _unit))};
uiSleep 1;

waitUntil{[] call acre_api_fnc_isInitialized};
{_unit removeItem _x;} forEach ([] call acre_api_fnc_getCurrentRadioList);

//Get CA hierarchy information 
_shortrangeCH = (group _unit) getVariable ["ca_SRradioCH",1];
_longrangeArray = (group _unit) getVariable ["ca_LRradioarray",[1]];
_unitrank = rankId _unit;
// ====================================================================================

// ASSIGN RADIOS TO UNITS
// Depending on the loadout used in the assignGear component, each unit is assigned
// a set of radios.

if(_typeOfUnit != "NIL") then {

	// If radios are enabled in the settings
	if(!f_radios_settings_acre2_disableRadios) then {
		// Everyone gets a short-range radio by default
		if(isnil "f_radios_settings_acre2_shortRange") then {
			if (_unit canAdd f_radios_settings_acre2_standardSHRadio) then {
				_unit addItem f_radios_settings_acre2_standardSHRadio;
			} else {
				f_radios_settings_acre2_standardSHRadio call f_radios_acre2_giveRadioAction;
			};
		} else {
			if(_typeOfUnit in f_radios_settings_acre2_shortRange) then {
				if (_unit canAdd f_radios_settings_acre2_standardSHRadio) then {
					_unit addItem f_radios_settings_acre2_standardSHRadio;
				} else {
					f_radios_settings_acre2_standardSHRadio call f_radios_acre2_giveRadioAction;
				};
			};
		};


		

		// If unit is in the above list, add a 152

		if(_typeOfUnit in f_radios_settings_acre2_longRange) then {
			if (_unit canAdd f_radios_settings_acre2_standardLRRadio) then {
				_unit addItem f_radios_settings_acre2_standardLRRadio;
			} else {
				f_radios_settings_acre2_standardLRRadio call f_radios_acre2_giveRadioAction;
			};
		};
		if ((f_radios_settings_acre2_leaderLongRange && (leader group _unit == _unit)) || !f_radios_settings_acre2_leaderLongRange) then {
			// If unit is in the list of units that receive a worse long-range radio, add a 148
			if(_unitrank in f_radios_settings_acre2_extraRadios && !(_typeOfUnit in f_radios_settings_acre2_longRange)) then {
				if (_unit canAdd f_radios_settings_acre2_extraRadio) then {
					_unit addItem f_radios_settings_acre2_extraRadio;
				} else {
					f_radios_settings_acre2_extraRadio call f_radios_acre2_giveRadioAction;
				};
			};
			// If unit has more long range channels, give 148s to cover 
			if(count _longrangeArray > 1 &&  (_unitrank in f_radios_settings_acre2_extraRadios) || (count _longrangeArray > 2 && _typeOfUnit in f_radios_settings_acre2_BackpackRadios)) then {
				for "_i" from 1 to (count _longrangeArray -1) do {
					if (_unit canAdd f_radios_settings_acre2_extraRadio) then {
						_unit addItem f_radios_settings_acre2_extraRadio;
					} else {
						f_radios_settings_acre2_extraRadio call f_radios_acre2_giveRadioAction;
					};
				};
			};
		};
			// If unit is in the list of units that receive a backpack radio, then add a 117F
		if(_typeOfUnit in f_radios_settings_acre2_BackpackRadios) then {
			if (_unit canAdd f_radios_settings_acre2_BackpackRadio) then {
				_unit addItem f_radios_settings_acre2_BackpackRadio;
			} else {
				f_radios_settings_acre2_BackpackRadio call f_radios_acre2_giveRadioAction;
			};
		};		
	};
};

// ====================================================================================

// ASSIGN DEFAULT CHANNELS TO RADIOS
// Depending on the squad joined, each radio is assigned a default starting channel

if(!f_radios_settings_acre2_disableRadios) then {

	private ["_presetArray","_presetLRArray","_radioSR","_radioLR","_radioExtra","_hasSR","_hasLR","_hasExtra","_groupID","_groupChannelIndex","_groupLRChannelIndex"];

	waitUntil {uiSleep 0.1; [] call acre_api_fnc_isInitialized};



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

	_groupID = groupID (group _unit);

	_groupChannelIndex = -1;
  	_groupLRChannelIndex = -1;


	if (_hasSR) then {
		[_radioSR, _shortrangeCH] call acre_api_fnc_setRadioChannel;
  	};

  	if (count _radiolist > 0) then {
	  	{
			  		[_x, (_longrangeArray select _foreachindex)] call acre_api_fnc_setRadioChannel;
	  	} forEach _radiolist;
  	};



};
