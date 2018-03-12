if ((ca_norespawnwaves <= 0) || (ca_respawnmode == 0) || !ca_respawnready ) exitWith {
    if (!ca_respawnready) then {
        systemChat "HQ to command: Reinforcements are not possible at this time!";
    } else {
        systemChat "HQ to command: We are out of reinforcement waves!";
    };
};
// Move the respawn_west marker to the position of the player who called the wave if respawn on co is active
if (ca_respawnmode == 2) then {
    ca_respawnmarker setMarkerPos (getpos player);
};
[] remoteExec ["ca_fnc_respawnwaveserver", 2];
