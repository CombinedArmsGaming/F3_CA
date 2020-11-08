// F3 - Folk Unit Markers for Specialists CA special edition
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE PRIVATE VARIABLES

private ["_mkr"];

// ====================================================================================

// SET KEY VARIABLES
// Using variables passed to the script instance, we will create some local variables:

params["_unt",["_mkrType","b_inf"],["_mkrText",""],["_mkrColor","ColorGrey"]];
_untName = name _unt;
private _mkrName = format ["specialistmkr_%1",_untName];
//private _unt = missionNamespace getVariable [_untName, objNull];

// ====================================================================================

// WAIT FOR UNIT TO EXIST IN-MISSION
// We wait for the unit to exist before creating the marker.

if (isNull _unt) then
{
	waitUntil { sleep 3; _unt = missionNamespace getVariable [_untName, objNull]; !(isNull _unt) };
};

// ====================================================================================

// EXIT FOR DEAD UNITS (PART I)
// If the unit is dead, this script exits.

if (!alive _unt) exitWith {};

// ====================================================================================
// Smooth markers support

#include "..\smoothMarkers\macros.hpp"

_smoothMarkersEnabled = IS_TRUE(f_var_smoothMarkers);

_side = [side player] call ca_fnc_sideToString;
_grpId = groupId (group _unt);

// Add info into a dictionary so smooth markers can get what they need to run.
if !(IS_SQUAD_EDITABLE_DYNAMIC(_grpId,_side)) then
{
	MAKE_SQUAD_EDITABLE_DYNAMIC(_grpId,_side);
};

ADD_SPECIAL_MARKER_DYNAMIC(_grpId,_side,_unt);

// ====================================================================================
// If smooth markers are enabled, exit the function here instead of creating a normal marker below.
if (_smoothMarkersEnabled) exitWith {};


// ====================================================================================

// CREATE MARKER
// Depending on the value of _mkrType a different type of marker is created.

_mkr = createMarkerLocal [_mkrName,[(getPos _unt select 0),(getPos _unt select 1)]];
_mkr setMarkerShapeLocal "ICON";
_mkrName setMarkerTypeLocal  _mkrType;
_mkrName setMarkerColorLocal _mkrColor;
_mkrName setMarkerSizeLocal [0.8, 0.8];
_mkrName setMarkerTextLocal _mkrText;

// ====================================================================================

// UPDATE MARKER POSITION
// As long as certain conditions are met (the unit is alive) the marker
// position is updated periodically. This only happens locally - so as not to burden
// the server.


while {_unt getVariable ["ca_specialistmarker",true]} do
{
    _zeusGroups = missionNamespace getVariable ["f_var_hiddenGroups", []];
    _grp = group _unt;
    _newMkrColor = _grp getVariable ["ca_groupcolor","ColorGrey"];
    _mkrName setMarkerColorLocal _newMkrColor;

    _specplayers = [] call ace_spectator_fnc_players;
    _hasmarker = _unt getVariable ["ca_specialistmarker",true];
    if (_unt in _specplayers || isnull _unt || (leader group _unt == _unt)|| !_hasmarker || (_grpId in _zeusGroups)) then {
        _mkrName setMarkerAlphaLocal 0;
        _unt setVariable ["ca_specialistmarker",false];
    } else {
        _mkrName setMarkerAlphaLocal 1;
    };

    _newMkrType = "b_recon";
    _leader = leader _grp;
    _vehicle = objectParent _leader;
    switch (true) do {
        case (_unt getUnitTrait "Engineer"): {_newMkrType = "b_maint";};
        case (_unt getUnitTrait "Medic"): {_newMkrType = "b_med";};        
        case (_vehicle isKindOf "Ship"): { _newMkrType = "b_naval";};
        case (_vehicle isKindOf "Helicopter"): { _newMkrType = "b_air";};
        case (_vehicle isKindOf "Plane"): { _newMkrType = "b_plane"; };
        case (_vehicle isKindOf "StaticWeapon"): { _newMkrType = "b_art"; };
        case (isnull _vehicle): { _newMkrType = "b_recon";};
    };

     
    _unitRole = toUpper (_unt getVariable ["f_var_assignGear", ""]);
    _newmkrText = format ["%1 %2", (groupId _grp), _unitRole];
    _mkrName setMarkerTextLocal _newmkrText;


    _mkrName setMarkerTypeLocal  _newMkrType;
    _mkrName setMarkerPosLocal [(getPos _unt select 0),(getPos  _unt select 1)];
	sleep 2;
};


deleteMarkerLocal _mkrName;
