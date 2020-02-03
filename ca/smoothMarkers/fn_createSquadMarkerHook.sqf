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
			"_this call ca_fnc_drawSquadMarkers"
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

	// Wait until fireteam marker hook has been registered, so FT markers appear on top of squad icons.
	waitUntil
	{
		!(isNil 'f_var_ftMarkersDrawHandlerId_RscCustomInfoMiniMap')
	};

	if (isNil 'f_var_squadMarkersDrawHandlerId_RscCustomInfoMiniMap') then
	{
		f_var_squadMarkersDrawHandlerId_RscCustomInfoMiniMap = ((uiNamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101) ctrlAddEventHandler
		[
			"Draw",
			"_this call ca_fnc_drawSquadMarkers"
		];

	};

};
