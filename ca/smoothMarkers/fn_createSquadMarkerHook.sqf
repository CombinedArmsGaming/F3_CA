#include "macros.hpp"

[] spawn
{
	waitUntil
	{
		sleep 1;
		_display = (uiNamespace getVariable "RscDiary");
		!( (isNull _display) or {isNull (_display displayCtrl 51)} )
	};

	// Wait until fireteam marker hook has been registered, so FT markers appear on top of squad icons.
	waitUntil
	{
		!(isNil 'f_var_ftMarkersDrawHandlerId_RscDiary')
	};

	if (isNil 'f_var_squadMarkersDrawHandlerId_RscDiary') then
	{
		f_var_squadMarkersDrawHandlerId_RscDiary = ((uiNamespace getVariable "RscDiary") displayCtrl 51) ctrlAddEventHandler
		[
			"Draw",
			"(_this + [false]) call ca_fnc_drawSquadMarkers"
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

		// Wait until fireteam marker hooks have been registered, so FT markers appear on top of squad icons.
		waitUntil
		{
			!(isNil 'f_var_addedFireteamMarkerHooks')
		};

		{
			if !(_x getVariable ["ca_var_addedSquadMarkerHook", false]) then
			{
				(_x displayCtrl 101) ctrlAddEventHandler ["Draw", "(_this + [true]) call ca_fnc_drawSquadMarkers"];
				_x setVariable ["ca_var_addedSquadMarkerHook", true];
			};

		} forEach ((uiNamespace getVariable ["IGUI_Displays", []]) select {ctrlIDD _x == 311});

		sleep 5;

	};

};
