// F3 - Assign Insignia
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

private ["_group","_badge","_groupBadges","_roleBadge","_unit","_typeofUnit"];

_badge = "insignia_GI_Badge_Black_Stitched";
_unit = _this select 0;
_typeofUnit = _this select 1;
_faction = toLower (faction _unit);

// Exit if the unit is not local.
if !(local _unit) exitWith {};

// Note all badges must be defined in description.ext or be included your modpack (Gibbs insignia for F3_CA).
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
	case "med":{"insignia_GI_Medic"};
	case "co":{"insignia_GI_CO"};
	case "xo":{"insignia_GI_XO"};
	case "sur":{"insignia_GI_Surgeon"};
	case "log":{"insignia_GI_LOG"};
	case "log_sl":{"insignia_GI_LOG_SL"};
	case "eng":{"insignia_GI_ENG"};
	case "eng_sl":{"insignia_GI_ENG_SL"};
	case "eod":{"insignia_GI_EOD"};
	case "fac":{"insignia_GI_FAC"};
	case "rto":{"insignia_GI_RTO"};
	case "air":{"insignia_GI_AIR"};
	case "rec":{"insignia_GI_REC"};
	case "spc":{"insignia_GI_SPC"};
	case "sf":{"insignia_GI_SF"};
	case "zeus":{"insignia_GI_ZEUS"};
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

// Broadcast the insignia assignment (JIP compatible)
if (_badge != "") then {
	[{
		params ["_unit", "_badge"];
		[_unit, _badge] remoteExecCall ["f_fnc_assignInsignia_local", 0, format ["f_insignia_%1", netId _unit]];
	}, [_unit, _badge], 1] call CBA_fnc_waitAndExecute;
};
