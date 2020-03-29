#include "macros.hpp"

params ["_group", "_markersArray", "_unit"];

if (isNull _unit) exitWith {};

// Getting custom entry for squad if exists.  Exit early if squad is forced invisible on map.
_groupName = groupId _group;
_entry = SQUAD_VAR_DYNAMIC(_groupName,_sideName);
_entryExists = false;
_visible = true;

if !(_entry isEqualTo []) then
{
    _entryExists = true;
    _visible = SQUAD_VISIBLE(_entry);
};

if !(_visible) exitWith {};

// Try to match marker colour with squad colour.
_colour = WHITE;

if (_entryExists and _visible) then
{
    _colourText = _group getVariable ["ca_groupcolor","ColorWhite"];
    _colour = (configfile >> "CfgMarkerColors" >> _colourText >> "color") call BIS_fnc_colorConfigToRGBA;
};

_unitRole = toUpper (_unit getVariable ["f_var_assignGear", ""]);
_displayName = format ["%1 %2", _groupName, _unitRole];

// Generate marker, store in passed-in array.
_markersArray pushBack [_group, _unit, _displayName, _colour];
