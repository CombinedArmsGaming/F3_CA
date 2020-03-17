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

// Should only leaders get 148s based on class?
// Only applies to f_radios_settings_acre2_extraRadios setting.
// Non leaders will still get a long range if they have the right assigngear class for f_radios_settings_acre2_longRange and  f_radios_settings_acre2_BackpackRadios.
f_radios_settings_acre2_leaderLongRange = true;
/*
Ranks you want to give a AN-PRC148 long-range radio / a long range at all. Privates Doesn't recieve a radio at all with the default setting.
0 - Private
1 - Corporal
2 - Sergeant
3 - Lieutenant
4 - Captain
5 - Major
6 - Colonel
*/
f_radios_settings_acre2_extraRadios = [1];

// Set the list of unit types that get a AN-PRC152 long range radio for their primary radio.
f_radios_settings_acre2_longRange = ["m","co","dc","uav","sp","vc","pp"];

// Unit types you want to give a backpack radio - Note this is loadout specific
// I'd recommend this is only used for Pilots and FAC (you'll need to sort out a separate FAC loadout in your gearscript, I'd recommend using the "UAV" unit type defined below.)
// This backpack radio still uses the Long Range radio channel definitions below.
f_radios_settings_acre2_BackpackRadios = ["uav","pp"];

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

// Channel names and group defaults
// first item in the array will correspond to the first channel
// item definition: ["CHANNEL NAME", ["GROUP1 NAME", "GROUP2 NAME"]]
// note that if using a 343 only the first 16 channels are available for the short-range array
// also note these only work if f_radios_settings_acre2_disableFrequencySplit is set to false

ca_radioSetup = true;