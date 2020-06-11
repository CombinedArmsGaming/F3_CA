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
			["GrpCSAT_COY","insignia_GI_COY"],
			["GrpCSAT_AAA","insignia_GI_AAA"],
			["GrpCSAT_MAT","insignia_GI_MAT"],
			["GrpCSAT_HAT","insignia_GI_HAT"],
			["GrpCSAT_GMG","insignia_GI_GMG"],
			["GrpCSAT_MMG","insignia_GI_MMG"],
			["GrpCSAT_HMG","insignia_GI_HMG"],
			["GrpCSAT_MOR","insignia_GI_MOR"],
			["GrpCSAT_REC","insignia_GI_REC"],
			["GrpCSAT_ENG","insignia_GI_ENG"],
			["GrpCSAT_ENG_SL","insignia_GI_ENG_SL"],
			["GrpCSAT_LOG","insignia_GI_LOG"],
			["GrpCSAT_LOG_SL","insignia_GI_LOG_SL"],
			["GrpCSAT_1PL","insignia_GI_1PL"],
			["GrpCSAT_ASL","insignia_GI_ASL"],
			["GrpCSAT_A1","insignia_GI_A1"],
			["GrpCSAT_A2","insignia_GI_A2"],
			["GrpCSAT_AV","insignia_GI_AV"],
			["GrpCSAT_BSL","insignia_GI_BSL"],
			["GrpCSAT_B1","insignia_GI_B1"],
			["GrpCSAT_B2","insignia_GI_B2"],
			["GrpCSAT_BV","insignia_GI_BV"],
			["GrpCSAT_CSL","insignia_GI_CSL"],
			["GrpCSAT_C1","insignia_GI_C1"],
			["GrpCSAT_C2","insignia_GI_C2"],
			["GrpCSAT_CV","insignia_GI_CV"],
			["GrpCSAT_2PL","insignia_GI_2PL"],
			["GrpCSAT_DSL","insignia_GI_DSL"],
			["GrpCSAT_D1","insignia_GI_D1"],
			["GrpCSAT_D2","insignia_GI_D2"],
			["GrpCSAT_DV","insignia_GI_DV"],
			["GrpCSAT_ESL","insignia_GI_ESL"],
			["GrpCSAT_E1","insignia_GI_E1"],
			["GrpCSAT_E2","insignia_GI_E2"],
			["GrpCSAT_EV","insignia_GI_EV"],
			["GrpCSAT_FSL","insignia_GI_FSL"],
			["GrpCSAT_F1","insignia_GI_F1"],
			["GrpCSAT_F2","insignia_GI_F2"],
			["GrpCSAT_FV","insignia_GI_FV"],
			["GrpCSAT_3PL","insignia_GI_3PL"],
			["GrpCSAT_GSL","insignia_GI_GSL"],
			["GrpCSAT_G1","insignia_GI_G1"],
			["GrpCSAT_G2","insignia_GI_G2"],
			["GrpCSAT_GV","insignia_GI_GV"],
			["GrpCSAT_HSL","insignia_GI_HSL"],
			["GrpCSAT_H1","insignia_GI_H1"],
			["GrpCSAT_H2","insignia_GI_H2"],
			["GrpCSAT_HV","insignia_GI_HV"],
			["GrpCSAT_ISL","insignia_GI_ISL"],
			["GrpCSAT_I1","insignia_GI_I1"],
			["GrpCSAT_I2","insignia_GI_I2"],
			["GrpCSAT_IV","insignia_GI_IV"]
		];
	};
	case "ind_f" : {
		_groupBadges = [
			["GrpAAF_COY","insignia_GI_COY"],
			["GrpAAF_AAA","insignia_GI_AAA"],
			["GrpAAF_MAT","insignia_GI_MAT"],
			["GrpAAF_HAT","insignia_GI_HAT"],
			["GrpAAF_GMG","insignia_GI_GMG"],
			["GrpAAF_MMG","insignia_GI_MMG"],
			["GrpAAF_HMG","insignia_GI_HMG"],
			["GrpAAF_MOR","insignia_GI_MOR"],
			["GrpAAF_REC","insignia_GI_REC"],
			["GrpAAF_ENG","insignia_GI_ENG"],
			["GrpAAF_ENG_SL","insignia_GI_ENG_SL"],
			["GrpAAF_LOG","insignia_GI_LOG"],
			["GrpAAF_LOG_SL","insignia_GI_LOG_SL"],
			["GrpAAF_1PL","insignia_GI_1PL"],
			["GrpAAF_ASL","insignia_GI_ASL"],
			["GrpAAF_A1","insignia_GI_A1"],
			["GrpAAF_A2","insignia_GI_A2"],
			["GrpAAF_AV","insignia_GI_AV"],
			["GrpAAF_BSL","insignia_GI_BSL"],
			["GrpAAF_B1","insignia_GI_B1"],
			["GrpAAF_B2","insignia_GI_B2"],
			["GrpAAF_BV","insignia_GI_BV"],
			["GrpAAF_CSL","insignia_GI_CSL"],
			["GrpAAF_C1","insignia_GI_C1"],
			["GrpAAF_C2","insignia_GI_C2"],
			["GrpAAF_CV","insignia_GI_CV"],
			["GrpAAF_2PL","insignia_GI_2PL"],
			["GrpAAF_DSL","insignia_GI_DSL"],
			["GrpAAF_D1","insignia_GI_D1"],
			["GrpAAF_D2","insignia_GI_D2"],
			["GrpAAF_DV","insignia_GI_DV"],
			["GrpAAF_ESL","insignia_GI_ESL"],
			["GrpAAF_E1","insignia_GI_E1"],
			["GrpAAF_E2","insignia_GI_E2"],
			["GrpAAF_EV","insignia_GI_EV"],
			["GrpAAF_FSL","insignia_GI_FSL"],
			["GrpAAF_F1","insignia_GI_F1"],
			["GrpAAF_F2","insignia_GI_F2"],
			["GrpAAF_FV","insignia_GI_FV"],
			["GrpAAF_3PL","insignia_GI_3PL"],
			["GrpAAF_GSL","insignia_GI_GSL"],
			["GrpAAF_G1","insignia_GI_G1"],
			["GrpAAF_G2","insignia_GI_G2"],
			["GrpAAF_GV","insignia_GI_GV"],
			["GrpAAF_HSL","insignia_GI_HSL"],
			["GrpAAF_H1","insignia_GI_H1"],
			["GrpAAF_H2","insignia_GI_H2"],
			["GrpAAF_HV","insignia_GI_HV"],
			["GrpAAF_ISL","insignia_GI_ISL"],
			["GrpAAF_I1","insignia_GI_I1"],
			["GrpAAF_I2","insignia_GI_I2"],
			["GrpAAF_IV","insignia_GI_IV"]
		];
	};
	case "blu_g_f" : {
		_groupBadges = [
			["GrpFIA_COY","insignia_GI_COY"],
			["GrpFIA_AAA","insignia_GI_AAA"],
			["GrpFIA_MAT","insignia_GI_MAT"],
			["GrpFIA_HAT","insignia_GI_HAT"],
			["GrpFIA_GMG","insignia_GI_GMG"],
			["GrpFIA_MMG","insignia_GI_MMG"],
			["GrpFIA_HMG","insignia_GI_HMG"],
			["GrpFIA_MOR","insignia_GI_MOR"],
			["GrpFIA_REC","insignia_GI_REC"],
			["GrpFIA_ENG","insignia_GI_ENG"],
			["GrpFIA_ENG_SL","insignia_GI_ENG_SL"],
			["GrpFIA_LOG","insignia_GI_LOG"],
			["GrpFIA_LOG_SL","insignia_GI_LOG_SL"],
			["GrpFIA_1PL","insignia_GI_1PL"],
			["GrpFIA_ASL","insignia_GI_ASL"],
			["GrpFIA_A1","insignia_GI_A1"],
			["GrpFIA_A2","insignia_GI_A2"],
			["GrpFIA_AV","insignia_GI_AV"],
			["GrpFIA_BSL","insignia_GI_BSL"],
			["GrpFIA_B1","insignia_GI_B1"],
			["GrpFIA_B2","insignia_GI_B2"],
			["GrpFIA_BV","insignia_GI_BV"],
			["GrpFIA_CSL","insignia_GI_CSL"],
			["GrpFIA_C1","insignia_GI_C1"],
			["GrpFIA_C2","insignia_GI_C2"],
			["GrpFIA_CV","insignia_GI_CV"],
			["GrpFIA_2PL","insignia_GI_2PL"],
			["GrpFIA_DSL","insignia_GI_DSL"],
			["GrpFIA_D1","insignia_GI_D1"],
			["GrpFIA_D2","insignia_GI_D2"],
			["GrpFIA_DV","insignia_GI_DV"],
			["GrpFIA_ESL","insignia_GI_ESL"],
			["GrpFIA_E1","insignia_GI_E1"],
			["GrpFIA_E2","insignia_GI_E2"],
			["GrpFIA_EV","insignia_GI_EV"],
			["GrpFIA_FSL","insignia_GI_FSL"],
			["GrpFIA_F1","insignia_GI_F1"],
			["GrpFIA_F2","insignia_GI_F2"],
			["GrpFIA_FV","insignia_GI_FV"],
			["GrpFIA_3PL","insignia_GI_3PL"],
			["GrpFIA_GSL","insignia_GI_GSL"],
			["GrpFIA_G1","insignia_GI_G1"],
			["GrpFIA_G2","insignia_GI_G2"],
			["GrpFIA_GV","insignia_GI_GV"],
			["GrpFIA_HSL","insignia_GI_HSL"],
			["GrpFIA_H1","insignia_GI_H1"],
			["GrpFIA_H2","insignia_GI_H2"],
			["GrpFIA_HV","insignia_GI_HV"],
			["GrpFIA_ISL","insignia_GI_ISL"],
			["GrpFIA_I1","insignia_GI_I1"],
			["GrpFIA_I2","insignia_GI_I2"],
			["GrpFIA_IV","insignia_GI_IV"]
		];
	};
	case "opf_g_f" : {
		_groupBadges = [
			["GrpOFIA_COY","insignia_GI_COY"],
			["GrpOFIA_AAA","insignia_GI_AAA"],
			["GrpOFIA_MAT","insignia_GI_MAT"],
			["GrpOFIA_HAT","insignia_GI_HAT"],
			["GrpOFIA_GMG","insignia_GI_GMG"],
			["GrpOFIA_MMG","insignia_GI_MMG"],
			["GrpOFIA_HMG","insignia_GI_HMG"],
			["GrpOFIA_MOR","insignia_GI_MOR"],
			["GrpOFIA_REC","insignia_GI_REC"],
			["GrpOFIA_ENG","insignia_GI_ENG"],
			["GrpOFIA_ENG_SL","insignia_GI_ENG_SL"],
			["GrpOFIA_LOG","insignia_GI_LOG"],
			["GrpOFIA_LOG_SL","insignia_GI_LOG_SL"],
			["GrpOFIA_1PL","insignia_GI_1PL"],
			["GrpOFIA_ASL","insignia_GI_ASL"],
			["GrpOFIA_A1","insignia_GI_A1"],
			["GrpOFIA_A2","insignia_GI_A2"],
			["GrpOFIA_AV","insignia_GI_AV"],
			["GrpOFIA_BSL","insignia_GI_BSL"],
			["GrpOFIA_B1","insignia_GI_B1"],
			["GrpOFIA_B2","insignia_GI_B2"],
			["GrpOFIA_BV","insignia_GI_BV"],
			["GrpOFIA_CSL","insignia_GI_CSL"],
			["GrpOFIA_C1","insignia_GI_C1"],
			["GrpOFIA_C2","insignia_GI_C2"],
			["GrpOFIA_CV","insignia_GI_CV"],
			["GrpOFIA_2PL","insignia_GI_2PL"],
			["GrpOFIA_DSL","insignia_GI_DSL"],
			["GrpOFIA_D1","insignia_GI_D1"],
			["GrpOFIA_D2","insignia_GI_D2"],
			["GrpOFIA_DV","insignia_GI_DV"],
			["GrpOFIA_ESL","insignia_GI_ESL"],
			["GrpOFIA_E1","insignia_GI_E1"],
			["GrpOFIA_E2","insignia_GI_E2"],
			["GrpOFIA_EV","insignia_GI_EV"],
			["GrpOFIA_FSL","insignia_GI_FSL"],
			["GrpOFIA_F1","insignia_GI_F1"],
			["GrpOFIA_F2","insignia_GI_F2"],
			["GrpOFIA_FV","insignia_GI_FV"],
			["GrpOFIA_3PL","insignia_GI_3PL"],
			["GrpOFIA_GSL","insignia_GI_GSL"],
			["GrpOFIA_G1","insignia_GI_G1"],
			["GrpOFIA_G2","insignia_GI_G2"],
			["GrpOFIA_GV","insignia_GI_GV"],
			["GrpOFIA_HSL","insignia_GI_HSL"],
			["GrpOFIA_H1","insignia_GI_H1"],
			["GrpOFIA_H2","insignia_GI_H2"],
			["GrpOFIA_HV","insignia_GI_HV"],
			["GrpOFIA_ISL","insignia_GI_ISL"],
			["GrpOFIA_I1","insignia_GI_I1"],
			["GrpOFIA_I2","insignia_GI_I2"],
			["GrpOFIA_IV","insignia_GI_IV"]
		];
	};case "ind_g_f" : {
		_groupBadges = [
			["GrpIFIA_COY","insignia_GI_COY"],
			["GrpIFIA_AAA","insignia_GI_AAA"],
			["GrpIFIA_MAT","insignia_GI_MAT"],
			["GrpIFIA_HAT","insignia_GI_HAT"],
			["GrpIFIA_GMG","insignia_GI_GMG"],
			["GrpIFIA_MMG","insignia_GI_MMG"],
			["GrpIFIA_HMG","insignia_GI_HMG"],
			["GrpIFIA_MOR","insignia_GI_MOR"],
			["GrpIFIA_REC","insignia_GI_REC"],
			["GrpIFIA_ENG","insignia_GI_ENG"],
			["GrpIFIA_ENG_SL","insignia_GI_ENG_SL"],
			["GrpIFIA_LOG","insignia_GI_LOG"],
			["GrpIFIA_LOG_SL","insignia_GI_LOG_SL"],
			["GrpIFIA_1PL","insignia_GI_1PL"],
			["GrpIFIA_ASL","insignia_GI_ASL"],
			["GrpIFIA_A1","insignia_GI_A1"],
			["GrpIFIA_A2","insignia_GI_A2"],
			["GrpIFIA_AV","insignia_GI_AV"],
			["GrpIFIA_BSL","insignia_GI_BSL"],
			["GrpIFIA_B1","insignia_GI_B1"],
			["GrpIFIA_B2","insignia_GI_B2"],
			["GrpIFIA_BV","insignia_GI_BV"],
			["GrpIFIA_CSL","insignia_GI_CSL"],
			["GrpIFIA_C1","insignia_GI_C1"],
			["GrpIFIA_C2","insignia_GI_C2"],
			["GrpIFIA_CV","insignia_GI_CV"],
			["GrpIFIA_2PL","insignia_GI_2PL"],
			["GrpIFIA_DSL","insignia_GI_DSL"],
			["GrpIFIA_D1","insignia_GI_D1"],
			["GrpIFIA_D2","insignia_GI_D2"],
			["GrpIFIA_DV","insignia_GI_DV"],
			["GrpIFIA_ESL","insignia_GI_ESL"],
			["GrpIFIA_E1","insignia_GI_E1"],
			["GrpIFIA_E2","insignia_GI_E2"],
			["GrpIFIA_EV","insignia_GI_EV"],
			["GrpIFIA_FSL","insignia_GI_FSL"],
			["GrpIFIA_F1","insignia_GI_F1"],
			["GrpIFIA_F2","insignia_GI_F2"],
			["GrpIFIA_FV","insignia_GI_FV"],
			["GrpIFIA_3PL","insignia_GI_3PL"],
			["GrpIFIA_GSL","insignia_GI_GSL"],
			["GrpIFIA_G1","insignia_GI_G1"],
			["GrpIFIA_G2","insignia_GI_G2"],
			["GrpIFIA_GV","insignia_GI_GV"],
			["GrpIFIA_HSL","insignia_GI_HSL"],
			["GrpIFIA_H1","insignia_GI_H1"],
			["GrpIFIA_H2","insignia_GI_H2"],
			["GrpIFIA_HV","insignia_GI_HV"],
			["GrpIFIA_ISL","insignia_GI_ISL"],
			["GrpIFIA_I1","insignia_GI_I1"],
			["GrpIFIA_I2","insignia_GI_I2"],
			["GrpIFIA_IV","insignia_GI_IV"]
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