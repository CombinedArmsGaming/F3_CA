
// CA - Mission briefing
execVM "ca\briefing\ca_briefing_player.sqf";
if (serverCommandAvailable "#kick") then {
  execVM "ca\briefing\ca_briefing_admin.sqf";
};

// PabstMirror - Mission Intro
// Credits: PabstMirror
[] execVM "ca\misc\PM_missionIntro.sqf";

// Headless join in progress support.
_ishc = !hasInterface && !isDedicated;
if (_ishc) then {
    [] spawn ca_fnc_hcmarker;
};
if (_ishc && didJIP) then {
	if (!ca_hc) then {
		remoteExec ["ca_fnc_hcinit", 2];
	};
};


