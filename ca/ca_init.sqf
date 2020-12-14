// CA - Player group change 
player setVariable ["ca_originalgroup",(group player),true];


player addMPEventHandler ["MPkilled", {
	params ["_unit"];
	if ((local _unit && isPlayer _unit)) then { 
			_originalgroup = _unit getvariable ["ca_originalgroup","nogroupfoundmpkilled"];
			_group = group _unit;
			(format ["CA MPkilled: UNIT: %1. GROUP: %2. NAME: %3. CA_originalgroup: %4",_unit,(group _unit), name _unit,_originalgroup]) remoteExec ["diag_log"];
			_unit setVariable ["ca_originalgroup",_group,true];
		};
}];
// CA - Mission briefing
execVM "ca\briefing\ca_briefing_player.sqf";
if (serverCommandAvailable "#kick") then {
  execVM "ca\briefing\ca_briefing_admin.sqf";
};

// PabstMirror - Mission Intro
// Credits: PabstMirror
[] execVM "ca\misc\CA_missionIntro.sqf";

// CA - Setup HC/server markers
[] spawn ca_fnc_hcmarker;

// CA - Setup specialistmarkers (Smoothmarkers and normal markers)
ca_selectedgroup = group player;
sleep 2;
waitUntil {!isnil {ca_platoonsetup}}; 
if (f_var_smoothMarkers) exitWith {};
_side = side player;
//Create a switch for each side 
switch (_side) do {
	case west: {
//Get all units in the game 
_allSideplayers = [];
{
	if (side _x == west) then {_allSideplayers pushBackUnique _x};
} forEach allunits;
{
	//Check if they should have a specialistmarker
	_typeOfUnit = _x getVariable ["f_var_assignGear", "NIL"];
	if (_typeOfUnit in ca_specialistMarkerClasses) then {
		_x setVariable ["ca_specialistmarker",true];
		//If you are using smoothmarkers this function will exit shortly after, but smoothmarkers checks if the ca_specialistmarker is set. 
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

