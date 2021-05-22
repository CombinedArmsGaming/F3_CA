
params ["_display"];

_subtitle = _display displayCtrl 1002;
_text = "";
_side = side player;
_respawnsLeft = 0;

switch (_side) do {
    case west: {
    _respawnsLeft = ca_WestTickets;
    };
    case east: {
    _respawnsLeft = ca_EastTickets;
    };
    case independent: {
    _respawnsLeft = ca_IndependentTickets;
    };
};


if (_respawnsLeft <= 0) then
{
    _text = "No respawn tickets remain.";
}
else
{

    if (ca_respawnmode == 0) then {
        //no respawn
        _text = "This mission does not have respawn.";
    };

    if (ca_respawnmode == 1 || ca_respawnmode == 2) then {
        // CO/Zeus respawn
        _time = (ca_wavetime + ca_wavecooldown + ca_respawntime - time);
        
        if (ca_respawnready) then
        {
            _text = "Respawn waves are available to leaders.";
        }
        else
        {
            _timeString = round _time;
            _text = format ["%1 seconds until respawn is available.", _timeString];
        };    
    };
    if (ca_respawnmode == 3) then {
        // group respawn 
        _time = (group player) getVariable ["ca_grouprespawntime",900000];
        _infotime = ceil (_time - time);

        if (_infotime < 1) then
        {
            _text = "Group respawn is available to leaders.";
        }
        else
        {
            _text = format ["%1 seconds until group respawn is available.", _infotime];
        };    

    };
};

_subtitle ctrlSetText _text;
