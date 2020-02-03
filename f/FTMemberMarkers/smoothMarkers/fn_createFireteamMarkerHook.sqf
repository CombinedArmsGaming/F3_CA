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
			"_this call f_fnc_drawFireteamMarkers"
		];

	};

};


[] spawn
{
	waitUntil
	{
		sleep 1;
		_display = (uiNamespace getVariable "RscCustomInfoMiniMap");
		!( (isNull _display) or {isNull (_display displayCtrl 101)} )
	};

	if (isNil 'f_var_ftMarkersDrawHandlerId_RscCustomInfoMiniMap') then
	{
		f_var_ftMarkersDrawHandlerId_RscCustomInfoMiniMap = ((uiNamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101) ctrlAddEventHandler
		[
			"Draw",
			"_this call f_fnc_drawFireteamMarkers"
		];

	};

};
