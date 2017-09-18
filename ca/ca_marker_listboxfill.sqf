// CA - Filling listbox for the ca marker management system.
disableSerialization;
_display = findDisplay 1995;
_lb1ctrl = _display displayCtrl 1500; _lb2ctrl = _display displayCtrl 1501;

_edctrl = _display displayCtrl 1400; _edctrl ctrlSetText (format ["%1",(groupid group player)]);
_colorarray = ['ColorYellow','ColorRed','ColorBlue','ColorGreen','ColorOrange','ColorBlack','ColorWhite','ColorGrey','ColorBrown','ColorKhaki'];
_typearray = ['b_hq','b_inf','b_support','b_motor_inf','b_mortar','b_maint','b_mech_inf','b_armor','b_recon','b_air','b_plane','b_art'];

{_lb1ctrl lbAdd _x; _lb1ctrl lbSetData [_forEachIndex, _x];} forEach ['ColorYellow','ColorRed','ColorBlue','ColorGreen','ColorOrange','ColorBlack','ColorWhite','ColorGrey','ColorBrown','ColorKhaki'];
{_lb2ctrl lbAdd _x; _lb2ctrl lbSetData [_forEachIndex, _x];} forEach ['b_hq','b_inf','b_support','b_motor_inf','b_mortar','b_maint','b_mech_inf','b_armor','b_recon','b_air','b_plane','b_art'];

_MkrColor = (group player) getVariable ["ca_groupcolor","ColorBlack"];
_MkrType = (group player) getVariable ["ca_grouptype","b_hq"];

{
    if (_MkrColor == _x) then {
        _lb1ctrl lbSetCurSel _forEachIndex;
    };
} forEach _colorarray;
{
    if (_MkrType == _x) then {
        _lb2ctrl lbSetCurSel _forEachIndex;
    };
} forEach _typearray;
