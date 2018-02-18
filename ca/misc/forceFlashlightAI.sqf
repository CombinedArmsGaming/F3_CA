{
    private ["_unit"];

    _unit = _x;

    // Only run where the unit is local, it isn't a player and doesn't have a flashlight
    if (local _unit && !isplayer _unit && !("acc_flashlight" in primaryWeaponItems _unit)) then {

        // Remove laser if equipped
        if ("acc_pointer_IR" in primaryWeaponItems _unit) then
        {
        _unit removePrimaryWeaponItem "acc_pointer_IR";
        };

        // Add flashlight
        _unit addPrimaryWeaponItem "acc_flashlight";
        // Removes NVGs from unit
        if !(hmd _unit == "") exitWith {_unit unlinkItem (hmd _unit);}; // hmd returns "" if no head mounted display

    };

    // Forces flashlights on
    _unit enablegunlights "forceOn";

} forEach entities "CAManBase";