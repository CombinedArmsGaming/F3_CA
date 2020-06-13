// F3 - Assign Insignia
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

private ["_group","_badge","_groupBadges","_roleBadge","_unit","_typeofUnit"];

_badge = "insignia_GI_Badge_Black_Stitched"; 
_unit = _this select 0;
_typeofUnit = _this select 1;
_faction = toLower (faction _unit);

// Note all badges must be defined in description.ext or be included your modpack.
// See: https://community.bistudio.com/wiki/Arma_3_Unit_Insignia

// This variable stores the final badge to use which will applied at the end of this script.
// A default badge can be set by changing this.


// ===================================================================================

// Assign Insignia based on type of the unit.
// Get role from var, or type of unit if no var set.
_role = _unit getVariable ["badge", ""];
if(_role == "") then {
_role = _typeofUnit;
};

// Check if role has badge set...
_roleBadge = switch (_role) do
{

	case "m":
	{
		"insignia_GI_Medic"			
	};
	case "co":
	{
		"insignia_GI_CO"			
	};
	case "xo":
	{
		"insignia_GI_XO"			
	};
	case "surgeon":
	{
		"insignia_GI_Surgeon"			

	};
	case "log":
	{
		"insignia_GI_LOG"			

	};
	case "log_sl":
	{
		"insignia_GI_LOG_SL"			

	};	
	case "eng":
	{
		"insignia_GI_ENG"			

	};
	case "eod":
	{
		"insignia_GI_EOD"			

	};
	case "eng_sl":
	{
		"insignia_GI_ENG_SL"		

	};	
	case "fac":
	{
		"insignia_GI_FAC"			

	};
	case "rto":
	{
		"insignia_GI_RTO"			

	};
	case "air":
	{
		"insignia_GI_AIR"		

	};
	case "recon":
	{

		"insignia_GI_REC"			

	};
	case "zeus":
	{
		"insignia_GI_ZEUS"			

	};	
	case "spc":
	{
		"insignia_GI_SPC"			

	};		
	case "sf":
	{
		"insignia_GI_SF"			

	};		
	default {""};
};

// ====================================================================================

// This array stores a list of groups and the corresponding badge they will receive.
// Bin by faction (lowers numbers of groups for each unit to be grouped by too!).

_groupBadges = [
			["COY","insignia_GI_COY"],
			["CO","insignia_GI_CO"],
			["AAA","insignia_GI_AAA"],
			["SAM","insignia_GI_SAM"],
			["MAT","insignia_GI_MAT"],
			["HAT","insignia_GI_HAT"],
			["GMG","insignia_GI_GMG"],
			["MMG","insignia_GI_MMG"],
			["HMG","insignia_GI_HMG"],
			["WEP","insignia_GI_WEP"],
			["SPC","insignia_GI_SPC"],
			["SF","insignia_GI_SF"],
			["MOR","insignia_GI_MOR"],
			["MTR","insignia_GI_MTR"],
			["REC","insignia_GI_REC"],
			["ENG","insignia_GI_ENG"],
			["EOD","insignia_GI_EOD"],
			["ENG_SL","insignia_GI_ENG_SL"],
			["LOG","insignia_GI_LOG"],
			["LOG_SL","insignia_GI_LOG_SL"],
			["1PL","insignia_GI_1PL"],
			["ASL","insignia_GI_ASL"],
			["A1","insignia_GI_A1"],
			["A2","insignia_GI_A2"],
			["AV","insignia_GI_AV"],
			["BSL","insignia_GI_BSL"],
			["B1","insignia_GI_B1"],
			["B2","insignia_GI_B2"],
			["BV","insignia_GI_BV"],
			["CSL","insignia_GI_CSL"],
			["C1","insignia_GI_C1"],
			["C2","insignia_GI_C2"],
			["CV","insignia_GI_CV"],
			["2PL","insignia_GI_2PL"],
			["DSL","insignia_GI_DSL"],
			["D1","insignia_GI_D1"],
			["D2","insignia_GI_D2"],
			["DV","insignia_GI_DV"],
			["ESL","insignia_GI_ESL"],
			["E1","insignia_GI_E1"],
			["E2","insignia_GI_E2"],
			["EV","insignia_GI_EV"],
			["FSL","insignia_GI_FSL"],
			["F1","insignia_GI_F1"],
			["F2","insignia_GI_F2"],
			["FV","insignia_GI_FV"],
			["3PL","insignia_GI_3PL"],
			["GSL","insignia_GI_GSL"],
			["G1","insignia_GI_G1"],
			["G2","insignia_GI_G2"],
			["GV","insignia_GI_GV"],
			["HSL","insignia_GI_HSL"],
			["H1","insignia_GI_H1"],
			["H2","insignia_GI_H2"],
			["HV","insignia_GI_HV"],
			["ISL","insignia_GI_ISL"],
			["I1","insignia_GI_I1"],
			["I2","insignia_GI_I2"],
			["IV","insignia_GI_IV"]
		];


// ====================================================================================
// END OF CONFIGURABLE SETTINGS - BELOW ASSIGNS THE INSIGNIAS
// ====================================================================================

// Loop through the groups and match badges to the group _unit belongs to.
_isMan = _unit isKindOf "CAManBase";
if(_isMan) then {
	_group = group _unit;
	_groupid = groupId _group;
	systemChat name _unit;
	systemChat _groupid;
	systemChat _role;
	{
		if ((_x select 0) == _groupid) then {
			_badge = _x select 1;
		};
	} forEach _groupBadges;
};

// ====================================================================================

//  Let the unit insignia override the group insignia.

if (_roleBadge != "") then {
	_badge = _roleBadge;
};

// Apply the insignia.
if (_badge != "") then {
	// spawn to avoid waitUntil bug.
	private["_index","_texture","_cfgTexture"];

	// Wait till they have the proper uniform assigned.
	waitUntil{_unit getVariable ["f_var_assignGear_done",false]};
	waitUntil{(uniform _unit) != ""};

	// Replicate behaviour of setInsignia
	_cfgTexture = [["CfgUnitInsignia",_badge],configfile] call bis_fnc_loadclass;
	if (_cfgTexture == configfile) exitwith {["'%1' not found in CfgUnitInsignia",_badge] call bis_fnc_error; false};
	_texture = gettext (_cfgTexture >> "texture");
	
	_index = -1;
	{
		if (_x == "insignia") exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> gettext (configfile >> "CfgWeapons" >> uniform _unit >> "ItemInfo" >> "uniformClass") >> "hiddenSelections");

	if (_index >= 0) then {
		_unit setvariable ["bis_fnc_setUnitInsignia_class",_badge,false];
		_unit setobjecttexture [_index,_texture];
	};
};