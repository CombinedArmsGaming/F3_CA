// CA Hierarchy setup 
// Author: Poulern (@me for issues)
// Server execution only and run once at the start of mission

//Total tickets (Where one ticket = 1 respawn, default 5 for vehicles) per team in addition to the squad tickets;
_caWestTickets = 50;

ca_WestSquadStartingTickets = 10; // Default if not set in the array below 

_caWestHierarchy = [
	["CO", 16,[4,5,6]],
	[
		[
			["ASL", 1,[4,1]],
			[
				["A1", 2,[1]],
				["A2", 3,[1]],
				["AV", 4,[5,1]]
			]
		],
		[
			["BSL", 5,[4,2]],
			[
				["B1",  6,[2]],
				["B2",  7,[2]],
				["BV",  8,[5,2]]
			]
		],
		[
			["CSL", 9,[4,3]],
			[
				["C1",  10,[3]],
				["C2",  11,[3]],
				["CV",  12,[5,3]]
			]
		],
		[
			["MMG", 13,[4,8],7],
			[
				["MAT", 14,[8]]
			]
		],
		[
			["ENG", 15,[5],5],
			[]
		]
	]
];
_caEastHierarchy = _caWestHierarchy;
_caIndependentHierarchy = _caWestHierarchy;

_caEastTickets = _caWestTickets;
_caIndependentTickets = _caWestTickets;

ca_EastSquadStartingTickets = ca_WestSquadStartingTickets;
ca_IndependentSquadStartingTickets = ca_WestSquadStartingTickets;


// Radio channels setup
// ====================================================================================

// Long range channel names for 148, 152, 117, Vehicle radios. This correlates to "ALPHA SQUAD" = Channel 1 in the platoon hierarchy array above. 
_caWestLongrangeChannelList = ["ALPHA SQUAD","BRAVO SQUAD","CHARLIE SQUAD","INFANTRY COMMAND","VEHICLE COMMAND","FORWARD AIR CONTROL","AIR COMMAND","WEAPONS SQUAD"];
_caEastLongrangeChannelList = _caWestLongrangeChannelList;
_caIndependentLongrangeChannelList = _caWestLongrangeChannelList;
/* Default setup on 343 for the hierarchy above:
CH1:ASL CH2:A1 CH3:A2 CH4:AV CH5:BSL CH6:B1 CH7:B2 CH8:BV CH9:CSL CH10:C1 CH11:C2 CH12:CV CH13:MMG CH14:MAT CH15:ENG CH16:CO
*/

// ====================================================================================
/* Ranks for various actions like respawning, 
0 - Private
1 - Corporal - Default for Fireteam lead
2 - Sergeant - Default for Squad lead
3 - Lieutenant - Default for Commanding Officer
4 - Captain 
5 - Major
6 - Colonel
*/
_CORANK = 3;
_SLRANK = 2;
_FTLRANK = 1;

// Respawn settings
// ====================================================================================

// How far away an enemy must be to the respawner for respawn to be available
ca_enemyradius = 300;
// How close you must be to your squad lead or CO to be able to respawn or recieve more tickets
ca_ticketradius = 50;

// END OF SETUP
// Executing setup as described above
// ====================================================================================
// ====================================================================================
sleep 2;

missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_blufor',_caWestLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_opfor',_caEastLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_indfor',_caIndependentLongrangeChannelList, true]; 

ca_allWestPlayerGroups = [];
ca_allEastPlayerGroups = [];
ca_allIndependentPlayerGroups = [];

{
	if (side _x == west) then {ca_allWestPlayerGroups pushBackUnique group _x};
	if (side _x == east) then {ca_allEastPlayerGroups pushBackUnique group _x};
	if (side _x == independent) then {ca_allIndependentPlayerGroups pushBackUnique group _x};
} forEach allunits;


ca_allWestSquads = [];
ca_allEastSquads = [];
ca_allIndependentSquads = [];


ca_WestJIPgroups = [];
ca_EastJIPgroups = [];
ca_IndependentJIPgroups = [];
sleep 5;

[_caWestHierarchy,west] spawn ca_fnc_setupArray;
[_caEastHierarchy,east] spawn ca_fnc_setupArray;
[_caIndependentHierarchy,independent] spawn ca_fnc_setupArray;


sleep 10;
missionNamespace setVariable ['ca_WestJIPgroups',ca_WestJIPgroups, true]; 
missionNamespace setVariable ['ca_EastJIPgroups',ca_EastJIPgroups, true]; 
missionNamespace setVariable ['ca_IndependentJIPgroups',ca_IndependentJIPgroups, true]; 

missionNamespace setVariable ['ca_corank',_CORANK, true]; 
missionNamespace setVariable ['ca_slrank',_SLRANK, true]; 
missionNamespace setVariable ['ca_ftlrank',_FTLRANK, true]; 

missionNamespace setVariable ['ca_WestTickets',_caWestTickets, true]; 
missionNamespace setVariable ['ca_EastTickets',_caEastTickets, true]; 
missionNamespace setVariable ['ca_IndependentTickets',_caIndependentTickets, true]; 

missionNamespace setVariable ['ca_WestSquadStartingTickets',ca_WestSquadStartingTickets, true]; 
missionNamespace setVariable ['ca_EastSquadStartingTickets',ca_EastSquadStartingTickets, true]; 
missionNamespace setVariable ['ca_IndependentSquadStartingTickets',ca_IndependentSquadStartingTickets, true]; 

missionNamespace setVariable ['ca_allWestSquads',ca_allWestSquads, true]; 
missionNamespace setVariable ['ca_allEastSquads',ca_allEastSquads, true]; 
missionNamespace setVariable ['ca_allIndependentSquads',ca_allIndependentSquads, true]; 

missionNamespace setVariable ['ca_enemyradius',ca_enemyradius, true]; 
missionNamespace setVariable ['ca_ticketradius',ca_ticketradius, true]; 


sleep 2;
missionNamespace setVariable ['ca_platoonsetup',true, true]; 

