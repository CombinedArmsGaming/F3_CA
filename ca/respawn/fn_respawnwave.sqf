if ((ca_norespawnwaves <= 0) || (ca_respawnmode == 0) || !ca_respawnready ) exitWith {
    if (!ca_respawnready) then {
        "HQ to command: Reinforcements are not possible at this time!" remoteExec ["systemChat"];
    } else {
        "HQ to command: We are out of reinforcement waves!" remoteExec ["systemChat"];
    };
};
if (ca_respawnmode == 2) then {
    ca_respawnmarker setMarkerPos (getpos player);
};
[] remoteExec ["ca_fnc_respawnwaveserver", 2];
