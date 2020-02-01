
#include "macros.hpp"

CLIENT_ONLY;
RUN_AS_ASYNC(f_fnc_initSquadMarkerManager);

f_arr_squadMarkers = [];
f_arr_unitMarkers = [];

waitUntil
{
    if !(alive player) exitWith {false};

    _newMarkers = [];
    _newUnitMarkers = [];

    _playerSide = side group player;
    _sideGroups = allGroups select {side _x == _playerSide};

    _sideName = [_playerSide] call f_fnc_sideToString;

    {
        _group = _x;
        _units = units _group;

        if !(isNull _group or {{alive _x} count _units <= 0}) then
    	{
            _name = groupId _group;

            _icon = "";
            _colour = [];
            _visible = true;
            _specials = [];

            _entry = SQUAD_VAR_DYNAMIC(_name,_sideName);

            if !(_entry isEqualTo []) then
            {
                _visible = SQUAD_VISIBLE(_entry);

                if (_visible) then
                {
                    if !(SQUAD_NAME(_entry) isEqualTo "") then {_name = SQUAD_NAME(_entry)};
                    if !(SQUAD_ICON(_entry) isEqualTo "") then {_icon = SQUAD_ICON(_entry)};
                    if !(SQUAD_COLOUR(_entry) isEqualTo []) then {_colour = SQUAD_COLOUR(_entry)};
                    _specials = SQUAD_SPECIALS(_entry);

                };

            };

            if (_visible) then
            {
                _isAiOnly = ({isPlayer _x} count _units) <= 0;
                _shouldShow = false;

                if (IS_TRUE(f_var_smoothMarkers_showAI)) then
                {
                    _shouldShow = true;
                }
                else
                {
                    _shouldShow = !_isAiOnly;
                };

                if (_shouldShow) then
                {
                    if (_isAiOnly) then
                    {
                        if (_name == groupId _group) then
                        {
                            _name = "Allies";
                        };

                        if (_colour isEqualTo []) then
                        {
                            _colour = LIGHTGREY;
                        };

                    };

                    if (_icon isEqualTo "") then {_icon = [_group] call f_fnc_getGroupMarker};
                    if (_colour isEqualTo []) then {_colour = DEFAULT_COLOUR};

                    _newMarkers pushBack [_group, _icon, _name, _colour];

                };

            };

            {
                [_group, _newUnitMarkers] call _x;

            } forEach _specials;

        };

    } forEach _sideGroups;


    f_arr_squadMarkers = _newMarkers;
    f_arr_unitMarkers = _newUnitMarkers;

    sleep 1;
	false

};
