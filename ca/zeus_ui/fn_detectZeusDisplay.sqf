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

[] spawn {
	disableSerialization;

	// Wait for the mission to start
	waitUntil {time > 0};

	// Set up some variables
	private _zeusDisplayExists = false;
	private _camPos = getPosASL player;
	private _nextMove = 0;
	private _nextHeal = 0;





	// Loop
	while {true} do {

		// Wait for the units list to be compiled
		if (missionNamespace getVariable [MACRO_VARNAME_UI_LISTSCOMPILED, false]) then {

			// Fetch the Zeus display
			private _zeusDisplay = findDisplay 312;

			// If the Zeus display is open...
			if (!isNull _zeusDisplay) then {
				if (!_zeusDisplayExists) then {
					_zeusDisplayExists = true;

					// Start the custom Zeus UI
					["ui_init"] call ca_fnc_zeusUI;

					// Hide the player
					[player, false] remoteExec ["ca_fnc_activateZeusPlayer", 2];
				};

				// Constantly move the player to the Zeus camera's position
				private _time = time;
				if (_time >= _nextMove) then {
					_nextMove = _time + 0.25;
					_camPos = getPosASL curatorCamera;
					player setPosASL _camPos;
				};

				// Constantly heal the player
				if (_time >= _nextHeal) then {
					_nextHeal = _time + 1;

					//[objNull, player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;		// ACE3 version < v3.13.0 (before the medical rewrite)
					[player] call ace_medical_treatment_fnc_fullHealLocal;					// ACE3 version >= v3.13.0
					player setDamage 0;
				};

			// Otherwise, if it is closed...
			} else {
				if (_zeusDisplayExists) then {
					_zeusDisplayExists = false;
					private _isRemoteControlling = false;

					// Check if we're actively remote controlling a different unit
					if (isNull curatorCamera) then {
						if (!isNil "bis_fnc_moduleRemoteControl_unit" and {bis_fnc_moduleRemoteControl_unit isEqualType objNull}) then {
							if (!isNull bis_fnc_moduleRemoteControl_unit) then {
								_isRemoteControlling = true;
							};
						};
					};

					// If we aren't, unhide the player
					if (!_isRemoteControlling) then {
						[player, true] remoteExec ["ca_fnc_activateZeusPlayer", 2];

						// Find the ground position under the last pos
						private _posGround = ((lineIntersectsSurfaces [_camPos, _camPos vectorAdd [0, 0, -100], player]) param [0, []]) param [0, []];

						if (_posGround isEqualTo []) then {
							player setVehiclePosition [ASLtoATL _camPos, [], 1, "NONE"];
						} else {
							player setPosASL _posGround;
						};
					};
				};
			};
		};

		// Sleep
		uiSleep 0.05;
	};
};
