
params ["_array","_unitarray","_side"];

{
    [_unitarray,_x,_side] call p_fnc_spawngroup;
} forEach _array;
