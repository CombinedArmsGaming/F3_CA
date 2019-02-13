/* --------------------------------------------------------------------------------------------------------------------
	Author:		Cre8or
	Description:
		Continuously checks if the Zeus interface is open, and if so, initialises the Zeus UI.
	Arguments:
		(nothing)
	Returns:
		(nothing)
-------------------------------------------------------------------------------------------------------------------- */

#include "config\macros.hpp"

disableSerialization;





// Set up some variables
private _zeusDisplayExists = false;

// Loop
while {true} do {

	// Wait for the units list to be compiled
	if (missionNamespace getVariable [MACRO_VARNAME_UI_LISTSCOMPILED, false]) then {

		// If the Zeus display was found, start our custom UI
		private _zeusDisplay = findDisplay 312;
		if (!isNull _zeusDisplay) then {

			// Start the Zeus UI
			if (!_zeusDisplayExists) then {
				["ui_init"] call ca_fnc_zeusUI;
				_zeusDisplayExists = true;
			};

		// Otherwise, reset
		} else {
			if (_zeusDisplayExists) then {
				_zeusDisplayExists = false;
			};
		};
	};

	// Sleep
	uiSleep 0.05;
};
