// F3 - Folk Group Markers
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE PRIVATE VARIABLES

// ====================================================================================

// SET KEY VARIABLES
// Using variables passed to the script instance, we will create some local variables:

#include "smoothMarkers\macros.hpp"

params["_grpName",["_mkrType","auto"],"_mkrText",["_mkrColor","ColorBlack"]];

private _grp = missionNamespace getVariable [_grpName,grpNull];
private _mkrName = format ["mkr_%1",_grpName];

// Exit with an error if "auto" markers are selected with smooth markers disabled.
_smoothMarkersEnabled = IS_TRUE(f_var_smoothMarkers);

if (_mkrType isEqualTo "auto" and {!_smoothMarkersEnabled}) then
{
	throw "Smooth markers are not enabled, marker type 'auto' cannot be used.";
};

// ====================================================================================

// WAIT FOR GROUP TO EXIST IN-MISSION
// We wait for the group to have members before creating the marker.

if (isNull _grp) then
{
	waitUntil { sleep 3; _grp = missionNamespace getVariable [_grpName,grpNull]; count (units _grp) > 0 };
};

// ====================================================================================

// EXIT FOR EMPTY GROUPS (PART I)
// If the group is empty, this script exits.

if (isnil "_grp") exitWith {};

// Set variables for group.
_grp setVariable ["ca_groupcolor", (_grp getVariable ["ca_groupcolor",_mkrColor])];
_grp setVariable ["ca_grouptype", (_grp getVariable ["ca_grouptype",_mkrType])];

// ====================================================================================
// Create groupID
// Allows for defining it based on mapmarkers, which is a shorthand identifier anyways.
// Reprecated! Now GroupIDs(and marker text!) can be set in eden, but doesnt always work!
_grp setGroupIdGlobal [format ["%1",_mkrText],"GroupColor0"];
_newmkrText = groupId _grp;

// ====================================================================================
// Smooth markers support

_side = [side player] call f_fnc_sideToString;
_grpId = groupId _grp;

// Convert the colour string into an array of colour values.
_colorRGBA = (configfile >> "CfgMarkerColors" >> _mkrColor >> "color") call BIS_fnc_colorConfigToRGBA;

// Add info into a dictionary so smooth markers can get what they need to run.
MAKE_SQUAD_EDITABLE_DYNAMIC(_grpId,_side);
SET_SQUAD_COLOUR_DYNAMIC(_grpId,_side,_colorRGBA);
SET_SQUAD_NAME_DYNAMIC(_grpId,_side,_grpName);

if !(_mkrType isEqualTo "auto") then
{
	SET_SQUAD_ICON_DYNAMIC(_grpId,_side,_mkrType);
};


// ====================================================================================
// If smooth markers are enabled, exit the function here instead of creating a normal marker below.
if (_smoothMarkersEnabled) exitWith {};

// ====================================================================================
// CREATE MARKER
// Depending on the value of _mkrType a different type of marker is created.

_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
_mkr setMarkerShapeLocal "ICON";
_mkrName setMarkerTypeLocal  _mkrType;
_mkrName setMarkerColorLocal _mkrColor;
_mkrName setMarkerSizeLocal [0.8, 0.8];
_mkrName setMarkerTextLocal _newmkrText;

// ====================================================================================

// UPDATE MARKER POSITION
// As long as certain conditions are met (the group exists) the marker
// position is updated periodically. This only happens locally - so as not to burden
// the server.

while {true} do
{
    if ({!isNull _x} count units _grp <= 0) then {
        _mkrName setMarkerAlphaLocal 0;
    } else
    {
        _mkrName setMarkerAlphaLocal 1;
    };
    _newMkrColor = _grp getVariable ["ca_groupcolor","ColorBlack"];
    _newMkrType = _grp getVariable ["ca_grouptype","b_hq"];
    _mkrName setMarkerTypeLocal  _newMkrType;
    _mkrName setMarkerColorLocal _newMkrColor;

	_mkrName setMarkerPosLocal [(getPos leader _grp select 0),(getPos leader _grp select 1)];
    _newmkrText = groupId _grp;
    _mkrName setMarkerTextLocal _newmkrText;
	sleep 2;
};

// ====================================================================================
