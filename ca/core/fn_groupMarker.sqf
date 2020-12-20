/*
 * Author: F3
 * Function: Group marker
 * Create a groupmarker that follows and changes depending on leader vehicle.
 *
 * Arguments:
 * 0: Group
 * 1: Markercolor
 *
 *
 * Example:
 * [group player] spawn ca_fnc_groupMarker;
 *
*/

params["_grp"];

//private _grp = missionNamespace getVariable [_grpName,grpNull];
//private _mkrName = format ["mkr_%1",_grpName];

// ====================================================================================
_mkrName = groupid _grp;
// ====================================================================================

// EXIT FOR EMPTY GROUPS (PART I)
// If the group is empty, this script exits.

if (isnil "_grp") exitWith {};

// ====================================================================================
// Create groupID
// Allows for defining it based on mapmarkers, which is a shorthand identifier anyways.

_newmkrText = groupId _grp;
// ====================================================================================
// CREATE MARKER
// Depending on the value of _mkrType a different type of marker is created.
_mkrType = "b_hq";


// ====================================================================================
// Smooth markers support

#include "..\smoothMarkers\macros.hpp"

_smoothMarkersEnabled = IS_TRUE(f_var_smoothMarkers);

_side = [side player] call ca_fnc_sideToString;
_grpId = groupId _grp;

// Add info into a dictionary so smooth markers can get what they need to run.
MAKE_SQUAD_EDITABLE_DYNAMIC(_grpId,_side);


// ====================================================================================
// If smooth markers are enabled, exit the function here instead of creating a normal marker below.
if (_smoothMarkersEnabled) exitWith {};

_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
_mkr setMarkerShapeLocal "ICON";
_mkrName setMarkerTypeLocal  _mkrType;
_mkrName setMarkerColorLocal (_grp getVariable ["ca_groupcolor","colorBlack"]);
_mkrName setMarkerSizeLocal [0.8, 0.8];
_mkrName setMarkerTextLocal _newmkrText;


// ====================================================================================

// UPDATE MARKER POSITION
// As long as certain conditions are met (the group exists) the marker
// position is updated periodically. This only happens locally - so as not to burden
// the server. 
// {!isNull _x} count units _grp <= 0 ||

while {true} do
{
    _specplayers = [] call ace_spectator_fnc_players;
    _grpId = groupId (_grp);
    _zeusGroups = missionNamespace getVariable ["f_var_hiddenGroups", []];

    if ( (leader _grp in _specplayers) || (_grpId in _zeusGroups)) then {
        _mkrName setMarkerAlphaLocal 0;
    } else {
        _mkrName setMarkerAlphaLocal 1;
    };


    _newMkrType = "b_unknown";
    _newMkrColor = _grp getVariable ["ca_groupcolor","ColorBlack"];
    _grptypevar = _grp getVariable ["ca_grouptype","auto"];
    if (_grptypevar == "auto") then {
        _newMkrType = "b_hq";
        _leader = leader _grp;
        _vehicle = objectParent _leader;
        switch (true) do {
            case ((rankid _leader >= ca_slrank) && count units _grp <= 2): {_newMkrType = "b_hq";};
            case (isnull _vehicle): { _newMkrType = "b_inf"; };
            case (_vehicle isKindOf "Car"): { _newMkrType = "b_motor_inf"; };
            case (_vehicle isKindOf "Tank"): {
                _totalSeats = [(typeof _vehicle), true] call BIS_fnc_crewCount;
                _crewSeats = [(typeof _vehicle), false] call BIS_fnc_crewCount; 
                _cargoSeats = _totalSeats - _crewSeats; 
                    if (_crewSeats <= _cargoSeats) then {
                            _newMkrType = "b_mech_inf"; 
                        } else {
                            _newMkrType = "b_armor"; 
                    };
                };
            case (_vehicle isKindOf "Ship"): { _newMkrType = "b_naval"; };
            case (_vehicle isKindOf "Helicopter"): { _newMkrType = "b_air"; };
            case (_vehicle isKindOf "Plane"): { _newMkrType = "b_plane"; };
            case (_vehicle isKindOf "Wheeled_APC_F"): { _newMkrType = "b_mech_inf"; };
            case (_vehicle isKindOf "StaticWeapon"): { _newMkrType = "b_art"; };
        };
    } else {
        _newMkrType = _grptypevar;
    };
    
    _mkrName setMarkerTypeLocal  _newMkrType;
    _mkrName setMarkerColorLocal _newMkrColor;

	_mkrName setMarkerPosLocal [(getPos leader _grp select 0),(getPos leader _grp select 1)];
    _newmkrText = groupId _grp;
    _mkrName setMarkerTextLocal _newmkrText;
	sleep 0.5;
};
