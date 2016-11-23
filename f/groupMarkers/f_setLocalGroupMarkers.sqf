// F3 - Folk Group Markers
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_unitside"];

// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================

// DETECT PLAYER FACTION
// The following code detects what faction the player's slot belongs to, and stores
// it in the private variable _unitside
if(count _this == 0) then
{
	_unitside = side player;

	// If the unitfaction is different from the 	group leader's faction, the latters faction is used
	if (_unitside != side (leader group player)) then {_unitside = side (leader group player)};
}
else
{
	_unitside = (_this select 0);
};

// ====================================================================================

// CONFIGURE MARKER TYPES
// Using the marker classes (https://community.bistudio.com/wiki/cfgMarkers) we setup a number of variables to define which type of marker should be used for which group
// Note: They can be overriden for each group individually

// Groups
_hq = "b_hq";			// Command elements
_ft = "b_inf";			// Fireteams
_sup = "b_support";		// Support units (MMG,HMG)
_lau = "b_motor_inf";	// Launchers (MAT, HAT)
_mor = "b_mortar";		// Mortars
_eng = "b_maint";		// Engineers
_ifv = "b_mech_inf";	// IFVs & APCs
_tnk = "b_armor";		// Tanks
_rec = "b_recon";		// Recon (ST)
_hel = "b_air";			// Helicopters
_pla = "b_plane";		// Planes
_art = "b_art";			// Artillery

// Specialists
_med = "b_med";			// Medic
_uav = "b_uav";			// UAV

// ====================================================================================

// INCLUDE GROUP MARKER SCRIPTS
// Due to the amount of markers the script is split into various sub-scripts (by side)
// which are now included to create the complete script

// MARKERS: BLUFOR
// Markers seen by players in BLUFOR slots
if (_unitside == west) then {
#include "f_setLocalGroupMarkers_Blufor.sqf"
};
// ====================================================================================

// MARKERS: OPFOR
// Markers seen by players in OPFOR slots
if (_unitside == east) then {

#include "f_setLocalGroupMarkers_Opfor.sqf"
};
// ====================================================================================

// MARKERS: INDFOR
// Markers seen by players in INDEPENDENT slots
if (_unitside == independent) then {

#include "f_setLocalGroupMarkers_Indfor.sqf"
};
// ====================================================================================

// MARKERS: ALL
// Markers spawned here can be seen by all units

// ====================================================================================
// sleep for 10 seconds so f\briefing\f_orbatNotes.sqf can get generated correctly
uiSleep 10;
