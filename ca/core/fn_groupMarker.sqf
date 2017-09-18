// F3_CA - The Jip groupmarker edition
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE PRIVATE VARIABLES

// ====================================================================================

// SET KEY VARIABLES
// Using variables passed to the script instance, we will create some local variables:

params["_netid",["_mkrType","b_hq"],["_mkrColor","ColorBlack"]];

//private _grp = missionNamespace getVariable [_grpName,grpNull];
//private _mkrName = format ["mkr_%1",_grpName];

// ====================================================================================
_grp = groupFromNetId _netid;
_mkrName = groupid _grp;
// ====================================================================================

// EXIT FOR EMPTY GROUPS (PART I)
// If the group is empty, this script exits.

if (isnil "_grp") exitWith {};

// ====================================================================================
// Create groupID
// Allows for defining it based on mapmarkers, which is a shorthand identifier anyways.
// Reprecated! Now GroupIDs(and marker text!) can be set in eden, but doesnt always work!
//_grp setGroupId [format ["%1",_mkrText],"GroupColor0"];
_newmkrText = groupId _grp;
// ====================================================================================
// CREATE MARKER
// Depending on the value of _mkrType a different type of marker is created.

_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
_mkr setMarkerShapeLocal "ICON";
_mkrName setMarkerTypeLocal  _mkrType;
_mkrName setMarkerColorLocal _mkrColor;
_mkrName setMarkerSizeLocal [0.8, 0.8];
_mkrName setMarkerTextLocal _newmkrText;

// Set variables for group.
_grp setVariable ["ca_groupcolor", (_grp getVariable ["ca_groupcolor",_mkrColor])];
_grp setVariable ["ca_grouptype", (_grp getVariable ["ca_grouptype",_mkrType])];

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
