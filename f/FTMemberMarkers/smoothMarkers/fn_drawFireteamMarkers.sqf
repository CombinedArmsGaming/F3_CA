#include "macros.hpp"

params ["_map", "_smallMarkers"];

if !(alive player) exitWith {};
if (IS_TRUE(f_var_smoothFTMarkers_hide)) exitWith {};

_group = (units player) select {[_x] call ca_fnc_isPlayerAlive};
_baseIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";


_drawMarker =
{
	params ["_map", "_icon", "_colour", "_pos", "_dir", "_smallMarkers"];

	_scaleFactor = if (_smallMarkers) then {0.9} else {1};

	_map drawIcon
	[
		_baseIcon,
		[0,0,0,1],
		_pos,
		22 * _scaleFactor,
		22 * _scaleFactor,
		_dir
	];

	_map drawIcon
	[
		_icon,
		_colour,
		_pos,
		18 * _scaleFactor,
		18 * _scaleFactor,
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

		[_map, _icon, _colour, _pos, _dir, _smallMarkers] call _drawMarker;

	};

} forEach _group;
