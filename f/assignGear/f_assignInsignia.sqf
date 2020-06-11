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
_roleBadge = "";
_roleBadge = switch (_typeofUnit) do
{

// INSIGNIA: MEDIC
	case "m":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_Medic"};			
		};
	};
	case "pj":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_Medic"};			
		};
	};
	case "surgeon":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_Surgeon"};			
		};
	};
	case "log":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_LOG"};			
		};
	};
	case "log_sl":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_LOG_SL"};			
		};
	};	
	case "eng":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_ENG"};			
		};
	};
	case "eng_sl":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_ENG_SL"};			
		};
	};	
	case "fac":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_FAC"};			
		};
	};
	case "rto":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_RTO"};			
		};
	};
	case "air":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_AIR"};			
		};
	};
	case "recon":
	{
		switch (_faction) do
		{	
			default {"insignia_GI_REC"};			
		};
	};
	default {""};
};

// ====================================================================================

// This array stores a list of groups and the corresponding badge they will receive.
// Bin by faction (lowers numbers of groups for each unit to be grouped by too!).

_groupBadges = [];

switch (_faction) do
{	
	case "blu_f" : {
		_groupBadges = [
			["GrpNATO_COY","insignia_GI_COY"],
			["GrpNATO_AAA","insignia_GI_AAA"],
			["GrpNATO_MAT","insignia_GI_MAT"],
			["GrpNATO_HAT","insignia_GI_HAT"],
			["GrpNATO_GMG","insignia_GI_GMG"],
			["GrpNATO_MMG","insignia_GI_MMG"],
			["GrpNATO_HMG","insignia_GI_HMG"],
			["GrpNATO_MOR","insignia_GI_MOR"],
			["GrpNATO_REC","insignia_GI_REC"],
			["GrpNATO_ENG","insignia_GI_ENG"],
			["GrpNATO_ENG_SL","insignia_GI_ENG_SL"],
			["GrpNATO_LOG","insignia_GI_LOG"],
			["GrpNATO_LOG_SL","insignia_GI_LOG_SL"],
			["GrpNATO_1PL","insignia_GI_1PL"],
			["GrpNATO_ASL","insignia_GI_ASL"],
			["GrpNATO_A1","insignia_GI_A1"],
			["GrpNATO_A2","insignia_GI_A2"],
			["GrpNATO_AV","insignia_GI_AV"],
			["GrpNATO_BSL","insignia_GI_BSL"],
			["GrpNATO_B1","insignia_GI_B1"],
			["GrpNATO_B2","insignia_GI_B2"],
			["GrpNATO_BV","insignia_GI_BV"],
			["GrpNATO_CSL","insignia_GI_CSL"],
			["GrpNATO_C1","insignia_GI_C1"],
			["GrpNATO_C2","insignia_GI_C2"],
			["GrpNATO_CV","insignia_GI_CV"],
			["GrpNATO_2PL","insignia_GI_2PL"],
			["GrpNATO_DSL","insignia_GI_DSL"],
			["GrpNATO_D1","insignia_GI_D1"],
			["GrpNATO_D2","insignia_GI_D2"],
			["GrpNATO_DV","insignia_GI_DV"],
			["GrpNATO_ESL","insignia_GI_ESL"],
			["GrpNATO_E1","insignia_GI_E1"],
			["GrpNATO_E2","insignia_GI_E2"],
			["GrpNATO_EV","insignia_GI_EV"],
			["GrpNATO_FSL","insignia_GI_FSL"],
			["GrpNATO_F1","insignia_GI_F1"],
			["GrpNATO_F2","insignia_GI_F2"],
			["GrpNATO_FV","insignia_GI_FV"],
			["GrpNATO_3PL","insignia_GI_3PL"],
			["GrpNATO_GSL","insignia_GI_GSL"],
			["GrpNATO_G1","insignia_GI_G1"],
			["GrpNATO_G2","insignia_GI_G2"],
			["GrpNATO_GV","insignia_GI_GV"],
			["GrpNATO_HSL","insignia_GI_HSL"],
			["GrpNATO_H1","insignia_GI_H1"],
			["GrpNATO_H2","insignia_GI_H2"],
			["GrpNATO_HV","insignia_GI_HV"],
			["GrpNATO_ISL","insignia_GI_ISL"],
			["GrpNATO_I1","insignia_GI_I1"],
			["GrpNATO_I2","insignia_GI_I2"],
			["GrpNATO_IV","insignia_GI_IV"]
		];
	};
	case "opf_f" : {
		_groupBadges = [
			["GrpCSAT__COY","insignia_GI_COY"],
			["GrpCSAT__AAA","insignia_GI_AAA"],
			["GrpCSAT__MAT","insignia_GI_MAT"],
			["GrpCSAT__HAT","insignia_GI_HAT"],
			["GrpCSAT__GMG","insignia_GI_GMG"],
			["GrpCSAT__MMG","insignia_GI_MMG"],
			["GrpCSAT__HMG","insignia_GI_HMG"],
			["GrpCSAT__MOR","insignia_GI_MOR"],
			["GrpCSAT__REC","insignia_GI_REC"],
			["GrpCSAT__ENG","insignia_GI_ENG"],
			["GrpCSAT__ENG_SL","insignia_GI_ENG_SL"],
			["GrpCSAT__LOG","insignia_GI_LOG"],
			["GrpCSAT__LOG_SL","insignia_GI_LOG_SL"],
			["GrpCSAT__1PL","insignia_GI_1PL"],
			["GrpCSAT__ASL","insignia_GI_ASL"],
			["GrpCSAT__A1","insignia_GI_A1"],
			["GrpCSAT__A2","insignia_GI_A2"],
			["GrpCSAT__AV","insignia_GI_AV"],
			["GrpCSAT__BSL","insignia_GI_BSL"],
			["GrpCSAT__B1","insignia_GI_B1"],
			["GrpCSAT__B2","insignia_GI_B2"],
			["GrpCSAT__BV","insignia_GI_BV"],
			["GrpCSAT__CSL","insignia_GI_CSL"],
			["GrpCSAT__C1","insignia_GI_C1"],
			["GrpCSAT__C2","insignia_GI_C2"],
			["GrpCSAT__CV","insignia_GI_CV"],
			["GrpCSAT__2PL","insignia_GI_2PL"],
			["GrpCSAT__DSL","insignia_GI_DSL"],
			["GrpCSAT__D1","insignia_GI_D1"],
			["GrpCSAT__D2","insignia_GI_D2"],
			["GrpCSAT__DV","insignia_GI_DV"],
			["GrpCSAT__ESL","insignia_GI_ESL"],
			["GrpCSAT__E1","insignia_GI_E1"],
			["GrpCSAT__E2","insignia_GI_E2"],
			["GrpCSAT__EV","insignia_GI_EV"],
			["GrpCSAT__FSL","insignia_GI_FSL"],
			["GrpCSAT__F1","insignia_GI_F1"],
			["GrpCSAT__F2","insignia_GI_F2"],
			["GrpCSAT__FV","insignia_GI_FV"],
			["GrpCSAT__3PL","insignia_GI_3PL"],
			["GrpCSAT__GSL","insignia_GI_GSL"],
			["GrpCSAT__G1","insignia_GI_G1"],
			["GrpCSAT__G2","insignia_GI_G2"],
			["GrpCSAT__GV","insignia_GI_GV"],
			["GrpCSAT__HSL","insignia_GI_HSL"],
			["GrpCSAT__H1","insignia_GI_H1"],
			["GrpCSAT__H2","insignia_GI_H2"],
			["GrpCSAT__HV","insignia_GI_HV"],
			["GrpCSAT__ISL","insignia_GI_ISL"],
			["GrpCSAT__I1","insignia_GI_I1"],
			["GrpCSAT__I2","insignia_GI_I2"],
			["GrpCSAT__IV","insignia_GI_IV"]
		];
	};
	case "ind_f" : {
		_groupBadges = [
			["GrpAAF__COY","insignia_GI_COY"],
			["GrpAAF__AAA","insignia_GI_AAA"],
			["GrpAAF__MAT","insignia_GI_MAT"],
			["GrpAAF__HAT","insignia_GI_HAT"],
			["GrpAAF__GMG","insignia_GI_GMG"],
			["GrpAAF__MMG","insignia_GI_MMG"],
			["GrpAAF__HMG","insignia_GI_HMG"],
			["GrpAAF__MOR","insignia_GI_MOR"],
			["GrpAAF__REC","insignia_GI_REC"],
			["GrpAAF__ENG","insignia_GI_ENG"],
			["GrpAAF__ENG_SL","insignia_GI_ENG_SL"],
			["GrpAAF__LOG","insignia_GI_LOG"],
			["GrpAAF__LOG_SL","insignia_GI_LOG_SL"],
			["GrpAAF__1PL","insignia_GI_1PL"],
			["GrpAAF__ASL","insignia_GI_ASL"],
			["GrpAAF__A1","insignia_GI_A1"],
			["GrpAAF__A2","insignia_GI_A2"],
			["GrpAAF__AV","insignia_GI_AV"],
			["GrpAAF__BSL","insignia_GI_BSL"],
			["GrpAAF__B1","insignia_GI_B1"],
			["GrpAAF__B2","insignia_GI_B2"],
			["GrpAAF__BV","insignia_GI_BV"],
			["GrpAAF__CSL","insignia_GI_CSL"],
			["GrpAAF__C1","insignia_GI_C1"],
			["GrpAAF__C2","insignia_GI_C2"],
			["GrpAAF__CV","insignia_GI_CV"],
			["GrpAAF__2PL","insignia_GI_2PL"],
			["GrpAAF__DSL","insignia_GI_DSL"],
			["GrpAAF__D1","insignia_GI_D1"],
			["GrpAAF__D2","insignia_GI_D2"],
			["GrpAAF__DV","insignia_GI_DV"],
			["GrpAAF__ESL","insignia_GI_ESL"],
			["GrpAAF__E1","insignia_GI_E1"],
			["GrpAAF__E2","insignia_GI_E2"],
			["GrpAAF__EV","insignia_GI_EV"],
			["GrpAAF__FSL","insignia_GI_FSL"],
			["GrpAAF__F1","insignia_GI_F1"],
			["GrpAAF__F2","insignia_GI_F2"],
			["GrpAAF__FV","insignia_GI_FV"],
			["GrpAAF__3PL","insignia_GI_3PL"],
			["GrpAAF__GSL","insignia_GI_GSL"],
			["GrpAAF__G1","insignia_GI_G1"],
			["GrpAAF__G2","insignia_GI_G2"],
			["GrpAAF__GV","insignia_GI_GV"],
			["GrpAAF__HSL","insignia_GI_HSL"],
			["GrpAAF__H1","insignia_GI_H1"],
			["GrpAAF__H2","insignia_GI_H2"],
			["GrpAAF__HV","insignia_GI_HV"],
			["GrpAAF__ISL","insignia_GI_ISL"],
			["GrpAAF__I1","insignia_GI_I1"],
			["GrpAAF__I2","insignia_GI_I2"],
			["GrpAAF__IV","insignia_GI_IV"]
		];
	};
	case "blu_g_f" : {
		_groupBadges = [
			["GrpFIA__COY","insignia_GI_COY"],
			["GrpFIA__AAA","insignia_GI_AAA"],
			["GrpFIA__MAT","insignia_GI_MAT"],
			["GrpFIA__HAT","insignia_GI_HAT"],
			["GrpFIA__GMG","insignia_GI_GMG"],
			["GrpFIA__MMG","insignia_GI_MMG"],
			["GrpFIA__HMG","insignia_GI_HMG"],
			["GrpFIA__MOR","insignia_GI_MOR"],
			["GrpFIA__REC","insignia_GI_REC"],
			["GrpFIA__ENG","insignia_GI_ENG"],
			["GrpFIA__ENG_SL","insignia_GI_ENG_SL"],
			["GrpFIA__LOG","insignia_GI_LOG"],
			["GrpFIA__LOG_SL","insignia_GI_LOG_SL"],
			["GrpFIA__1PL","insignia_GI_1PL"],
			["GrpFIA__ASL","insignia_GI_ASL"],
			["GrpFIA__A1","insignia_GI_A1"],
			["GrpFIA__A2","insignia_GI_A2"],
			["GrpFIA__AV","insignia_GI_AV"],
			["GrpFIA__BSL","insignia_GI_BSL"],
			["GrpFIA__B1","insignia_GI_B1"],
			["GrpFIA__B2","insignia_GI_B2"],
			["GrpFIA__BV","insignia_GI_BV"],
			["GrpFIA__CSL","insignia_GI_CSL"],
			["GrpFIA__C1","insignia_GI_C1"],
			["GrpFIA__C2","insignia_GI_C2"],
			["GrpFIA__CV","insignia_GI_CV"],
			["GrpFIA__2PL","insignia_GI_2PL"],
			["GrpFIA__DSL","insignia_GI_DSL"],
			["GrpFIA__D1","insignia_GI_D1"],
			["GrpFIA__D2","insignia_GI_D2"],
			["GrpFIA__DV","insignia_GI_DV"],
			["GrpFIA__ESL","insignia_GI_ESL"],
			["GrpFIA__E1","insignia_GI_E1"],
			["GrpFIA__E2","insignia_GI_E2"],
			["GrpFIA__EV","insignia_GI_EV"],
			["GrpFIA__FSL","insignia_GI_FSL"],
			["GrpFIA__F1","insignia_GI_F1"],
			["GrpFIA__F2","insignia_GI_F2"],
			["GrpFIA__FV","insignia_GI_FV"],
			["GrpFIA__3PL","insignia_GI_3PL"],
			["GrpFIA__GSL","insignia_GI_GSL"],
			["GrpFIA__G1","insignia_GI_G1"],
			["GrpFIA__G2","insignia_GI_G2"],
			["GrpFIA__GV","insignia_GI_GV"],
			["GrpFIA__HSL","insignia_GI_HSL"],
			["GrpFIA__H1","insignia_GI_H1"],
			["GrpFIA__H2","insignia_GI_H2"],
			["GrpFIA__HV","insignia_GI_HV"],
			["GrpFIA__ISL","insignia_GI_ISL"],
			["GrpFIA__I1","insignia_GI_I1"],
			["GrpFIA__I2","insignia_GI_I2"],
			["GrpFIA__IV","insignia_GI_IV"]
		];
	};
	case "opf_g_f" : {
		_groupBadges = [
			["GrpOFIA__COY","insignia_GI_COY"],
			["GrpOFIA__AAA","insignia_GI_AAA"],
			["GrpOFIA__MAT","insignia_GI_MAT"],
			["GrpOFIA__HAT","insignia_GI_HAT"],
			["GrpOFIA__GMG","insignia_GI_GMG"],
			["GrpOFIA__MMG","insignia_GI_MMG"],
			["GrpOFIA__HMG","insignia_GI_HMG"],
			["GrpOFIA__MOR","insignia_GI_MOR"],
			["GrpOFIA__REC","insignia_GI_REC"],
			["GrpOFIA__ENG","insignia_GI_ENG"],
			["GrpOFIA__ENG_SL","insignia_GI_ENG_SL"],
			["GrpOFIA__LOG","insignia_GI_LOG"],
			["GrpOFIA__LOG_SL","insignia_GI_LOG_SL"],
			["GrpOFIA__1PL","insignia_GI_1PL"],
			["GrpOFIA__ASL","insignia_GI_ASL"],
			["GrpOFIA__A1","insignia_GI_A1"],
			["GrpOFIA__A2","insignia_GI_A2"],
			["GrpOFIA__AV","insignia_GI_AV"],
			["GrpOFIA__BSL","insignia_GI_BSL"],
			["GrpOFIA__B1","insignia_GI_B1"],
			["GrpOFIA__B2","insignia_GI_B2"],
			["GrpOFIA__BV","insignia_GI_BV"],
			["GrpOFIA__CSL","insignia_GI_CSL"],
			["GrpOFIA__C1","insignia_GI_C1"],
			["GrpOFIA__C2","insignia_GI_C2"],
			["GrpOFIA__CV","insignia_GI_CV"],
			["GrpOFIA__2PL","insignia_GI_2PL"],
			["GrpOFIA__DSL","insignia_GI_DSL"],
			["GrpOFIA__D1","insignia_GI_D1"],
			["GrpOFIA__D2","insignia_GI_D2"],
			["GrpOFIA__DV","insignia_GI_DV"],
			["GrpOFIA__ESL","insignia_GI_ESL"],
			["GrpOFIA__E1","insignia_GI_E1"],
			["GrpOFIA__E2","insignia_GI_E2"],
			["GrpOFIA__EV","insignia_GI_EV"],
			["GrpOFIA__FSL","insignia_GI_FSL"],
			["GrpOFIA__F1","insignia_GI_F1"],
			["GrpOFIA__F2","insignia_GI_F2"],
			["GrpOFIA__FV","insignia_GI_FV"],
			["GrpOFIA__3PL","insignia_GI_3PL"],
			["GrpOFIA__GSL","insignia_GI_GSL"],
			["GrpOFIA__G1","insignia_GI_G1"],
			["GrpOFIA__G2","insignia_GI_G2"],
			["GrpOFIA__GV","insignia_GI_GV"],
			["GrpOFIA__HSL","insignia_GI_HSL"],
			["GrpOFIA__H1","insignia_GI_H1"],
			["GrpOFIA__H2","insignia_GI_H2"],
			["GrpOFIA__HV","insignia_GI_HV"],
			["GrpOFIA__ISL","insignia_GI_ISL"],
			["GrpOFIA__I1","insignia_GI_I1"],
			["GrpOFIA__I2","insignia_GI_I2"],
			["GrpOFIA__IV","insignia_GI_IV"]
		];
	};case "ind_g_f" : {
		_groupBadges = [
			["GrpIFIA__COY","insignia_GI_COY"],
			["GrpIFIA__AAA","insignia_GI_AAA"],
			["GrpIFIA__MAT","insignia_GI_MAT"],
			["GrpIFIA__HAT","insignia_GI_HAT"],
			["GrpIFIA__GMG","insignia_GI_GMG"],
			["GrpIFIA__MMG","insignia_GI_MMG"],
			["GrpIFIA__HMG","insignia_GI_HMG"],
			["GrpIFIA__MOR","insignia_GI_MOR"],
			["GrpIFIA__REC","insignia_GI_REC"],
			["GrpIFIA__ENG","insignia_GI_ENG"],
			["GrpIFIA__ENG_SL","insignia_GI_ENG_SL"],
			["GrpIFIA__LOG","insignia_GI_LOG"],
			["GrpIFIA__LOG_SL","insignia_GI_LOG_SL"],
			["GrpIFIA__1PL","insignia_GI_1PL"],
			["GrpIFIA__ASL","insignia_GI_ASL"],
			["GrpIFIA__A1","insignia_GI_A1"],
			["GrpIFIA__A2","insignia_GI_A2"],
			["GrpIFIA__AV","insignia_GI_AV"],
			["GrpIFIA__BSL","insignia_GI_BSL"],
			["GrpIFIA__B1","insignia_GI_B1"],
			["GrpIFIA__B2","insignia_GI_B2"],
			["GrpIFIA__BV","insignia_GI_BV"],
			["GrpIFIA__CSL","insignia_GI_CSL"],
			["GrpIFIA__C1","insignia_GI_C1"],
			["GrpIFIA__C2","insignia_GI_C2"],
			["GrpIFIA__CV","insignia_GI_CV"],
			["GrpIFIA__2PL","insignia_GI_2PL"],
			["GrpIFIA__DSL","insignia_GI_DSL"],
			["GrpIFIA__D1","insignia_GI_D1"],
			["GrpIFIA__D2","insignia_GI_D2"],
			["GrpIFIA__DV","insignia_GI_DV"],
			["GrpIFIA__ESL","insignia_GI_ESL"],
			["GrpIFIA__E1","insignia_GI_E1"],
			["GrpIFIA__E2","insignia_GI_E2"],
			["GrpIFIA__EV","insignia_GI_EV"],
			["GrpIFIA__FSL","insignia_GI_FSL"],
			["GrpIFIA__F1","insignia_GI_F1"],
			["GrpIFIA__F2","insignia_GI_F2"],
			["GrpIFIA__FV","insignia_GI_FV"],
			["GrpIFIA__3PL","insignia_GI_3PL"],
			["GrpIFIA__GSL","insignia_GI_GSL"],
			["GrpIFIA__G1","insignia_GI_G1"],
			["GrpIFIA__G2","insignia_GI_G2"],
			["GrpIFIA__GV","insignia_GI_GV"],
			["GrpIFIA__HSL","insignia_GI_HSL"],
			["GrpIFIA__H1","insignia_GI_H1"],
			["GrpIFIA__H2","insignia_GI_H2"],
			["GrpIFIA__HV","insignia_GI_HV"],
			["GrpIFIA__ISL","insignia_GI_ISL"],
			["GrpIFIA__I1","insignia_GI_I1"],
			["GrpIFIA__I2","insignia_GI_I2"],
			["GrpIFIA__IV","insignia_GI_IV"]
		];
	};
};

// ====================================================================================
// END OF CONFIGURABLE SETTINGS - BELOW ASSIGNS THE INSIGNIAS
// ====================================================================================

// Loop through the groups and match badges to the group _unit belongs to. Due to the groups being variables this requires calling formatted at runtime code.

_group = (group _unit);


{
	if(!isnil (_x select 0)) then {
			call compile format ["
				if (%1==_group) then {
					_badge = _x select 1;
				};
			",_x select 0];
	};
} forEach _groupBadges;

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