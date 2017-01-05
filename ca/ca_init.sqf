

_ishc = !hasInterface && !isDedicated;
if (_ishc && didJIP) then {
		if (!ca_hc) then {
			remoteExec ["ca_fnc_hcinit", 2];
		} else{ [] spawn ca_fnc_hcmarker;
	};
};
