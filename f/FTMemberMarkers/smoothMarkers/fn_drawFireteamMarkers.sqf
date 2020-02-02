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


{
	_unit = _x;

	if (simulationEnabled _unit) then
	{
		_pos = getPos _unit;
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
