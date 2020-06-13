
// CA - Mission briefing
execVM "ca\briefing\ca_briefing_player.sqf";
if (serverCommandAvailable "#kick") then {
  execVM "ca\briefing\ca_briefing_admin.sqf";
};

// PabstMirror - Mission Intro
// Credits: PabstMirror
[] execVM "ca\misc\CA_missionIntro.sqf";
[] execVM "ca\misc\HierarchyRadioMarkers.sqf"; 


//Setup specialistmarkers
sleep 2;
waitUntil {!isnil {ca_platoonsetup}}; 

_side = side player;

switch (_side) do {
	case west: {

_allSideplayers = [];
{
	if (side _x == west) then {_allSideplayers pushBackUnique _x};
} forEach allunits;
{
	_typeOfUnit = _x getVariable ["f_var_assignGear", "NIL"];
	if (_typeOfUnit in ca_specialistMarkerClasses) then {
		_x setVariable ["ca_specialistmarker",true];
		[_x] spawn ca_fnc_SpecialistMarker;
	};
	
} forEach _allSideplayers;
	 };
	case east: {
_allSideplayers = [];
{
	if (side _x == east) then {_allSideplayers pushBackUnique  _x};
} forEach allunits;
{
	_typeOfUnit = _x getVariable ["f_var_assignGear", "NIL"];
	if (_typeOfUnit in ca_specialistMarkerClasses) then {
		_x setVariable ["ca_specialistmarker",true];
		[_x] spawn ca_fnc_SpecialistMarker;
	};
	
} forEach _allSideplayers;

	 };
	case independent: { 
_allSideplayers = [];
{
	if (side _x == independent) then {_allSideplayers pushBackUnique  _x};
} forEach allunits;
{
	_typeOfUnit = _x getVariable ["f_var_assignGear", "NIL"];
	if (_typeOfUnit in ca_specialistMarkerClasses) then {
		_x setVariable ["ca_specialistmarker",true];
		[_x] spawn ca_fnc_SpecialistMarker;
	};
	
} forEach _allSideplayers;

	};
	default { };
};

