// CA Hierarchy setup 
// Author: Poulern (@me for issues)
// Server execution only and run once at the start of mission

//Side tickets available (Where one ticket = 1 respawn, default 5 for vehicles) per team in addition to the group tickets;
// Change to for example _caEastTickets = 49 if needed for TvTs/events with multiple sides
_caWestTickets = 50;
_caEastTickets = _caWestTickets;
_caIndependentTickets = _caWestTickets;

//To create a seperate hierarchy for another side, just 
_hierarchywest = {
_side = _this select 0;

/*
Parameters for ca_fnc_setupGroup, which is what the setup below uses to setup each group. 
 * 0: Side (Side): This is set automatically, if you need to set up for multiple sides copy the _hierachy code block and name it _westhierarchy, _easthierachy etc. as needed and change the call below.
 * 1: Superior (String): The groupid of the group that ranks above it in the hierarchy, if equal to groupid, then the group is an independent group or its own platoon.
 * 2:  Groupid (String): The groupid that is set in the editor field callsign.
 * 3: Short range radio channel (Number): What channel the 343 will be on by default and on respawn. 
 * 4: Long range radio Array (Array): Array of channels the long range radios will be on by default and on respawn. There will be one radio given per channel to ranks set in ca_acre2settings.sqf
 * 5: Group color (String): The color of the group in the hierarchy and its groupmarker. Available colors: "ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite"
 * 6: Group tickets (Number): The number of tickets this group gets to play with at the start of the mission. 
 * 7: Group marker (Boolean): Should each team get a group marker assigned to them? Default: True. 
 * 8: Group type (String): What markertype the unit has. This is if you want to use the non-automatic mode that the groupmarker uses. For non smooth markers its any A3 marker, for smooth markers its "b_hq","b_inf","b_support","b_motor_inf","b_mortar","b_maint","b_mech_inf","b_armor","b_recon","b_air","b_plane","b_art"

[_side,"ASL","CO",1,[4,1],"ColorRed",5] spawn ca_fnc_setupGroup;
[_side,"ELEMENT","ELEMENT IMMEDIATELY ABOVE THEM IN THE HIERARCHY",SR radio channel,[LR radio channels],"ColorOfgroup",Number of group tickets 123,Should the group get a map marker true/false,"grouptype aka which marker they get"] spawn ca_fnc_setupGroup;
*/
[_side,"CO","CO",16,[1,3],"ColorYellow",3, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 and LR FAC
// [_side,"COY","COY",16,[1,3],"ColorYellow",3, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 and LR FAC

	[_side,"ENG","CO",51,[1],"ColorGrey",2,true,"b_maint"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"EOD","CO",51,[1],"ColorGrey",2,true,"b_eod"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"MMG","CO",52,[1],"ColorOrange",5, true, "b_heavyweapons"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"MAT","CO",53,[1],"ColorOrange",2, true, "b_antitank"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"LOGI","CO",44,[1],"ColorOrange",2, true, "b_supply"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"HMG","CO",45,[1],"ColorOrange",5, true, "b_heavyweapons"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"HAT","CO",46,[1],"ColorOrange",2, true, "b_heavyantitank"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"GMG","CO",47,[1],"ColorOrange",2, true, "b_heavyweapons"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"MTR","CO",48,[1],"ColorOrange",5, true, "b_mortar"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"REC","CO",49,[1],"ColorOrange",5, true, "b_recon"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1
	[_side,"AAA","CO",50,[1],"ColorOrange",5, true, "b_antiair"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 // For Vehicle AA
	[_side,"SAM","CO",50,[1],"ColorOrange",5, true, "b_antiair"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 // For Manpad AA
	[_side,"SF","CO",50,[1],"ColorBlack",5, true, "b_sf"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1

    // FOR COMPANY HIERARCHY - UNCOMMENT AS REQUIRED. REMEMBER TO COMMENT OUT THE PREVIOUS ENTRY.
    //
    //
	//[_side,"1PL","COY",16,[5,1],"ColorYellow",3, true, "b_hq"] spawn ca_fnc_setupGroup;

		[_side,"ASL","CO",1,[1,4],"ColorRed",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 and LR ALPHA
		//[_side,"ASL","1PL",1,[7,4],"ColorRed",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 1PL and LR ALPHA
			[_side,"A1","ASL",2,[4],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR ALPHA
			[_side,"A2","ASL",3,[4],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR ALPHA
			[_side,"AV","ASL",4,[2,4],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR ALPHA

		[_side,"BSL","CO",5,[1,5],"ColorBlue",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 and LR BRAVO
		//[_side,"BSL","1PL",5,[7,5],"ColorBlue",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 1PL and LR BRAVO
			[_side,"B1","BSL",6,[5],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR BRAVO
			[_side,"B2","BSL",7,[5],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR BRAVO
			[_side,"BV","BSL",8,[2,5],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR BRAVO

		[_side,"CSL","CO",9,[1,6],"ColorGreen",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 and LR CHARLIE
		//[_side,"CSL","1PL",9,[7,6],"ColorGreen",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 1PL and LR CHARLIE
			[_side,"C1","CSL",10,[6],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CHARLIE
			[_side,"C2","CSL",11,[6],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CHARLIE
			[_side,"CV","CSL",12,[2,6],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR CHARLIE

	[_side,"2PL","COY",29,[1,11],"ColorYellow",3, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 and LR 2PL

		[_side,"DSL","2PL",17,[8,11],"ColorRed",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 2PL and LR DELTA
			[_side,"D1","DSL",18,[8],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR DELTA
			[_side,"D2","DSL",19,[8],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR DELTA
			[_side,"DV","DSL",20,[2,8],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR DELTA

		[_side,"ESL","2PL",21,[9,11],"ColorBlue",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 2PL and LR ECHO
			[_side,"E1","ESL",22,[9],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR ECHO
			[_side,"E2","ESL",23,[9],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR ECHO
			[_side,"EV","ESL",24,[2,9],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR ECHO

		[_side,"FSL","2PL",25,[10,11],"ColorGreen",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 2PL and LR FOXTROT
			[_side,"F1","FSL",26,[10],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR FOXTROT
			[_side,"F2","FSL",27,[10],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR FOXTROT
			[_side,"FV","FSL",28,[2,10],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR FOXTROT

	[_side,"3PL","COY",44,[1,15],"ColorYellow",3, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD1 and LR 3PL

		[_side,"GSL","3PL",32,[12,15],"ColorRed",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 3PL and LR GOLF
			[_side,"G1","GSL",33,[12],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR GOLF
			[_side,"G2","GSL",34,[12],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR GOLF
			[_side,"GV","GSL",35,[2,12],"ColorRed",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR GOLF

		[_side,"HSL","3PL",36,[13,15],"ColorBlue",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 3PL and LR HOTEL
			[_side,"H1","HSL",37,[13],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR HOTEL
			[_side,"H2","HSL",38,[13],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR HOTEL
			[_side,"HV","HSL",39,[2,13],"ColorBlue",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR HOTEL

		[_side,"ISL","3PL",40,[14,15],"ColorGreen",5, true, "b_hq"] spawn ca_fnc_setupGroup; // Radio Nets: LR 3PL and LR INDIA
			[_side,"I1","ISL",41,[14],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR INDIA
			[_side,"I2","ISL",42,[14],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR INDIA
			[_side,"IV","ISL",43,[2,14],"ColorGreen",2] spawn ca_fnc_setupGroup; // Radio Nets: LR CMD2 and LR INDIA

};

_hierarchyeast = _hierarchywest;
_hierarchyindependent = _hierarchywest;
//Individual speicalist markers (ie medic markers). Refer to assinggear files for a complete list of f3 loadout classes (eg dc, ftl, eng, sp, pp, vc etc.)
_caSpecialistMarkerClasses = ["m","surgeon","uav"];

// Long radio channels setup
// Long range channel names for 148, 152, 117, Vehicle radios. This correlates to "ALPHA SQUAD" = Channel 1 in the platoon hierarchy array above. 
_caWestLongrangeChannelList = ["COMMAND 1","COMMAND 2","FORWARD AIR","ALPHA","BRAVO","CHARLIE","1ST PLATOON","DELTA","ECHO","FOXTROT","2ND PLATOON","GOLF","HOTEL","INDIA","3RD PLATOON"];
_caEastLongrangeChannelList = _caWestLongrangeChannelList; // Copy and paste to change for another side eg ["COMMAND 1","COMMAND 2","FORWARD AIR","ANNA","BRAVO","CHARITON","1ST PLATOON","DMITRI","ELENA","FEDOR","2ND PLATOON","GREGORY","ZHENYA","IVAN","3RD PLATOON"];
_caIndependentLongrangeChannelList = _caWestLongrangeChannelList;
/* Default setup on 343 (short range) for the hierarchy above:
CH1:ASL CH2:A1 CH3:A2 CH4:AV CH5:BSL CH6:B1 CH7:B2 CH8:BV CH9:CSL CH10:C1 CH11:C2 CH12:CV CH13:MMG CH14:MAT CH15:ENG CH16:CO
*/
// ====================================================================================
/* Ranks for various actions like respawning, adjusting the hierachy. CO rank can change all elements of the hierarchy and call respawn waves.
0 - Private
1 - Corporal - Default for Fireteam lead
2 - Sergeant - Default for Squad lead
3 - Lieutenant - Default for Commanding Officer
4 - Captain 
5 - Major
6 - Colonel
*/
_corank = 3;
_slrank = 2;
_ftlrank = 1;

// Respawn settings
// ====================================================================================
// How far away an enemy must be for respawn to be available
ca_enemyradius = 200;
// Delay for when a group can be respawn after the first player enters spectate. If group respawn is ready and another player dies, the respawn timer goes on cooldown again.
// If the timer is low then its reccomended to increase ca_enemyradius so you're unable to respawn in the middle of combat.
ca_grouprespawncooldown = 180;
// Hardcore option: How close you must be to your squad lead or CO to be able to recieve more tickets (Creating a sort of group based rally point system). 
//If the group is out of tickets then they won't be able to respawn (Except with a respawn wave, if you leave that option open as a mission maker). Defaulted to false.
ca_ticketradius = 50;
ca_ticketradiusmechanic = false; 

// END OF SETUP VARIABLES
// Executing setup as described above
// ====================================================================================
// ====================================================================================
sleep 2;

missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_blufor',_caWestLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_opfor',_caEastLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_indfor',_caIndependentLongrangeChannelList, true]; 

missionNamespace setVariable ['ca_corank',_corank, true]; 
missionNamespace setVariable ['ca_slrank',_slrank, true]; 
missionNamespace setVariable ['ca_ftlrank',_ftlrank, true]; 

missionNamespace setVariable ['ca_specialistMarkerClasses',_caSpecialistMarkerClasses, true]; 

ca_allWestPlayerGroups = [];
ca_allEastPlayerGroups = [];
ca_allIndependentPlayerGroups = [];

{
	if (side _x == west) then {ca_allWestPlayerGroups pushBackUnique group _x};
	if (side _x == east) then {ca_allEastPlayerGroups pushBackUnique group _x};
	if (side _x == independent) then {ca_allIndependentPlayerGroups pushBackUnique group _x};
} forEach allunits;

ca_WestJIPgroups = [];
ca_EastJIPgroups = [];
ca_IndependentJIPgroups = [];
sleep 5;
//Setting up the hierarchyblocks It needs to be executed now to allow all the mission variables to be set first. 
// ====================================================================================

[west] call _hierarchywest;
[east] call _hierarchyeast;
[independent] call _hierarchyindependent;

sleep 10;
missionNamespace setVariable ['ca_WestJIPgroups',ca_WestJIPgroups, true]; 
missionNamespace setVariable ['ca_EastJIPgroups',ca_EastJIPgroups, true]; 
missionNamespace setVariable ['ca_IndependentJIPgroups',ca_IndependentJIPgroups, true]; 

missionNamespace setVariable ['ca_WestTickets',_caWestTickets, true]; 
missionNamespace setVariable ['ca_EastTickets',_caEastTickets, true]; 
missionNamespace setVariable ['ca_IndependentTickets',_caIndependentTickets, true]; 

missionNamespace setVariable ['ca_enemyradius',ca_enemyradius, true]; 
missionNamespace setVariable ['ca_ticketradius',ca_ticketradius, true]; 
missionNamespace setVariable ['ca_grouprespawncooldown',ca_grouprespawncooldown, true]; 

sleep 2;
missionNamespace setVariable ['ca_platoonsetup',true, true]; 
diag_log "Hierarchy setup done, ca_platoonsetup = true";
