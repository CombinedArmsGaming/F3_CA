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
		24,
		24,
		_dir
	];

	_map drawIcon
	[
		_icon,
		_colour,
		_pos,
		20,
		20,
		_dir
	];

};


{
	_unit = _x;

	if (simulationEnabled _unit) then
	{
		_pos = getPosVisual _unit;
		_dir = getDirVisual _unit;

		private "_icon";
		private "_colour";

		// Requires Diwako's DUI.
		if !(isNil 'diwako_dui_font') then
		{
			_icon = _unit getVariable ["diwako_dui_radar_compass_icon", "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa"];
			_colour = (_unit getVariable ["diwako_dui_main_compass_color", [1,1,1]]) + [1];
		}
		else
		{
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

		};

		[_map, _icon, _colour, _pos, _dir] call _drawMarker;

	};

} forEach _group;
