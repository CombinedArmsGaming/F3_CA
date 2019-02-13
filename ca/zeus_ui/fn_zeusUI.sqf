/* --------------------------------------------------------------------------------------------------------------------
	Author:		Cre8or
	Description:
		Handles the Zeus UI. Accepts an event name (e.g. "nit") and an optional array with additional parameters
		that might be required for the specified event.
	Arguments:
		0:      <STRING>	Name of the event
		1:	<ARRAY>		Array of additional parameters for the specified event
	Returns:
		(nothing)
-------------------------------------------------------------------------------------------------------------------- */

#include "config\macros.hpp"

// Fetch our params
params [
	["_event", "", [""]],
	["_args", []]
];

// Lower the case
_event = toLower _event;

// Exit if no event was specified
if (_event == "") exitWith {systemChat "No event specified!"};

// Check if the Zeus UIis open
disableSerialization;
private _eventExists = false;
private _return = nil;
private _zeusUI = findDisplay 312;
private _zeusUI_mainCtrlGrp = uiNamespace getVariable [MACRO_VARNAME_UI_MAINCTRLGRP, controlNull];
private _zeusUI_presetsCtrlGrp = uiNamespace getVariable [MACRO_VARNAME_UI_PRESETSCTRLGRP, controlNull];
if (_event != "ui_init" and {isNull _zeusUI_mainCtrlGrp}) exitWith {systemChat "Zeus UI isn't open!"};





// Perform the event
switch (_event) do {

	#include "events\ui_checkbox_changed.sqf"
	#include "events\ui_close.sqf"
	#include "events\ui_dragging_start.sqf"
	#include "events\ui_dragging.sqf"
	#include "events\ui_dragging_stop.sqf"
	#include "events\ui_init.sqf"
	#include "events\ui_select_category.sqf"
	#include "events\ui_select_preset.sqf"
	#include "events\ui_select_unit.sqf"
	#include "events\ui_slider_start.sqf"
	#include "events\ui_slider_move.sqf"
	#include "events\ui_slider_stop.sqf"
	#include "events\ui_spawn.sqf"
	#include "events\ui_textbox_changed.sqf"
	#include "events\ui_textbox_clear.sqf"
	#include "events\ui_toggle.sqf"
};





// DEBUG: Check if the event was recognised - if not, print a message
if (!_eventExists) then {
	private _str = format ["(%1) [ZEUS_UI] ERROR: Unknown event '%2' called!", time, _event];
	systemChat _str;
	hint _str;
};

// If we received a return value, return it
if (!isNil "_return") exitWith {
	_return;
};
