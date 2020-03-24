#include "macros.hpp"

params ["_map"];

if !(alive player) exitWith {};

_group = (units player) select {alive _x};
_baseIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";


_drawMarker =
{
	params ["_map", "_icon", "_colour", "_pos", "_dir"];

	_map drawIcon
	[
		_baseIcon,
		[0,0,0,1],
		_pos,
		22,
		22,
		_dir
	];

	_map drawIcon
	[
		_icon,
		_colour,
		_pos,
		18,
		18,
		_dir
	];

};




_getSmoothPosition =
{
	_unit = _this;
	_curPos = getPos _unit;

	if (local _unit or {_unit isEqualTo player} or {(vehicle _unit) isEqualTo (vehicle player)}) exitWith
	{
		_unit setVariable ["f_var_smoothFTMarkers_lerpFrom", []];
		_unit setVariable ["f_var_smoothFTMarkers_lerpTo", []];
		_curPos
	};

	_lerpFrom = _unit getVariable ["f_var_smoothFTMarkers_lerpFrom", []];

	if (_lerpFrom isEqualTo []) exitWith
	{
		_unit setVariable ["f_var_smoothFTMarkers_lerpFrom", [_curPos, time]];
		_unit setVariable ["f_var_smoothFTMarkers_lerpTo", [_curPos, time]];
		_curPos
	};

	_lerpFrom = _unit getVariable "f_var_smoothFTMarkers_lerpFrom";
	_lerpTo = _unit getVariable "f_var_smoothFTMarkers_lerpTo";

	if (!(_curPos isEqualTo (_lerpTo select 0)) or {(time - (_lerpTo select 1)) > 0.5}) then
	{
		_lerpFrom = _lerpTo;
		_lerpTo = [_curPos, time];

		_unit setVariable ["f_var_smoothFTMarkers_lerpFrom", _lerpFrom];
		_unit setVariable ["f_var_smoothFTMarkers_lerpTo", _lerpTo];

	};

	_interval = (_lerpTo select 1) - (_lerpFrom select 1);
	_progress = time - (_lerpTo select 1);

	(vectorLinearConversion [0, _interval, _progress, (_lerpFrom select 0), (_lerpTo select 0), false])

};




{
	_unit = _x;

	if (simulationEnabled _unit) then
	{
		_pos = (_unit call _getSmoothPosition);
		_dir = getDir _unit;

		private "_icon";
		private "_colour";

		// Requires shacktac hud.
		if !(isNil 'STHud_Icon') then
		{
			_icon = _unit call STHud_Icon;
			_teamIdx = _unit call STUI_assignedTeamIndex;
			_colour = STHud_PlayerColours select _teamIdx;
		}
		else
		{
			_icon = _baseIcon;
			_colour = [1,1,1,1];
		};

		[_map, _icon, _colour, _pos, _dir] call _drawMarker;

	};

} forEach _group;
