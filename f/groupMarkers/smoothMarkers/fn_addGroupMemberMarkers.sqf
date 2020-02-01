#include "macros.hpp"

params ["_group", "_markersArray", "_unitType", "_displayName"];

// Getting custom entry for squad if exists.  Exit early if squad is forced invisible on map.
_name = groupId _group;
_entry = SQUAD_VAR_DYNAMIC(_name,_sideName);
_entryExists = false;
_visible = true;

if !(_entry isEqualTo []) then
{
    _entryExists = true;
    _visible = SQUAD_VISIBLE(_entry);
};

if !(_visible) exitWith {};


// Find all eligible units (marker type == gearscript type)
_units = [];

{
    _class = _x getVariable ["f_var_assignGear", ""];

    if (_class isEqualTo _unitType) then
    {
        _units pushBack _x;
    };

} forEach (units _group);


// Try to match marker colour with squad colour, also marker name.
_sideName = [side _group] call f_fnc_sideToString;

_colour = WHITE;

if (_entryExists and _visible) then
{
    if !(SQUAD_NAME(_entry) isEqualTo "") then {_name = SQUAD_NAME(_entry)};
    if !(SQUAD_COLOUR(_entry) isEqualTo []) then {_colour = SQUAD_COLOUR(_entry)};
};

_name = format ["%1 %2", _name, _displayName];


// Generate markers, store in passed-in array.
{
    _markersArray pushBack [_group, _x, _name, _colour];

} forEach _units;
