// CA - Filling listbox for the ca marker management system.
disableSerialization;
_display = findDisplay 1995;
_lb1ctrl = _display displayCtrl 1500; _lb2ctrl = _display displayCtrl 1501;

{_lb1ctrl lbAdd _x; _lb1ctrl lbSetData [_forEachIndex, _x];} forEach ['ColorYellow','ColorRed','ColorBlue','ColorGreen','ColorOrange','ColorBlack','ColorWhite','ColorGrey','ColorBrown','ColorKhaki'];
{_lb2ctrl lbAdd _x; _lb2ctrl lbSetData [_forEachIndex, _x];} forEach ['b_hq','b_inf','b_support','b_motor_inf','b_mortar','b_maint','b_mech_inf','b_armor','b_recon','b_air','b_plane','b_art'];
