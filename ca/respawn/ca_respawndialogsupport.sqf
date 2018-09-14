// CA - Filling listbox for the ca marker management system.
_alreadyinlist = [];

while {true} do {
    disableSerialization;
    _display = findDisplay 1996;
    _lb1ctrl = _display displayCtrl 1500;

    _specplayers = [] call ace_spectator_fnc_players;
    _listplayers = _specplayers - _alreadyinlist;
    { _alreadyinlist pushback _x; _lb1ctrl lbAdd (name _x); _lb1ctrl lbSetData [_forEachIndex, (name _x)];} forEach _listplayers;

    _waves = _display displayCtrl 1004;
    _noplayers = _display displayCtrl 1005;
    _timer = _display displayCtrl 1006;


    _waves ctrlSetText ('Waves left:'+ str(ca_norespawnwaves));
    _noplayers ctrlSetText (str(count _specplayers) + ' players in spectate');

    _time = (ca_wavetime + ca_wavecooldown + ca_respawntime - time);
    if ( 0 > _time) then {
        _timer ctrlSetText ('Respawn wave available');
    }else {
        _timer ctrlSetText (str(round _time) + ' Seconds until wave available');
    };
sleep 0.9;
};
