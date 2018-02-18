if (!isServer) exitWith {};

[] spawn {
    _specplayers = [] call ace_spectator_fnc_players;
{
        _x setPos (getmarkerpos "respawn_west");
} forEach _specplayers;
missionNamespace setVariable ['ca_respawnwave',true, true];
missionNamespace setVariable ['ca_respawnready',false, true];

_number = ca_norespawnwaves;
missionNamespace setVariable ['ca_norespawnwaves',(_number - 1), true];

ca_respawnmsg remoteExec ["systemChat"];
sleep 60;
missionNamespace setVariable ['ca_respawnwave',false, true];
sleep ca_wavecooldown;
missionNamespace setVariable ['ca_respawnready',true, true];
};
