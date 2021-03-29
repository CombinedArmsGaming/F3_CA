// F3 - Folk ARPS Assign Gear Script - NATO
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DEFINE EQUIPMENT TABLES
// The blocks of code below identifies equipment for this faction
//
// Defined loadouts:
// co - commander/officer 
// rad - radio operator, forward air control (backpack radio) 
// sl - squad leader 
// med - medic 
// sur - surgeon -- This unit has currently too many items assigned to it.
// ftl - fire team leader 
// ar - automatic rifleman 
// aar - assistant automatic rifleman 
// lat- light anti tank -- Uses PCML, but it is currently single shot while getting ammo.
// dm - designated marksman 
// mmg - medium mg gunner 
// ammg - medium mg assistant -- This unit has currently slightly too many items assigned to it. maybe switch to carbine
// hmg - heavy mg gunner (deployable) 
// ahmg - heavy mg assistant (deployable) 
// mat - medium AT gunner -- Same issue as LAT
// amat - medium AT assistant 
// hat - heavy AT gunner 
// ahat - heavy AT assistant 
// mtr - mortar gunner (deployable)
// amtr - mortar assistant (deployable) 
// sam - SAM gunner 
// asam - SAM assistant gunner 
// sn - sniper 
// sp - spotter (for sniper) 
// vc - vehicle commander 
// vg - vehicle gunner -- Kind of pointless?
// vd - vehicle driver (repair) 
// pil - air vehicle pilot 
// pcc - air vehicle co-pilot (repair) / crew chief (repair) 
// eng - engineer 
// dem - demolitions 
// uav - UAV operator 
// rif - rifleman
// car - carabineer
// smg - submachinegunner
// gren - grenadier
// v_car - CARGO: CAR - room for 10 weapons and 50 cargo items
// v_tr - CARGO: TRUCK - room for 50 weapons and 200 cargo items
// v_ifv - CARGO: IFV - room for 10 weapons and 100 cargo items
// crate_small - CRATE: Small, ammo for 1 fireteam
// crate_med - CRATE: Medium, ammo for 1 squad
// crate_large - CRATE: Large, ammo for 1 platoon

// GENERAL EQUIPMENT USED BY MULTIPLE CLASSES

// ATTACHMENTS - PRIMARY
_attach1 = "acc_pointer_IR";	// IR Laser
_attach2 = "acc_flashlight";	// Flashlight

_silencer1 = "muzzle_snds_M";	// 5.56 suppressor
_silencer2 = "muzzle_snds_H";	// 6.5 suppressor

_scope1 = "optic_Holosight";	// Holosight
_scope2 = "optic_MRCO";			// MRCO Scope - 1x - 6x
_scope3 = "optic_SOS";			// SOS Scope - 18x - 75x

_bipod1 = "bipod_01_F_snd";		// Default bipod
_bipod2 = "bipod_02_F_blk";		// Black bipod


// Examples of Attachment Definitions:
// [] = remove all
// [_attach1,_scope1,_silencer] = remove all, add items assigned in _attach1, _scope1 and _silencer1
// [_scope2] = add _scope2, remove rest
// false = keep attachments as they are

// ====================================================================================
// ATTACHMENTS - HANDGUN
_hg_silencer1 = "muzzle_snds_acp";	// .45 suppressor
_hg_scope1 = "optic_MRD";			// MRD
// Default setup
_hg_attachments= []; // The default attachment set for handguns, overwritten in the individual unitType
// ====================================================================================

// AMMO SETTINGS
// Ratio between tracers and normal mags 0 = all normal magazines, 1 = all tracer magazines. Values are rounded.
_tracermagfraction = 0.2;
// How much the assistant carries compared to the gunner
_assistantfraction = 0.5;

// ====================================================================================

// WEAPON SELECTION

// Standard Riflemen 
_rifle = ["arifle_MX_pointer_F"];
_riflemag = "30Rnd_65x39_caseless_mag";
_riflemag_tr = "30Rnd_65x39_caseless_mag_Tracer";
_riflemagamount = 10;
_rifleattachments = [_scope1,_attach1];
_rifleclasses = ["rif","aar","lat","ammg"];

// Standard Carabineer
_carbine = ["arifle_MXC_F"];
_carbinemag = "30Rnd_65x39_caseless_mag";
_carbinemag_tr = "30Rnd_65x39_caseless_mag_Tracer";
_carbinemagamount = 6;
_carbineattachments = [_scope1,_attach1];
_carbineclasses = ["car","med","sur","mat","amat","mtr","amtr","eng","dem","hmg","ahmg","hat","ahat","sam","asam"];

// Standard Submachine Gun/Personal Defence Weapon
_smg = ["SMG_01_F"];
_smgmag = "30Rnd_45ACP_Mag_SMG_01";
_smgmag_tr = "30Rnd_45ACP_Mag_SMG_01_tracer_green";
_smgmagamount = 5;
_smgattachments = [_scope1];
_smgclasses = ["smg","pil","pcc","vc","vg","vd","uav","rad"];

// Rifle with GL and HE grenades
_glrifle = ["arifle_MX_GL_F"];
_glriflemag = "30Rnd_65x39_caseless_mag";
_glriflemag_tr = "30Rnd_65x39_caseless_mag_Tracer";
_glriflemagamount = 10;
_glrifleattachments = [_scope1,_attach1];
_glmag = "1Rnd_HE_Grenade_shell";
_glmagamount = 10;
_glrifleclasses = ["gren","co","sl","ftl","sp"];

// Smoke for FTLs, Squad Leaders, etc
_glsmokewhite = "1Rnd_Smoke_Grenade_shell";
_glsmokewhiteamount = 2;
// Red, Blue, Green, Yellow, Orange, Purple
_glredsmoke = "1Rnd_SmokeRed_Grenade_shell";
_glbluesmoke = "1Rnd_SmokeBlue_Grenade_shell";
_glgreensmoke = "1Rnd_SmokeGreen_Grenade_shell";
_glyellowsmoke = "1Rnd_SmokeYellow_Grenade_shell";
_glorangesmoke = "1Rnd_SmokeOrange_Grenade_shell";
_glpurplesmoke = "1Rnd_SmokePurple_Grenade_shell";
_glsmokecoloredamount = 2;
// Colored smoke grenades
_redsmoke = "SmokeShellRed";
_bluesmoke = "SmokeShellBlue";
_greensmoke = "SmokeShellGreen";
_yellowsmoke = "SmokeShellYellow";
_orangesmoke = "SmokeShellOrange";
_purplesmoke = "SmokeShellPurple";
// If in _glrifleclasses, then they will get the equivalent gl smokes
_coloredsmokeclasses = ["co","sl","ftl","sp"];
_coloredsmokes = [_redsmoke,_bluesmoke,_greensmoke];
//_coloredsmokes = [_redsmoke,_bluesmoke,_greensmoke,_yellowsmoke,_orangesmoke,_purplesmoke];
// Amount per color of smoke
_smokegrenadecoloredamount = 2;
// Grenades
_grenade = "HandGrenade";
_grenadeamount = 2;
_Mgrenade = "MiniGrenade";
_Mgrenadeamount = 1;
_smokegrenade = "SmokeShell";
_smokegrenadeamount = 2;

// Flares for FTLs, Squad Leaders, etc
_glflare = ["UGL_FlareWhite_F","UGL_FlareRed_F","UGL_FlareYellow_F","UGL_FlareGreen_F"];
_glflareamount = 0;

// Pistols (CO, DC, Automatic Rifleman, Medium MG Gunner)
_pistol = ["hgun_Pistol_heavy_01_F"];
_pistolmag = "11Rnd_45ACP_Mag";
_pistolmagamount = 2;
_pistolclasses = ["co","sl","ar","mmg","rad","sur","dm","sn"];

// UNIQUE, ROLE-SPECIFIC EQUIPMENT

// Automatic Rifleman
_AR = ["arifle_MX_SW_F"];
_ARmag = "100Rnd_65x39_caseless_mag";
_ARmag_tr = "100Rnd_65x39_caseless_mag_Tracer";
_ARattachments = [_scope1,_attach1,_bipod1];
_ARmagamount = 7;

// Medium MG
_MMG = "MMG_02_sand_F";
_MMGmag = "130Rnd_338_Mag";
_MMGmag_tr = "130Rnd_338_Mag";
_MMGattachments = [_scope2,_attach1,_bipod1];
_MMGmagamount = 4;

// NON-DLC ALTERNATIVE:
// _MMG = "LMG_Zafir_F";
// _MMGmag = ""150Rnd_762x54_Box"";
// _MMGmag_tr = ""150Rnd_762x54_Box"_Tracer";

// Marksman rifle - DM
_DMrifle = "srifle_DMR_03_tan_F";
_DMriflemag = "20Rnd_762x51_Mag";
_DMattachments = [_scope2,_attach1,_bipod1];
_DMriflemagamount = 10;

// MAR-10
//_DMrifle = "srifle_DMR_02_F";
//_DMriflemag = "10Rnd_338_Mag";

// Light anti tank. To indicate that a weapon is single shot, write _RATmag = "";
_RAT = "launch_NLAW_F";
_RATmag = ""; // In Ace the ammo, "NLAW_F" is single shot, and thus not used
_RATmagamount = 0; 

// Medium AT - Tanks DLC
_MAT = "launch_MRAWS_green_rail_F";
_MATmag1 = "MRAWS_HEAT_F";
_MATmag2 = "MRAWS_HE_F";
_MATmag1amount = 2;
_MATmag2amount = 1;

// Surface Air
_SAM = "launch_B_Titan_F";
_SAMmag = "Titan_AA";
_SAMmagamount = 1;

// Heavy AT
_HAT = "launch_B_Titan_short_F";
_HATmag1 = "Titan_AT";
_HATmag2 = "Titan_AP";
_HATmag1amount = 2;
_HATmag2amount = 1;

// Heavy machine gun - To use backpack, set _HMGTripod, _HMGmag, _HMG = ""; 
// To use launcher, set _bagahmg and _baghmg = ""; Do not delete any of the lines.
// Having both will give you both weapons 
_HMG = "ace_csw_staticHMGCarry";
_HMGTripod = "ace_csw_m3CarryTripodLow";
_HMGmag = "ace_csw_100Rnd_127x99_mag_red";
_HMGmagamount = 2;
_baghmg = ""; // "B_HMG_01_weapon_F"
_bagahmg = ""; // "B_HMG_01_support_F"

// Sniper rifle
_SNrifle = "srifle_LRR_F";
_SNrifleMag = "7Rnd_408_Mag";
_SNattachments = [_scope3,_bipod1];
_SNrifleMagamount = 15;

// Demolition items, 1 each per item in the array. eg _demoitems = ["DemoCharge_Remote_Mag","DemoCharge_Remote_Mag"]; Gives 2 democharges.
_demoitems = ["MineDetector","ACE_M26_Clacker","ACE_wirecutter","ACE_DefusalKit,""ATMine_Range_Mag","DemoCharge_Remote_Mag","APERSMine_Range_Mag"];
// Engineer items 
_engineeritems = ["ACE_wirecutter","ACE_DefusalKit"];

// Entrenching tools 
_entrenchingtool = "ACE_EntrenchingTool";
_entrenchingclasses = ["med","aar","lat","ammg","ahmg","amat","amtr","sp","dem","eng","rif","car","gren"];
// Night Vision Goggles (NVGoggles)
_nvg = "NVGoggles";

// UAV Terminal
_uavterminal = "B_UavTerminal";	  // BLUFOR - FIA

// Chemlights
_chemlights = ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"];
_chemlightsamount = 0;
//Binoculars 
_binocular = "Binocular"; // Regular 
_rangefinder = "Rangefinder"; // Rangefinder
_laserdesignator = "Laserdesignator"; 

// ====================================================================================

// CLOTHES AND UNIFORMS

// Backpacks
_baguav = "B_UAV_01_backpack_F";			// used by UAV operator
_bagmtr = "B_Mortar_01_weapon_F";			// used by Mortar gunner
_bagamtr = "B_Mortar_01_support_F";			// used by Mortar assistant gunner

// Define classes. This defines which gear class gets which uniform
// "medium" vests are used for all classes if they are not assigned a specific uniform

_light = ["hmg","ahmg","mat","ammg"];
_heavy =  ["eng","dem"];
_pilot = ["pil","pcc"];
_crew = ["vc","vg","vd"];
_ghillie = ["sn","sp"];
_specOp = [];
_officer = ["co","sur","rad"];

// Default uniform - Medium uniform
_glasses = [];
_helmet = ["H_HelmetB","H_HelmetB_plain_mcamo"];
_uniform = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_vest"];
_vest = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"]; 	// default for all infantry classes
_backpack = ["B_AssaultPack_mcamo"];
_outfit = [_glasses,_helmet,_uniform,_vest,_backpack];

// Light Uniform, big backpack
_lightGlasses = _glasses;
_lightHelmet = _helmet;
_lightuniform = _uniform;
_lightVest = ["V_BandollierB_cbr","V_BandollierB_khk"];
_lightBackpack = ["B_Carryall_mcamo"]; //Large backpack
_lightOutfit = [_lightGlasses,_lightHelmet,_lightuniform,_lightVest,_lightBackpack];

// Heavy Uniform, small backpack
_heavyGlasses = [];
_heavyHelmet = ["H_HelmetSpecB_blk"];
_heavyUniform = ["U_B_CombatUniform_mcam_vest"];
_heavyVest = ["V_PlateCarrier3_rgr"];
_heavyBackpack = ["B_AssaultPack_mcamo"]; //Small backpack to avoid overencumberance
_heavyOutfit = [_heavyGlasses,_heavyHelmet,_heavyUniform,_heavyVest,_heavyBackpack];

// Pilot
_pilotGlasses = [];
_pilotHelmet = ["H_PilotHelmetHeli_B"];
_pilotUniform = ["U_B_HeliPilotCoveralls"];
_pilotVest = ["V_TacVest_blk"];
_pilotBackpack = ["B_AssaultPack_mcamo"];
_pilotOutfit = [_pilotGlasses,_pilotHelmet,_pilotUniform,_pilotVest,_pilotBackpack];

// Crewman
_crewGlasses = [];
_crewHelmet = ["H_HelmetCrew_B"];
_crewUniform = ["U_B_CombatUniform_mcam_vest"];
_crewVest = ["V_TacVest_blk"];
_crewBackpack = _backpack;
_crewOutfit = [_crewGlasses,_crewHelmet,_crewUniform,_crewVest,_crewBackpack];

// Ghillie
_ghillieGlasses = [];
_ghillieHelmet = [];
_ghillieUniform = ["U_B_GhillieSuit"]; //DLC alternatives: ["U_B_FullGhillie_lsh","U_B_FullGhillie_ard","U_B_FullGhillie_sard"];
_ghillieVest = ["V_Chestrig_rgr"];
_ghillieBackpack = _backpack;
_ghillieOutfit = [_ghillieGlasses,_ghillieHelmet,_ghillieUniform,_ghillieVest,_ghillieBackpack];

// Special Operations
_sfGlasses = [];
_sfhelmet = ["H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk"];
_sfuniform = ["U_B_SpecopsUniform_sgg"];
_sfVest = ["V_PlateCarrierSpec_rgr"];
_sfBackpack = _backpack;
_sfOutfit = [_sfGlasses,_sfhelmet,_sfuniform,_sfVest,_sfBackpack];

// Officer
_officerGlasses = [];
_officerHelmet = ["H_MilCap_mcamo"];
_officeruniform = ["U_B_CombatUniform_mcam"];
_officerVest = ["V_Chestrig_rgr"];
_officerBackpack = ["B_TacticalPack_mcamo"];
_officerOutfit = [_officerGlasses,_officerHelmet,_officeruniform,_officerVest,_officerBackpack];


// ====================================================================================

// INTERPRET PASSED VARIABLES
// The following inrerprets formats what has been passed to this script element

_typeofUnit = toLower (_this select 0);			// Tidy input for SWITCH/CASE statements, expecting something like : r = Rifleman, co = Commanding Officer, rat = Rifleman (AT)
_unit = _this select 1;					// expecting name of unit; originally passed by using 'this' in unit init
_isMan = _unit isKindOf "CAManBase";	// We check if we're dealing with a soldier or a vehicle

// Convert old names into new ones -- Backwards compatibility
/*
switch (_typeofunit) do {
	case "dc": { _typeofunit = "sl"};
	case "m": { _typeofunit = "med"};
	case "surgeon": { _typeofunit = "sur"};
	case "rat": { _typeofunit = "lat"};
	case "mmgg": { _typeofunit = "mmg"};
	case "mmgag": { _typeofunit = "ammg"};
	case "matg": { _typeofunit = "mat"};
	case "matag": { _typeofunit = "amat"};
	case "hmgg": { _typeofunit = "hmg"};
	case "hmgag": { _typeofunit = "ahmg"};
	case "hatg": { _typeofunit = "hat"};
	case "hatag": { _typeofunit = "ahat"};
	case "mtrg": { _typeofunit = "mtr"};
	case "mtrag": { _typeofunit = "amtr"};
	case "msamg": { _typeofunit = "sam"};
	case "msamag": { _typeofunit = "asam"};
	case "hsamg": { _typeofunit = "sam"};
	case "hsamag": { _typeofunit = "asam"};
	case "pp": { _typeofunit = "pil"};
	case "pc": { _typeofunit = "pcc"};
	case "div": { _typeofunit = "rif"};
	case "r": { _typeofunit = "rif"};
	case "engm": { _typeofunit = "dem"};
	case "log": { _typeofunit = "eng"};
	case "fac": { _typeofunit = "rad"};
};
*/
// A quick function to add more than one item for readability
_additems = {params ["_item","_amount","_unit"]; if (_amount > 0) then {for "_i" from 1 to _amount do { _unit additem _item };};};
_addrandomitems = {params ["_itemarray","_amount","_unit"]; if (_amount > 0) then {for "_i" from 1 to _amount do { _unit additem (selectrandom _itemarray) };};};
// ====================================================================================

// This block needs only to be run on an infantry unit
if (_isMan) then {

	// PREPARE UNIT FOR GEAR ADDITION
	// The following code removes all existing weapons, items, magazines and backpacks
	_unit setVariable ["BIS_enableRandomization", false];
	removeUniform _unit;
	removeHeadgear _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeAllWeapons _unit;
	removeAllItemsWithMagazines _unit;
	removeAllAssignedItems _unit;

	// ====================================================================================

	// HANDLE CLOTHES
	// Assign right outfit array

	
		if (_typeofUnit in _light) then {_outfit = _lightOutfit};
		if (_typeofUnit in _heavy) then {_outfit = _heavyOutfit};
		if (_typeofUnit in _pilot) then {_outfit = _pilotOutfit};
		if (_typeofUnit in _crew) then {_outfit = _crewOutfit};
		if (_typeofUnit in _ghillie) then {_outfit = _ghillieOutfit};
		if (_typeofUnit in _specOp) then {_outfit = _sfOutfit};
		if (_typeofUnit in _officer) then {_outfit = _officerOutfit};
	// Add Glasses, Helmet, Uniform, Vest and Backpack
	
	if(count (_outfit select 0) > 0) then {_unit addGoggles (selectrandom (_outfit select 0))};
	if(count (_outfit select 1) > 0) then {_unit addHeadgear (selectrandom (_outfit select 1))};
	if(count (_outfit select 2) > 0) then {_unit forceAddUniform (selectrandom (_outfit select 2))};
	if(count (_outfit select 3) > 0) then {_unit addVest (selectrandom (_outfit select 3))};
	if(count (_outfit select 4) > 0) then {_unit addBackpack (selectrandom (_outfit select 4))};
	

	// ====================================================================================

	// ADD UNIVERSAL ITEMS
	// Add items universal to all units of this faction 
	// Note these items are the first to get added to the unit

	_unit linkItem _nvg;					// Add and equip the faction's nvg
	_unit linkItem "ItemMap";				// Add and equip the map
	_unit linkItem "ItemCompass";			// Add and equip a compass
	_unit linkItem "ItemWatch";				// Add and equip a watch
	//_unit linkItem "ItemGPS"; 			// Add and equip a GPS

	// ADD ACE ITEMS
	_unit addItem "ACE_Flashlight_XL50";	// Add a flashlight for ACE map support.
	_unit addItem "ACE_Maptools";

	// Add medical items
	{_unit addItem "ACE_fieldDressing"} forEach [1,2,3,4]; // Bandages
	{_unit addItem "ACE_elasticBandage"} forEach [1,2]; // Bandages
	{_unit addItem "ACE_quikclot"} forEach [1]; // Bandages
	{_unit addItem "ACE_packingBandage"} forEach [1,2]; // Bandages

	{_unit addItem "ACE_morphine"} forEach [1,2,3,4];
	{_unit addItem "ACE_tourniquet"} forEach [1,2];
	{_unit addItem "ACE_splint"} forEach [1,2];	
	//{_unit addItem "ACE_epinephrine"} forEach [1,2];
	//{_unit addItem "ACE_adenosine"} forEach [1];	
	{_unit addItem "ACE_bloodIV_500"} forEach [1];
	//Add chemlights
	[_chemlights, _chemlightsamount,_unit] call _addrandomitems;
};

// ====================================================================================

// DEFINE UNIT TYPE LOADOUTS
// The following blocks of code define loadouts for each type of unit (the unit type
// is passed to the script in the first variable)

switch (_typeofUnit) do
{

// ====================================================================================

// LOADOUT: COMMANDER
	case "co":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addWeapon _rangefinder;
		_unit linkItem "ItemGPS";
		_unit addItem "ACE_microDAGR";
	};
// LOADOUT: Radio Operator / Forward Air control
	case "rad":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addWeapon _rangefinder;
		_unit linkItem "ItemGPS";
		_unit addItem "ACE_microDAGR";
	};

// LOADOUT: DEPUTY COMMANDER AND SQUAD LEADER
	case "sl":
	{
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addWeapon _rangefinder;
		_unit linkItem "ItemGPS";
		_unit addItem "ACE_microDAGR";
	};

// LOADOUT: MEDIC
	case "med":
	{
		_unit addmagazines [_smokegrenade,(_smokegrenadeamount+2)];
		["ACE_elasticBandage", 25,_unit] call _additems;
		["ACE_morphine", 10,_unit] call _additems;
		["ACE_epinephrine", 10,_unit] call _additems;
		["ACE_adenosine", 5,_unit] call _additems;
		["ACE_bloodIV", 10,_unit] call _additems;
		["ACE_tourniquet", 4,_unit] call _additems;
		["ACE_splint", 4,_unit] call _additems;
		_unit addWeapon _binocular;		
		_unit linkItem "ItemGPS";
		_unit addItem "ACE_microDAGR";
		_unit addItem "FSGm_ItemMedicBagMil"; //Comment out if not using reopening wounds
		_unit addItem "ACE_surgicalKit"; //Comment out if not using reopening wounds
		_unit addItem "ACE_personalAidKit"; //Comment out if not using reopening wounds
	};
// LOADOUT: SURGEON
	case "sur":
	{
		_unit addItem "ACE_surgicalKit"; //Comment out if not using reopening wounds
		_unit addItem "ACE_personalAidKit"; //Comment out if not using reopening wounds
		_unit addItem "FSGm_ItemMedicBagMil"; //Comment out if not using reopening wounds
		_unit addmagazines [_smokegrenade,(_smokegrenadeamount+2)];
		["ACE_elasticBandage", 15,_unit] call _additems; //reopening wounds setup
		["ACE_quikclot", 10,_unit] call _additems;       //reopening wounds setup
		//["ACE_elasticBandage", 25,_unit] call _additems;    //comment this out for reopening wounds setup
		["ACE_morphine", 10,_unit] call _additems;
		["ACE_epinephrine", 10,_unit] call _additems;
		["ACE_adenosine", 5,_unit] call _additems;		
		["ACE_bloodIV", 8,_unit] call _additems;
		["ACE_tourniquet", 4,_unit] call _additems;
		["ACE_splint", 10,_unit] call _additems;	

		_unit addWeapon _binocular;		
		_unit linkItem "ItemGPS";
		_unit addItem "ACE_microDAGR";
	};

// LOADOUT: FIRE TEAM LEADER
	case "ftl":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addWeapon _rangefinder;
		_unit linkItem "ItemGPS";
		_unit addItem "ACE_microDAGR";
	};


// LOADOUT: AUTOMATIC RIFLEMAN
	case "ar":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addmagazines [_ARmag,round(_ARmagamount * (1-_tracermagfraction))];
		_unit addmagazines [_ARmag_tr,round(_ARmagamount * (_tracermagfraction))];
		_unit addweapon (selectrandom _AR);
		removeAllPrimaryWeaponItems _unit;
		{
			// loop trough the attachments and add them to the weapon
			_unit addPrimaryWeaponItem _x;
		} 	foreach _ARattachments;	
	};

// LOADOUT: ASSISTANT AUTOMATIC RIFLEMAN
	case "aar":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addmagazines [_ARmag,ceil((_ARmagamount * (1-_tracermagfraction))*_assistantfraction)];
		_unit addmagazines [_ARmag_tr,ceil((_ARmagamount * _tracermagfraction)*_assistantfraction)];

		_unit addWeapon _binocular;
	};

// LOADOUT: LIGHT ANTI TANK 
	case "lat":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		if(_ratmag != "") then {_unit addmagazines [_ratmag, _RATmagamount]};
		_unit addweapon _RAT;
	};

// LOADOUT: DESIGNATED MARKSMAN
	case "dm":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addmagazines [_DMriflemag,_DMriflemagamount];
		_unit addweapon _DMrifle;
		removeAllPrimaryWeaponItems _unit;
		{
			// loop trough the attachments and add them to the weapon
			_unit addPrimaryWeaponItem _x;
		} 	foreach _DMattachments;			
	};

// LOADOUT: MEDIUM MG GUNNER
	case "mmg":
	{
		_unit addmagazines [_MMGmag,_MMGmagamount];
		_unit addmagazines [_MMGmag,_MMGmagamount];
		_unit addweapon _MMG;
		removeAllPrimaryWeaponItems _unit;
		{
			// loop trough the attachments and add them to the weapon
			_unit addPrimaryWeaponItem _x;
		} 	foreach _MMGattachments;			
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
	};

// LOADOUT: MEDIUM MG ASSISTANT GUNNER
	case "ammg":
	{

		_unit addWeapon _rangefinder;
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];

		_unit addmagazines [_MMGmag,ceil((_ARmagamount * (1-_tracermagfraction))*_assistantfraction)];
		_unit addmagazines [_MMGmag_tr,ceil((_ARmagamount * _tracermagfraction)*_assistantfraction)];
	};

// LOADOUT: HEAVY MG GUNNER
	case "hmg":
	{
		if(_HMG != "") then { _unit addWeapon _HMG};
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		if(_HMGmag != "") then { _unit addmagazines [_HMGmag,_HMGmagamount] };
		if(_baghmg != "") then { removeBackpack _unit; _unit addBackpack _baghmg; };
	};

// LOADOUT: HEAVY MG ASSISTANT GUNNER
	case "ahmg":
	{
		if(_HMGTripod != "") then { _unit addWeapon _HMGTripod};
		_unit addWeapon _rangefinder;
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		if(_HMGmag != "") then { _unit addmagazines [_HMGmag,_HMGmagamount] };
		if(_bagahmg != "") then { removeBackpack _unit; _unit addBackpack _bagahmg; };
	};

// LOADOUT: MEDIUM AT GUNNER
	case "mat":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addmagazines [_MATmag1,_MATmag1amount];
		_unit addmagazines [_MATmag2,_MATmag2amount];
		_unit addweapon _MAT;
	};

// LOADOUT: MEDIUM AT ASSISTANT GUNNER
	case "amat":
	{
		_unit addWeapon _rangefinder;
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addmagazines [_MATmag1,_MATmag1amount];
		_unit addmagazines [_MATmag2,_MATmag2amount];
	};

// LOADOUT: HEAVY AT GUNNER
	case "hat":
	{
		_unit addmagazines [_HATmag1,_HATmag1amount];
		_unit addmagazines [_HATmag2,_HATmag2amount];
		_unit addWeapon _HAT;
	};

// LOADOUT: HEAVY AT ASSISTANT GUNNER
	case "ahat":
	{
		_unit addmagazines [_HATmag1,_HATmag1amount];
		_unit addmagazines [_HATmag2,_HATmag2amount];
		_unit addWeapon _rangefinder;
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
	};

// LOADOUT: MORTAR GUNNER
	case "mtr":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		// Remove the standard backpack to add the static one
		removeBackpack _unit;
		_unit addBackpack _bagmtr;
	};

// LOADOUT: MORTAR ASSISTANT GUNNER
	case "amtr":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addWeapon _rangefinder;
		// Remove the standard backpack to add the static one
		removeBackpack _unit;
		_unit addBackpack _bagamtr;
	};

// LOADOUT: MEDIUM SAM GUNNER
	case "sam":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addmagazines [_SAMmag,_SAMmagamount];
		_unit addweapon _SAM;
	};

// LOADOUT: MEDIUM SAM ASSISTANT GUNNER
	case "asam":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addmagazines [_SAMmag,_SAMmagamount];
		_unit addWeapon _rangefinder;
	};

// LOADOUT: SNIPER
	case "sn":
	{
		_unit addmagazines [_SNrifleMag,_SNrifleMagamount];
		_unit addweapon _SNrifle;
		removeAllPrimaryWeaponItems _unit;
		{
			// loop trough the attachments and add them to the weapon
			_unit addPrimaryWeaponItem _x;
		} 	foreach _SNattachments;			
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addItem "ACE_Kestrel4500";
	};

// LOADOUT: SPOTTER
	case "sp":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit addWeapon _rangefinder;
		_unit linkItem "ItemGPS";
		_unit addItem "ACE_microDAGR";
	};

// LOADOUT: VEHICLE COMMANDER
	case "vc":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit linkItem "ItemGPS";
		_unit addWeapon _rangefinder;
	};

// LOADOUT: VEHICLE GUNNER
	case "vg":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit linkItem "ItemGPS";
	};

// LOADOUT: VEHICLE DRIVER
	case "vd":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit linkItem "ItemGPS";
		(unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
	};

// LOADOUT: AIR VEHICLE PILOTS
	case "pil":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit linkItem "ItemGPS";
	};

// LOADOUT: AIR VEHICLE CREW CHIEF
	case "pcc":
	{
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		(unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
	};


// LOADOUT: ENGINEER
	case "eng":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		{_unit addItem _x} forEach _engineeritems;
		_unit addWeapon _binocular;
		(unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
	};

// LOADOUT: ENGINEER (MINES)
	case "dem":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		{_unit addItem _x} forEach _demoitems;
		_unit addWeapon _binocular;
	};

// LOADOUT: UAV OPERATOR
	case "uav":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
		_unit linkItem _uavterminal;
		// Remove the standard backpack to add the uav bag
		removeBackpack _unit;
		_unit addBackpack _baguav;
	};

// LOADOUT: RIFLEMAN
	case "rif":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
	};

// LOADOUT: CARABINEER
	case "car":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
	};

// LOADOUT: SUBMACHINEGUNNER
	case "smg":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
	};

// LOADOUT: GRENADIER
	case "gren":
	{
		_unit addmagazines [_grenade,_grenadeamount];
		_unit addmagazines [_mgrenade,_Mgrenadeamount];
		_unit addmagazines [_smokegrenade,_smokegrenadeamount];
	};

// CARGO: CAR - room for 10 weapons and 50 cargo items
	case "v_car":
	{
		clearWeaponCargoGlobal _unit;
		clearMagazineCargoGlobal _unit;
		clearItemCargoGlobal _unit;
		clearBackpackCargoGlobal _unit;
		_unit addWeaponCargoGlobal [_carbine, 2];
		_unit addMagazineCargoGlobal [_riflemag, 8];
		_unit addMagazineCargoGlobal [_glriflemag, 8];
		_unit addMagazineCargoGlobal [_carbinemag, 10];
		_unit addMagazineCargoGlobal [_smgmag, 5];
		_unit addMagazineCargoGlobal [_MMGmag, 2];
		if(_HMGmag != "") then { _unit addmagazineCargoGlobal [_HMGmag, 2] };
		_unit addMagazineCargoGlobal [_SNrifleMag, 5];
		_unit addMagazineCargoGlobal [_armag, 5];
		_unit addMagazineCargoGlobal [_DMriflemag, 5];		
		if(_ratmag == "") then { _unit addWeaponCargoGlobal [_rat, 1] } else { _unit addMagazineCargoGlobal [_ratmag, 1] };
		_unit addMagazineCargoGlobal [_grenade, 4];
		_unit addMagazineCargoGlobal [_smokegrenade, 4];
		_unit addMagazineCargoGlobal [_glmag, 4];
		_unit addMagazineCargoGlobal [_glsmokewhite, 4];
		_unit addItemCargoGlobal ["ACE_elasticBandage", 20];
		_unit addItemCargoGlobal ["ACE_morphine", 10];
		_unit addItemCargoGlobal ["ACE_epinephrine", 10];
		_unit addItemCargoGlobal ["ACE_bloodIV", 5];
		_unit addItemCargoGlobal ["ACE_splint", 10];
		_unit addMagazineCargoGlobal [_pistolmag, 2];
		_unit addMagazineCargoGlobal [_glredsmoke, 2];
		_unit addMagazineCargoGlobal [_glbluesmoke, 2];
		_unit addMagazineCargoGlobal [_glgreensmoke, 2];
		_unit addMagazineCargoGlobal [_redsmoke, 2];
		_unit addMagazineCargoGlobal [_bluesmoke, 2];
		_unit addMagazineCargoGlobal [_greensmoke, 2];
	};

// CARGO: TRUCK - room for 50 weapons and 200 cargo items
	case "v_tr":
	{
		clearWeaponCargoGlobal _unit;
		clearMagazineCargoGlobal _unit;
		clearItemCargoGlobal _unit;
		clearBackpackCargoGlobal _unit;
		_unit addWeaponCargoGlobal [_carbine, 2];
		_unit addMagazineCargoGlobal [_riflemag, 40];
		_unit addMagazineCargoGlobal [_glriflemag, 40];
		_unit addMagazineCargoGlobal [_carbinemag, 40];
		_unit addMagazineCargoGlobal [_armag, 22];
		_unit addMagazineCargoGlobal [_DMriflemag, 22];		
		_unit addMagazineCargoGlobal [_smgmag, 10];
		_unit addMagazineCargoGlobal [_MMGmag, 10];
		if(_HMGmag != "") then { _unit addmagazineCargoGlobal [_HMGmag, 5] };
		_unit addMagazineCargoGlobal [_SNrifleMag, 10];
		if(_ratmag == "") then { _unit addWeaponCargoGlobal [_rat, 6] } else { _unit addMagazineCargoGlobal [_ratmag, 6] };
		_unit addMagazineCargoGlobal [_grenade, 12];
		_unit addmagazineCargoGlobal [_mgrenade,12];
		_unit addMagazineCargoGlobal [_smokegrenade, 12];
		_unit addMagazineCargoGlobal [_glmag, 12];
		_unit addMagazineCargoGlobal [_glsmokewhite, 12];
		_unit addItemCargoGlobal ["ACE_elasticBandage", 20];
		_unit addItemCargoGlobal ["ACE_morphine", 10];
		_unit addItemCargoGlobal ["ACE_epinephrine", 10];
		_unit addItemCargoGlobal ["ACE_bloodIV", 5];
		_unit addItemCargoGlobal ["ACE_splint", 10];
		_unit addMagazineCargoGlobal [_pistolmag, 5];
		_unit addMagazineCargoGlobal [_glredsmoke, 5];
		_unit addMagazineCargoGlobal [_glbluesmoke, 5];
		_unit addMagazineCargoGlobal [_glgreensmoke, 5];
		_unit addMagazineCargoGlobal [_glyellowsmoke, 5];
		_unit addMagazineCargoGlobal [_glorangesmoke, 5];
		_unit addMagazineCargoGlobal [_glpurplesmoke, 5];
		_unit addMagazineCargoGlobal [_redsmoke, 5];
		_unit addMagazineCargoGlobal [_bluesmoke, 5];
		_unit addMagazineCargoGlobal [_greensmoke, 5];
		_unit addMagazineCargoGlobal [_yellowsmoke, 5];
		_unit addMagazineCargoGlobal [_orangesmoke, 5];
		_unit addMagazineCargoGlobal [_purplesmoke, 5];
			
	};

// CARGO: IFV - room for 10 weapons and 100 cargo items
	case "v_ifv":
	{
		clearWeaponCargoGlobal _unit;
		clearMagazineCargoGlobal _unit;
		clearItemCargoGlobal _unit;
		clearBackpackCargoGlobal _unit;
		_unit addWeaponCargoGlobal [_carbine, 4];
		_unit addMagazineCargoGlobal [_riflemag, 20];
		_unit addMagazineCargoGlobal [_glriflemag, 20];
		_unit addMagazineCargoGlobal [_carbinemag, 20];
		_unit addMagazineCargoGlobal [_armag, 8];
		_unit addMagazineCargoGlobal [_DMriflemag, 8];		
		_unit addMagazineCargoGlobal [_smgmag, 5];
		_unit addMagazineCargoGlobal [_MMGmag, 2];
		if(_HMGmag != "") then { _unit addmagazineCargoGlobal [_HMGmag, 2] };
		_unit addMagazineCargoGlobal [_SNrifleMag, 5];
		if(_ratmag == "") then { _unit addWeaponCargoGlobal [_rat, 2] } else { _unit addMagazineCargoGlobal [_ratmag, 2] };
		_unit addMagazineCargoGlobal [_grenade, 8];
		_unit addmagazineCargoGlobal [_mgrenade,8];
		_unit addMagazineCargoGlobal [_smokegrenade, 8];
		_unit addMagazineCargoGlobal [_glmag, 8];
		_unit addMagazineCargoGlobal [_glsmokewhite, 4];
		_unit addItemCargoGlobal ["ACE_elasticBandage", 20];
		_unit addItemCargoGlobal ["ACE_morphine", 10];
		_unit addItemCargoGlobal ["ACE_epinephrine", 10];
		_unit addItemCargoGlobal ["ACE_bloodIV", 5];
		_unit addItemCargoGlobal ["ACE_splint", 10];
		_unit addMagazineCargoGlobal [_pistolmag, 3];
		_unit addMagazineCargoGlobal [_glredsmoke, 3];
		_unit addMagazineCargoGlobal [_glbluesmoke, 3];
		_unit addMagazineCargoGlobal [_glgreensmoke, 3];
		_unit addMagazineCargoGlobal [_glyellowsmoke, 3];
		_unit addMagazineCargoGlobal [_glorangesmoke, 3];
		_unit addMagazineCargoGlobal [_glpurplesmoke, 3];
		_unit addMagazineCargoGlobal [_redsmoke, 3];
		_unit addMagazineCargoGlobal [_bluesmoke, 3];
		_unit addMagazineCargoGlobal [_greensmoke, 3];
		_unit addMagazineCargoGlobal [_yellowsmoke, 3];
		_unit addMagazineCargoGlobal [_orangesmoke, 3];
		_unit addMagazineCargoGlobal [_purplesmoke, 3];
			
	};

// CRATE: Small, ammo for 1 fireteam
	case "crate_small":
{
		clearWeaponCargoGlobal _unit;
		clearMagazineCargoGlobal _unit;
		clearItemCargoGlobal _unit;
		clearBackpackCargoGlobal _unit;
		_unit addMagazineCargoGlobal [_riflemag, 5];
		_unit addMagazineCargoGlobal [_glriflemag, 5];
		_unit addMagazineCargoGlobal [_armag, 5];
		_unit addMagazineCargoGlobal [_DMriflemag, 5];		
		_unit addMagazineCargoGlobal [_carbinemag, 5];
		_unit addMagazineCargoGlobal [_glmag, 5];
		_unit addMagazineCargoGlobal [_glsmokewhite, 4];
		_unit addMagazineCargoGlobal [_smgmag, 5];
		_unit addMagazineCargoGlobal [_MMGmag, 2];
		_unit addMagazineCargoGlobal [_SNrifleMag, 5];
		if(_ratmag == "") then { _unit addWeaponCargoGlobal [_rat, 2] } else { _unit addMagazineCargoGlobal [_ratmag, 2] };
		_unit addMagazineCargoGlobal [_grenade, 8];
		_unit addMagazineCargoGlobal [_mgrenade, 8];
		_unit addMagazineCargoGlobal [_smokegrenade, 8];
		_unit addItemCargoGlobal ["ACE_elasticBandage", 20];
		_unit addItemCargoGlobal ["ACE_morphine", 10];
		_unit addItemCargoGlobal ["ACE_epinephrine", 10];
		_unit addItemCargoGlobal ["ACE_bloodIV", 5];
		_unit addItemCargoGlobal ["ACE_splint", 10];
		_unit addMagazineCargoGlobal [_pistolmag, 2];
		_unit addMagazineCargoGlobal [_glredsmoke, 2];
		_unit addMagazineCargoGlobal [_glbluesmoke, 2];
		_unit addMagazineCargoGlobal [_glgreensmoke, 2];
		_unit addMagazineCargoGlobal [_redsmoke, 2];
		_unit addMagazineCargoGlobal [_bluesmoke, 2];
		_unit addMagazineCargoGlobal [_greensmoke, 2];
			
};

// CRATE: Medium, ammo for 1 squad
	case "crate_med":
{
		clearWeaponCargoGlobal _unit;
		clearMagazineCargoGlobal _unit;
		clearItemCargoGlobal _unit;
		clearBackpackCargoGlobal _unit;
		_unit addMagazineCargoGlobal [_riflemag, 15];
		_unit addMagazineCargoGlobal [_glriflemag, 20];
		_unit addMagazineCargoGlobal [_armag, 15];
		_unit addMagazineCargoGlobal [_DMriflemag, 15];		
		_unit addMagazineCargoGlobal [_carbinemag, 20];
		_unit addMagazineCargoGlobal [_glmag, 20];
		_unit addMagazineCargoGlobal [_glsmokewhite,16];
		_unit addMagazineCargoGlobal [_smgmag, 10];
		_unit addMagazineCargoGlobal [_MMGmag, 10];
		if(_HMGmag != "") then { _unit addmagazineCargoGlobal [_HMGmag, 5] };
		_unit addMagazineCargoGlobal [_SNrifleMag, 10];
		if(_ratmag == "") then { _unit addWeaponCargoGlobal [_rat, 6] } else { _unit addMagazineCargoGlobal [_ratmag, 6] };
		_unit addMagazineCargoGlobal [_grenade, 25];
		_unit addMagazineCargoGlobal [_mgrenade, 25];
		_unit addMagazineCargoGlobal [_smokegrenade, 25];
		_unit addItemCargoGlobal ["ACE_elasticBandage", 100];
		_unit addItemCargoGlobal ["ACE_morphine", 50];
		_unit addItemCargoGlobal ["ACE_epinephrine", 25];
		_unit addItemCargoGlobal ["ACE_bloodIV", 10];
		_unit addItemCargoGlobal ["ACE_splint", 20];
		_unit addMagazineCargoGlobal [_pistolmag, 3];
		_unit addMagazineCargoGlobal [_glredsmoke, 3];
		_unit addMagazineCargoGlobal [_glbluesmoke, 3];
		_unit addMagazineCargoGlobal [_glgreensmoke, 3];
		_unit addMagazineCargoGlobal [_glyellowsmoke, 3];
		_unit addMagazineCargoGlobal [_glorangesmoke, 3];
		_unit addMagazineCargoGlobal [_glpurplesmoke, 3];
		_unit addMagazineCargoGlobal [_redsmoke, 3];
		_unit addMagazineCargoGlobal [_bluesmoke, 3];
		_unit addMagazineCargoGlobal [_greensmoke, 3];
		_unit addMagazineCargoGlobal [_yellowsmoke, 3];
		_unit addMagazineCargoGlobal [_orangesmoke, 3];
		_unit addMagazineCargoGlobal [_purplesmoke, 3];
};

// CRATE: Large, ammo for 1 platoon
	case "crate_large":
{
		clearWeaponCargoGlobal _unit;
		clearMagazineCargoGlobal _unit;
		clearItemCargoGlobal _unit;
		clearBackpackCargoGlobal _unit;
		_unit addMagazineCargoGlobal [_riflemag, 45];
		_unit addMagazineCargoGlobal [_glriflemag, 60];
		_unit addMagazineCargoGlobal [_armag, 45];
		_unit addMagazineCargoGlobal [_DMriflemag, 45];		
		_unit addMagazineCargoGlobal [_carbinemag, 60];
		_unit addMagazineCargoGlobal [_smgmag, 20];
		_unit addMagazineCargoGlobal [_MMGmag, 15];
		if(_HMGmag != "") then { _unit addmagazineCargoGlobal [_HMGmag, 10] };
		_unit addMagazineCargoGlobal [_SNrifleMag, 20];
		_unit addMagazineCargoGlobal [_glmag, 60];
		_unit addMagazineCargoGlobal [_glsmokewhite,50];
		if(_ratmag == "") then { _unit addWeaponCargoGlobal [_rat, 20] } else { _unit addMagazineCargoGlobal [_ratmag, 20] };
		_unit addMagazineCargoGlobal [_grenade, 75];
		_unit addMagazineCargoGlobal [_pistolmag, 5];
		_unit addMagazineCargoGlobal [_glredsmoke, 5];
		_unit addMagazineCargoGlobal [_glbluesmoke, 5];
		_unit addMagazineCargoGlobal [_glgreensmoke, 5];
		_unit addMagazineCargoGlobal [_glyellowsmoke, 5];
		_unit addMagazineCargoGlobal [_glorangesmoke, 5];
		_unit addMagazineCargoGlobal [_glpurplesmoke, 5];
		_unit addMagazineCargoGlobal [_redsmoke, 5];
		_unit addMagazineCargoGlobal [_bluesmoke, 5];
		_unit addMagazineCargoGlobal [_greensmoke, 5];
		_unit addMagazineCargoGlobal [_yellowsmoke, 5];
		_unit addMagazineCargoGlobal [_orangesmoke, 5];
		_unit addMagazineCargoGlobal [_purplesmoke, 5];
		_unit addItemCargoGlobal ["ACE_elasticBandage", 150];
		_unit addItemCargoGlobal ["ACE_morphine", 75];
		_unit addItemCargoGlobal ["ACE_epinephrine", 50];
		_unit addItemCargoGlobal ["ACE_bloodIV", 25];
		_unit addItemCargoGlobal ["ACE_splint", 50];			
};

// LOADOUT: DEFAULT/UNDEFINED (use RIFLEMAN)
   default
   {
		_unit addweapon (selectrandom _rifle);
		_unit addmagazines [_riflemag,round(_riflemagamount * (1-_tracermagfraction))];
		{
			// loop trough the attachments and add them to the weapon
			_unit addPrimaryWeaponItem _x;
		} foreach _rifleattachments;

		_unit selectweapon primaryweapon _unit;

		if (true) exitwith {player globalchat format ["DEBUG (f\assignGear\f_assignGear_nato.sqf): Unit = %1. Gear template %2 does not exist, used Rifleman instead.",_unit,_typeofunit]};
   };


// ====================================================================================

// END SWITCH FOR DEFINE UNIT TYPE LOADOUTS
};

// ====================================================================================
//Create spawnable function to enable the right colors to be given
_coloredsmoke = {
	params ["_unit","_typeofunit","_glrifleclasses","_smokegrenadecoloredamount","_glsmokecoloredamount"];
	_group = (group _unit);
	waitUntil { _group getVariable ["ca_groupcolor","nocolor"] != "nocolor"; time > 30;};
	_color = _group getVariable ["ca_groupcolor","nocolor"];
	switch _color do {
		case "ColorYellow": { _unit addmagazines ["SmokeShellYellow",_smokegrenadecoloredamount]; 
		if (_typeofunit in _glrifleclasses) then {_unit addmagazines ["1Rnd_SmokeYellow_Grenade_shell",_glsmokecoloredamount] };};
		case "ColorRed": { _unit addmagazines ["SmokeShellRed",_smokegrenadecoloredamount]; 
		if (_typeofunit in _glrifleclasses) then {_unit addmagazines ["1Rnd_SmokeRed_Grenade_shell",_glsmokecoloredamount] }; };
		case "ColorBlue": {  _unit addmagazines ["SmokeShellBlue",_smokegrenadecoloredamount]; 
		if (_typeofunit in _glrifleclasses) then {_unit addmagazines ["1Rnd_SmokeBlue_Grenade_shell",_glsmokecoloredamount] };};
		case "ColorGreen": {  _unit addmagazines ["SmokeShellGreen",_smokegrenadecoloredamount]; 
		if (_typeofunit in _glrifleclasses) then {_unit addmagazines ["1Rnd_SmokeGreen_Grenade_shell",_glsmokecoloredamount] };};
		case "ColorOrange": {  _unit addmagazines ["SmokeShellOrange",_smokegrenadecoloredamount]; 
		if (_typeofunit in _glrifleclasses) then {_unit addmagazines ["1Rnd_SmokeOrange_Grenade_shell",_glsmokecoloredamount] };};
		default {  _unit addmagazines ["SmokeShellPurple",_smokegrenadecoloredamount]; 
		if (_typeofunit in _glrifleclasses) then {_unit addmagazines ["1Rnd_SmokePurple_Grenade_shell",_glsmokecoloredamount] };};
	};
};


// If this isn't run on an infantry unit we can exit
if !(_isMan) exitWith {};

if (_typeofunit in _coloredsmokeclasses) then {
	if (_redsmoke in _coloredsmokes) then {
		_unit addmagazines [_redsmoke,_smokegrenadecoloredamount];
		if (_typeofunit in _glrifleclasses) then {
			_unit addmagazines [_glredsmoke,_glsmokecoloredamount];
		};
	};
	if (_bluesmoke in _coloredsmokes) then {
		_unit addmagazines [_bluesmoke,_smokegrenadecoloredamount];
		if (_typeofunit in _glrifleclasses) then {
			_unit addmagazines [_glbluesmoke,_glsmokecoloredamount];
		};
	};
	if (_greensmoke in _coloredsmokes) then {
		_unit addmagazines [_greensmoke,_smokegrenadecoloredamount];
		if (_typeofunit in _glrifleclasses) then {
			_unit addmagazines [_glgreensmoke,_glsmokecoloredamount];
		};
	};
	if (_yellowsmoke in _coloredsmokes) then {
		_unit addmagazines [_yellowsmoke,_smokegrenadecoloredamount];
		if (_typeofunit in _glrifleclasses) then {
			_unit addmagazines [_glyellowsmoke,_glsmokecoloredamount];
		};
	};
	if (_orangesmoke in _coloredsmokes) then {
		_unit addmagazines [_orangesmoke,_smokegrenadecoloredamount];
		if (_typeofunit in _glrifleclasses) then {
			_unit addmagazines [_glorangesmoke,_glsmokecoloredamount];
		};
	};
	if (_purplesmoke in _coloredsmokes) then {
		_unit addmagazines [_purplesmoke,_smokegrenadecoloredamount];
		if (_typeofunit in _glrifleclasses) then {
			_unit addmagazines [_glpurplesmoke,_glsmokecoloredamount];
		};
	};
};

// Add weapons & attachments according to class
if (_typeofunit in _rifleclasses) then {
	_unit addmagazines [_riflemag_tr,round(_riflemagamount * (_tracermagfraction))];
	_unit addweapon (selectrandom _rifle);
	_unit addmagazines [_riflemag,round(_riflemagamount * (1-_tracermagfraction))];
	{
		// loop trough the attachments and add them to the weapon
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleattachments;
};
if (_typeofunit in _carbineclasses) then {
	_unit addmagazines [_carbinemag_tr,round(_carbinemagamount * (_tracermagfraction))];
	_unit addweapon (selectrandom _carbine);
	_unit addmagazines [_carbinemag,round(_carbinemagamount * (1-_tracermagfraction))];
	{
		// loop trough the attachments and add them to the weapon
		_unit addPrimaryWeaponItem _x;
	} foreach _carbineattachments;	
};
if (_typeofunit in _smgclasses) then {
	_unit addmagazines [_smgmag_tr,round(_smgmagamount * (_tracermagfraction))];
	_unit addweapon (selectrandom _smg);
	_unit addmagazines [_smgmag,round(_smgmagamount * (1-_tracermagfraction))];
	{
		// loop trough the attachments and add them to the weapon
		_unit addPrimaryWeaponItem _x;
	} foreach _smgattachments;	
};
if (_typeofunit in _glrifleclasses) then {
	_unit addmagazines [_glriflemag_tr,round(_glriflemagamount * (_tracermagfraction))];
	_unit addmagazines [_glsmokewhite,_glsmokewhiteamount];
	_unit addmagazines [_glsmokewhite,_glsmokewhiteamount];
	_unit addmagazines [_glmag,_glmagamount];
	if (_glflareamount > 0) then {for "_i" from 1 to _glflareamount do { _unit addmagazine (selectrandom _glflare); };};

	_unit addweapon (selectrandom _glrifle);
	_unit addmagazines [_glriflemag,round(_glriflemagamount * (1-_tracermagfraction))];
	{
		// loop trough the attachments and add them to the weapon
		_unit addPrimaryWeaponItem _x;
	} foreach _glrifleattachments;	

};
if (_typeofunit in _pistolclasses) then {
	_unit addmagazines [_pistolmag,_pistolmagamount];
	_unit addweapon (selectrandom _pistol);
};
if (_typeofunit in _entrenchingclasses) then {
	_unit additem _entrenchingtool;
};
// ====================================================================================

// Handle handgun attachments
if (typeName _hg_attachments == typeName []) then {
	removeAllHandgunItems _unit;
	{
		// loop trough the attachments and add them to the weapon
		_unit addHandgunItem _x;
	} foreach _hg_attachments;
};
// ====================================================================================

// ENSURE UNIT HAS CORRECT WEAPON SELECTED ON SPAWNING

_unit selectweapon primaryweapon _unit;
