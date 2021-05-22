
#include "macros.hpp"

CLIENT_ONLY;
RUN_AS_ASYNC(ca_fnc_initSquadMarkerManager);

f_arr_squadMarkers = [];
f_arr_unitMarkers = [];

waitUntil
{

    _newMarkers = [];
    _newUnitMarkers = [];

    if (!IS_TRUE(f_var_smoothMarkers_hide) and {alive player}) then
    {
        _playerSide = side group player;
        _sideGroups = allGroups select {side _x == _playerSide};

        _sideName = [_playerSide] call ca_fnc_sideToString;

        {
            _group = _x;
            _units = units _group;

            if !(isNull _group or {{alive _x} count _units <= 0}) then
        	{
                _name = groupId _group;
                _zeusGroups = missionNamespace getVariable ["f_var_hiddenGroups", []];

                if (_name in _zeusGroups) exitWith {};

                _icon = "";
                _visible = true;
                _specials = [];

                _colourText = _group getVariable ["ca_groupcolor","ColorBlack"];
                _colour = (configfile >> "CfgMarkerColors" >> _colourText >> "color") call BIS_fnc_colorConfigToRGBA;

                _iconText = _group getVariable ["ca_grouptype","auto"];

                if !(_iconText isEqualTo "auto") then
                {
                    _icon = [_iconText] call ca_fnc_convertMarkerNameToImage;
                };

                _entry = SQUAD_VAR_DYNAMIC(_name,_sideName);
                _entryExists = !(_entry isEqualTo []);

                if (_entryExists) then
                {
                    _visible = SQUAD_VISIBLE(_entry);

                    if (_visible) then
                    {
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
                        if (_isAiOnly and {!_entryExists}) then
                        {
                            if (_name == groupId _group) then
                            {
                                _name = "Allies";
                                _colour = LIGHTGREY;
                            };

                        };

                        if (_icon isEqualTo "") then {_icon = [_group] call ca_fnc_getGroupMarker};
                        if (_colour isEqualTo []) then {_colour = DEFAULT_COLOUR};

                        _newMarkers pushBack [_group, _icon, _name, _colour];

                    };


                    _specialists = [];

                    {
                        if (_x getVariable ["ca_specialistmarker", false]) then
                        {
                            _specialists pushBackUnique _x;
                        };

                    } forEach _specials;

                    if (!(isNil 'ca_specialistMarkerClasses')) then
                    {
                        {
                            if (_x getVariable ["ca_specialistmarker", false]) then
                            {
                                _specialists pushBackUnique _x;
                            };

                        } forEach _units;

                    };

                    {
                        [_group, _newUnitMarkers, _x] call ca_fnc_addSpecialistMarker;

                    } forEach _specialists;

                };

            };

        } forEach _sideGroups;

    };


    f_arr_squadMarkers = _newMarkers;
    f_arr_unitMarkers = _newUnitMarkers;

    sleep 1;
	false

};
