#include "macros.hpp"

params ["_group"];

_groupName = groupId _group;
_sideName = [side leader _group] call ca_fnc_sideToString;
_squadDef = SQUAD_VAR_DYNAMIC(_groupName,_sideName);
_iconOverride = "";

if !(_squadDef isEqualTo []) then
{
    _iconOverride = SQUAD_ICON(_squadDef);
};

if !(_iconOverride isEqualTo "") exitWith
{
    _iconOverride
};

_units = units _group;
_size = count _units;
_crew = _units select {!isNull objectParent _x};
_crewSize = count _crew;

if (_crewSize <= 0) exitWith
{
    INFANTRY
};


_vehicles = [];

{
    _vehicles pushBack (objectParent _x);

} forEach _crew;

_vehicles = _vehicles call BIS_fnc_consolidateArray;


_hasTank = false; // Tank, Tank_F, "Wheeled_APC_F"
_hasCar = false;  // Car, Car_F
_hasPlane = false; // "Plane_Base_F","Plane"
_hasHelo = false; // "Helicopter_Base_H", "Helicopter_Base_F", "Helicopter"
_hasShip = false; // "Ship_F", "Ship"

{
    _vic = _x select 0;

    _hasCar = _hasCar or {_vic isKindOf "Car"};
    _hasTank = _hasTank or {_vic isKindOf "Tank"} or {_vic isKindOf "Wheeled_APC_F"};
    _hasPlane = _hasPlane or {_vic isKindOf "Plane"};
    _hasHelo = _hasHelo or {_vic isKindOf "Helicopter"};
    _hasShip = _hasShip or {_vic isKindOf "Ship"};

} forEach _vehicles;


if (_hasShip) exitWith
{
    NAVAL
};

if (_hasPlane) exitWith
{
    PLANE
};

if (_hasHelo) exitWith
{
    HELO
};

if (_hasTank) exitWith
{
    if (_size > _crewSize) then
    {
        MECHINF
    }
    else
    {
        ARMOR
    };

};

if (_hasCar) exitWith
{
    MOTORINF
};


UNKNOWN
