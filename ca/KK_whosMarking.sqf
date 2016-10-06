if (!isDedicated) then {
    KK_fnc_collectMrkInfo = {
        [
            _this,
            markerText _this,
            markerPos _this,
            mapGridPosition markerPos _this,
            markerDir _this,
            markerSize _this,
            markerType _this,
            markerShape _this,
            markerBrush _this,
            markerColor _this,
            markerAlpha _this
        ]
    };
    KK_fnc_setMrkEHs = {
        scopeName "func";
        waitUntil {
            if (
                _this == 53 && getClientState == "BRIEFING READ"
            ) then {
                breakOut "func";
            };
            !isNull findDisplay _this
        };
        findDisplay _this displayAddEventHandler [
            "KeyDown",
            {
                if (_this select 1 == 211) then {
                    _mrknames = allMapMarkers;
                    _mrkdetails = [];
                    {
                        _mrkdetails pushBack (
                            _x call KK_fnc_collectMrkInfo
                        );
                    } forEach _mrknames;
                    0 = [_mrknames, _mrkdetails] spawn {
                        _mrknames = _this select 0;
                        _mrkdetails = _this select 1;
                        MrkOpPV = [
                            "DELETED",
                            name player,
                            getplayerUID player
                        ];
                        {
                            _i = _mrknames find _x;
                            if (_i > -1) then {
                                MrkOpPV pushBack (_mrkdetails select _i);
                            };
                        } forEach (_mrknames - allMapMarkers);
                        if (count MrkOpPV > 3) then {
                            publicVariableServer "MrkOpPV";
                        };
                    };
                    false
                };
            }
        ];
        findDisplay _this displayAddEventHandler [
            "ChildDestroyed",
            {
                if (
                    ctrlIdd (_this select 1) == 54 && _this select 2 == 1
                ) then {
                    0 = all_mrkrs spawn {
                        MrkOpPV = [
                            "PLACED",
                            name player,
                            getplayerUID player
                        ];
                        {
                            MrkOpPV pushBack (
                                _x call KK_fnc_collectMrkInfo
                            );
                        } forEach (allMapMarkers - _this);
                        if (count MrkOpPV > 3) then {
                            publicVariableServer "MrkOpPV";
                        };
                    };
                };
            }
        ];
        findDisplay _this displayCtrl 51 ctrlAddEventHandler [
            "MouseButtonDblClick",
            {
                0 = 0 spawn {
                    if (!isNull findDisplay 54) then {
                        findDisplay 54 displayCtrl 1
                            buttonSetAction "all_mrkrs = allMapMarkers";
                    };
                };
            }
        ];
    };
    0 = 12 spawn KK_fnc_setMrkEHs;
    0 = 53 spawn KK_fnc_setMrkEHs;
} else {
    0 = 0 spawn {
        "MrkOpPV" addPublicVariableEventHandler {
            "debug_console" callExtension (
                str (_this select 1) +
                (if (_this select 1 select 0 == "DELETED") then [
                    {"#1001"},
                    {"#0101"}
                ])
            );
        };
    };
};