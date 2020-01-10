// F3 - Folk Unit Markers for Specialists
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE PRIVATE VARIABLES

private ["_mkr"];

// ====================================================================================

// SET KEY VARIABLES
// Using variables passed to the script instance, we will create some local variables:

params["_untName",["_mkrType","b_hq"],"_mkrText",["_mkrColor","ColorBlack"]];

private _mkrName = format ["mkr_%1",_untName];
private _unt = missionNamespace getVariable [_untName, objNull];

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

while {true} do
{
    if (!alive _unt || isnull _unt) then {
        _mkrName setMarkerAlphaLocal 0;
    } else
    {
        _mkrName setMarkerAlphaLocal 1;
    };

    _mkrName setMarkerPosLocal [(getPos _unt select 0),(getPos  _unt select 1)];
	sleep 2;
};
