// F3_CA - ACRE2 Settings - Run on every client 
// ====================================================================================
ca_radioSetup = false;
// RADIO STRUCTURE

// Whether any radios should be assigned at all, to any units
// TRUE = Disable radios for all units
f_radios_settings_acre2_disableRadios = FALSE;

// Whether or not the radio frequencies should be left as default, and not split per side
// TRUE = Disable frequency seperation across sides
f_radios_settings_acre2_disableFrequencySplit = FALSE;

// Set a list of units that get a short wave
// if its nil, that means all units get a radio
// empty array means that none gets
f_radios_settings_acre2_shortRange = nil;

// Should only leaders get 148s based on rank?
// Only applies to f_radios_settings_acre2_extraRadios setting.
// Non leaders will still get a long range if they have the right assigngear class for f_radios_settings_acre2_longRange and  f_radios_settings_acre2_BackpackRadios.
f_radios_settings_acre2_leaderLongRange = true;
/*
Ranks you want to give the full set of LR channels with the AN-PRC148 long-range radio. 
0 - Private
1 - Corporal
2 - Sergeant
3 - Lieutenant
4 - Captain
5 - Major
6 - Colonel
*/
f_radios_settings_acre2_extraRadios = [1,2,3,4,5,6];

// Set the list of unit types that get one AN-PRC152 long range radio for their primary radio.
f_radios_settings_acre2_longRange = ["med","co","sl","rad","sp","vc","pil"];

// Unit types you want to give a backpack radio - Note this is loadout specific
// I'd recommend this is only used for Pilots and FAC (you'll need to sort out a separate FAC loadout in your gearscript, I'd recommend using the "UAV" unit type defined below.)
// This backpack radio still uses the Long Range radio channel definitions below.
f_radios_settings_acre2_BackpackRadios = ["rad","pil"];

// Standard Short
f_radios_settings_acre2_standardSHRadio = "ACRE_PRC343";
// Standard LongRange
f_radios_settings_acre2_standardLRRadio = "ACRE_PRC152";
// Extra LR radio - Extra here is old nomenclature, it just means the 148 as opposed to 152.
f_radios_settings_acre2_extraRadio = "ACRE_PRC148";
// Backpack Radio
f_radios_settings_acre2_BackpackRadio = "ACRE_PRC117F";

// ====================================================================================
// BABEL API

// Defines the languages that exist in the mission.
// string id, displayname
f_radios_settings_acre2_languages = [["english","English"],["farsi","Farsi"],["greek","Greek"]];

// defines the language that a player can speak.
// can define multiple
f_radios_settings_acre2_language_blufor = ["english"];
f_radios_settings_acre2_language_opfor = ["farsi"];
f_radios_settings_acre2_language_indfor = ["greek"];


ca_radioSetup = true;