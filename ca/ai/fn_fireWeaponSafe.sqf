params [
        ["_unit", objNull, [objNull]],
        ["_muzzle", "", [""]],
        ["_mode", "Single", [""]]
];

// Abort if the unit is dead or not a man
if (!alive _unit or {!(typeOf _unit isKindOf "Man")}) exitWith {};




// Force this function to execute in unscheduled environment
private _return = false;
isNil {

        private _canFire = true;
        private _unitSide = side _unit;

        private _startPos = _unit modelToWorldWorld (_unit selectionPosition "righthand");
        private _endPos = _startPos vectorAdd ((_unit weaponDirection currentWeapon _unit) vectorMultiply 300);
        private _results = lineIntersectsSurfaces [_startPos, _endPos, _unit, objNull, true, 10];

        // Iterate through all found objects
        {
                private _object = _x param [3, objNull];

                if (_object isKindOf "AllVehicles" and {_unitSide getFriend side _object > 0.6}) then {

                        // If the object is a man, don't shoot
                        if (_object isKindOf "Man") exitWith {
                                _canFire = false;
                        };

                        // Otherwise, it's a vehicle
                        private _hasCrew = false;
                        {
                                if (alive _x) exitWith {
                                        _hasCrew = true;
                                };
                        } forEach crew _object;

                        if (_hasCrew) exitWith {
                                _canFire = false;
                        };
                };
        } forEach _results;

        // If no friendly objects were in the way, engage
        if (_canFire) then {
                _unit forceWeaponFire [_muzzle, _mode];
                _return = true;
        };
};

// Return whether or not we were allowed to fire
_return;
