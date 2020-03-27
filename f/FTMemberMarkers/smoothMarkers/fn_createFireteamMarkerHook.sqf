#include "macros.hpp"

[] spawn
{
	waitUntil
	{
		sleep 1;
		_display = (uiNamespace getVariable "RscDiary");
		!( (isNull _display) or {isNull (_display displayCtrl 51)} )
	};

	if (isNil 'f_var_ftMarkersDrawHandlerId_RscDiary') then
	{
		f_var_ftMarkersDrawHandlerId_RscDiary = ((uiNamespace getVariable "RscDiary") displayCtrl 51) ctrlAddEventHandler
		[
			"Draw",
			"(_this + [false]) call f_fnc_drawFireteamMarkers"
		];

	};

};


[] spawn
{
	while {true} do
	{
		waitUntil
		{
			sleep 1;
			_display = (uiNamespace getVariable "RscCustomInfoMiniMap");
			!( (isNull _display) or {isNull (_display displayCtrl 101)} )
		};

		{
			if !(_x getVariable ["ca_var_addedFireteamMarkerHook", false]) then
			{
				(_x displayCtrl 101) ctrlAddEventHandler ["Draw", "(_this + [true]) call f_fnc_drawFireteamMarkers"];
				_x setVariable ["ca_var_addedFireteamMarkerHook", true];
			};

		} forEach ((uiNamespace getVariable ["IGUI_Displays", []]) select {ctrlIDD _x == 311});

		f_var_addedFireteamMarkerHooks = true;

		sleep 5;
		
	};

};
