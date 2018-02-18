// CA - Filling listbox for the ca marker management system.
disableSerialization;
_display = findDisplay 1996;
_lb1ctrl = _display displayCtrl 1500;

_specplayers = [] call ace_spectator_fnc_players;

{_lb1ctrl lbAdd (name _x); _lb1ctrl lbSetData [_forEachIndex, (name _x)];} forEach _specplayers;

_waves = _display displayCtrl 1004;
_noplayers = _display displayCtrl 1005;

_waves ctrlSetText ('Waves left:'+ str(ca_norespawnwaves));
_noplayers ctrlSetText (str(count _specplayers) + ' players in spectate')
