// Initialisation
case "ui_init": {
	_eventExists = true;

	// Determine which UI to initialise
	// 0: Main UI
	// 1: Presets UI
	private _menuID = _args param [0, MACRO_VARNAME_UI_ID_MAIN];

	// Create a function to simplify creating controls
	private _createCtrl = {
		params ["_class", "_idc", "_x", "_y", "_w", "_h", ["_ctrlGrp", controlNull]];
		private _ctrl = controlNull;
		private _additionalCtrls = [];

		switch (toLower _class) do {
			case "controlsgroup": {
				_ctrl = _zeusUI ctrlCreate ["RscControlsGroupNoScrollbars", _idc];
				//_ctrl ctrlSetPixelPrecision 2;
			};
			case "box": {
				_ctrl = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedBox", _idc, _ctrlGrp];
				_ctrl ctrlSetBackgroundColor (_this select 7);
				//_ctrl ctrlSetPixelPrecision 2;
			};
			case "frame": {
				_ctrl = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedFrame", _idc, _ctrlGrp];
				_ctrl ctrlSetBackgroundColor (_this select 7);
				//_ctrl ctrlSetPixelPrecision 2;
			};
			case "outline": {
				_ctrl = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedOutline", _idc, _ctrlGrp];
				_ctrl ctrlSetTextColor (_this select 7);
				//_ctrl ctrlSetPixelPrecision 2;
			};
			case "listbox": {
				_ctrl = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedListBox", _idc, _ctrlGrp];
				//_ctrl ctrlSetPixelPrecision 2;
			};
			case "text": {
				_ctrl = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedText", _idc, _ctrlGrp];
				_ctrl ctrlSetText (_this select 7);
				_ctrl ctrlSetTextColor SQUARE(MACRO_COLOUR_WHITE_TEXT);
			};
			case "button": {
				private _suffix = "";
				if (_this param [8, ""] != "") then {
					_suffix = format ["_%1", _this select 8];
				};

				_ctrl = _zeusUI ctrlCreate [format ["CA_ZeusUI_ScriptedButton%1", _suffix], _idc, _ctrlGrp];
				_ctrl ctrlSetText (_this select 7);
			};
			case "checkbox": {
				private _colour = _this param [7, []];
				if !(_colour isEqualTo []) then {
					private _ctrlBackground = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedBox", -1, _ctrlGrp];
					_ctrlBackground ctrlSetBackgroundColor _colour;
					//_ctrlBackground ctrlSetPixelPrecision 2;
					_ctrlBackground ctrlSetPosition [_x, _y, _w, _h];
					_ctrlBackground ctrlCommit 0;
					_additionalCtrls pushBack _ctrlBackground;
				};

				_ctrl = _zeusUI ctrlCreate ["RscCheckBox", _idc, _ctrlGrp];
				//_ctrl ctrlSetPixelPrecision 2;
			};
			case "slider": {
				private _ctrlBackground = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedBox", -1, _ctrlGrp];
				_ctrlBackground ctrlSetBackgroundColor SQUARE(MACRO_COLOUR_BACKGROUND);
				//_ctrlBackground ctrlSetPixelPrecision 2;
				_ctrlBackground ctrlSetPosition [_x, _y, _w, _h];
				_ctrlBackground ctrlCommit 0;

				private _ctrlFill = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedBox", -1, _ctrlGrp];
				_ctrlFill ctrlSetBackgroundColor SQUARE(MACRO_COLOUR_WHITE_SLIDER);
				//_ctrlFill ctrlSetPixelPrecision 2;
				_ctrlFill ctrlSetPosition [_x, _y, _w / 2, _h];
				_ctrlFill ctrlCommit 0;

				private _ctrlOutline = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedOutline", -1, _ctrlGrp];
				_ctrlOutline ctrlSetTextColor SQUARE(MACRO_COLOUR_WHITE_OPAQUE);
				//_ctrlOutline ctrlSetPixelPrecision 2;
				_ctrlOutline ctrlSetPosition [_x, _y, _w, _h];
				_ctrlOutline ctrlCommit 0;

				_additionalCtrls = [_ctrlBackground, _ctrlFill, _ctrlOutline];

				_ctrl = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedFrame", _idc, _ctrlGrp];
				_ctrl ctrlSetBackgroundColor [0,0,0,0];
				//_ctrl ctrlSetPixelPrecision 2;
				_ctrl setVariable [MACRO_VARNAME_UI_SLIDER_MAXSIZE, _w];
				_ctrl setVariable [MACRO_VARNAME_UI_SLIDER_CTRLFILL, _ctrlFill];
			};
			case "textbox": {
				_ctrl = _zeusUI ctrlCreate ["CA_ZeusUI_ScriptedTextBox", _idc, _ctrlGrp];
				_ctrl ctrlSetBackgroundColor SQUARE(MACRO_COLOUR_BACKGROUND);
				//_ctrl ctrlSetPixelPrecision 2;
			};
		};

		// If the new control is a child of a controls group, add it to its child controls list
		if (!isNull _ctrlGrp) then {
			private _childControls = _ctrlGrp getVariable [MACRO_VARNAME_UI_CHILDCONTROLS, []];
			_childControls append _additionalCtrls;
			_childControls pushBack _ctrl;
			_ctrlGrp setVariable [MACRO_VARNAME_UI_CHILDCONTROLS, _childControls];
		};

		// Position and scale the control
		_ctrl ctrlSetPosition [_x, _y, _w, _h];
		_ctrl ctrlCommit 0;

		// Return the new control
		_ctrl;
	};


	private _setupNumericalSetting = {
		params ["_ctrlSlider", "_ctrlTextBox", "_valueMin", "_valueMax"];

		// Link the slider and the textbox to eachother
		_ctrlSlider setVariable [MACRO_VARNAME_UI_SLIDER_CTRLTEXTBOX, _ctrlTextBox];
		_ctrlTextBox setVariable [MACRO_VARNAME_UI_SLIDER_CTRLSLIDER, _ctrlSlider];

		// Save the min and max values onto the slider
		_ctrlSlider setVariable [MACRO_VARNAME_UI_SETTING_MIN, _valueMin];
		_ctrlSlider setVariable [MACRO_VARNAME_UI_SETTING_MAX, _valueMax];

		// Add the slider event handlers
		_ctrlSlider ctrlAddEventHandler ["MouseButtonDown", {["ui_slider_start", _this] call ca_fnc_zeusUI}];
		_ctrlSlider ctrlAddEventHandler ["MouseMoving", {["ui_slider_move", _this] call ca_fnc_zeusUI}];
		_ctrlSlider ctrlAddEventHandler ["MouseButtonUp", {["ui_slider_stop", _this] call ca_fnc_zeusUI}];

		// Add the textbox event handlers
		_ctrlTextBox ctrlAddEventHandler ["KeyDown", {["ui_textbox_changed", _this] call ca_fnc_zeusUI}];
		_ctrlTextBox ctrlAddEventHandler ["MouseButtonDown", {["ui_textbox_clear", _this] call ca_fnc_zeusUI}];
	};





	// Select the UI to initialise
	switch (_menuID) do {

		// Main UI
		case MACRO_VARNAME_UI_ID_MAIN: {

			// Create the controls
				private _posX_def = safeZoneX + safeZoneW * 0.25;
				private _posY_def = safeZoneY + safeZoneH * (1 - MACRO_POS_MAIN_HEIGHT - 0.01);
				private _mainWidth = safeZoneW * MACRO_POS_MAIN_WIDTH;
				private _mainHeight = safeZoneH * MACRO_POS_MAIN_HEIGHT;

				// Fetch the last main control group position from the profile namespace
				(profileNamespace getVariable [MACRO_VARNAME_UI_POS_MAINCTRLGRP, [_posX_def, _posY_def]]) params ["_posX", "_posY"];

				// Failsafe: if the player's screen resolution changed, ensure that the UI is still within the new borders
				if (
					_posX < safeZoneX
					or {_posX + _mainWidth >= safeZoneX + safeZoneW}
					or {_posY < safeZoneY}
					or {_posY + _mainHeight >= safeZoneY + safeZoneH}
				) then {
					_posX = _posX_def;
					_posY = _posY_def;

					profileNamespace setVariable [MACRO_VARNAME_UI_POS_MAINCTRLGRP, [_posX, _posY]];
					saveProfileNamespace;
				};

				// Main Control Group
				_zeusUI_mainCtrlGrp = [
					"ControlsGroup",
					MACRO_IDC_MAIN_CTRLGRP,
					_posX,
					_posY,
					_mainWidth,
					_mainHeight
				] call _createCtrl;

				uiNamespace setVariable [MACRO_VARNAME_UI_MAINCTRLGRP, _zeusUI_mainCtrlGrp];

				// Dragging frame
				private _ctrlDraggingFrame = [
					"Frame",
					MACRO_IDC_MAIN_DRAGGING_FRAME,
					0,
					0,
					safeZoneW * MACRO_POS_MAIN_WIDTH,
					safeZoneH * MACRO_POS_MAIN_GAP_DRAGGING_Y,
					_zeusUI_mainCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;
				_ctrlDraggingFrame ctrlAddEventHandler ["MouseButtonDown", {["ui_dragging_start", _this] call ca_fnc_zeusUI}];

				// Background
				[
					"Box",
					-1,
					0,
					0,
					safeZoneW * MACRO_POS_MAIN_WIDTH,
					safeZoneH * MACRO_POS_MAIN_HEIGHT,
					_zeusUI_mainCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;

				// Background Outline
				[
					"Outline",
					-1,
					0,
					0,
					safeZoneW * MACRO_POS_MAIN_WIDTH,
					safeZoneH * MACRO_POS_MAIN_HEIGHT,
					_zeusUI_mainCtrlGrp,
					SQUARE(MACRO_COLOUR_WHITE_OPAQUE)
				] call _createCtrl;

				// Categories Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y),
					safeZoneW * (MACRO_POS_MAIN_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_TEXT_HEIGHT,
					_zeusUI_mainCtrlGrp,
					"Select a category:"
				] call _createCtrl;

				// Categories ListBox
				private _ctrlLBCategories = [
					"ListBox",
					MACRO_IDC_MAIN_CATEGORIES_LISTBOX,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_TEXT_HEIGHT + MACRO_POS_GAP_Y),
					safeZoneW * (MACRO_POS_MAIN_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_LISTBOX_HEIGHT,
					_zeusUI_mainCtrlGrp
				] call _createCtrl;
				_ctrlLBCategories ctrlAddEventHandler ["LBSelChanged", {["ui_select_category", _this] call ca_fnc_zeusUI}];

				// Units Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_TEXT_HEIGHT + MACRO_POS_LISTBOX_HEIGHT + MACRO_POS_GAP_Y + MACRO_POS_MAIN_GAP_TEXT_Y),
					safeZoneW * (MACRO_POS_MAIN_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_TEXT_HEIGHT,
					_zeusUI_mainCtrlGrp,
					"Select the unit(s) to spawn:"
				] call _createCtrl;

				// Units ListBox
				private _ctrlLBUnits = [
					"ListBox",
					MACRO_IDC_MAIN_UNITS_LISTBOX,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_TEXT_HEIGHT * 2 + MACRO_POS_LISTBOX_HEIGHT + MACRO_POS_GAP_Y + MACRO_POS_MAIN_GAP_TEXT_Y),
					safeZoneW * (MACRO_POS_MAIN_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_LISTBOX_HEIGHT,
					_zeusUI_mainCtrlGrp
				] call _createCtrl;
				_ctrlLBUnits ctrlAddEventHandler ["LBSelChanged", {["ui_select_unit", _this] call ca_fnc_zeusUI}];

				// Presets Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_TEXT_HEIGHT * 2 + MACRO_POS_LISTBOX_HEIGHT * 2 + MACRO_POS_GAP_Y + MACRO_POS_MAIN_GAP_TEXT_Y * 2),
					safeZoneW * (MACRO_POS_MAIN_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_TEXT_HEIGHT,
					_zeusUI_mainCtrlGrp,
					"Select the AI preset to use:"
				] call _createCtrl;

				// Presets ListBox
				private _ctrlLBPresets = [
					"ListBox",
					MACRO_IDC_MAIN_PRESETS_LISTBOX,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_TEXT_HEIGHT * 3 + MACRO_POS_LISTBOX_HEIGHT * 2 + MACRO_POS_GAP_Y + MACRO_POS_MAIN_GAP_TEXT_Y * 2),
					safeZoneW * (MACRO_POS_MAIN_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_LISTBOX_HEIGHT,
					_zeusUI_mainCtrlGrp
				] call _createCtrl;

				// Spawn Button
				private _ctrlButtonSpawn = [
					"Button",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_HEIGHT - MACRO_POS_GAP_Y - 0.04),
					safeZoneW * (MACRO_POS_MAIN_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * 0.04,
					_zeusUI_mainCtrlGrp,
					"SPAWN"
				] call _createCtrl;
				_ctrlButtonSpawn ctrlAddEventHandler ["ButtonClick", {["ui_spawn", _this] call ca_fnc_zeusUI}];


			// Fetch our listbox indexes
			private _categoryIndex = missionNamespace getVariable [MACRO_VARNAME_UI_CATEGORYINDEX, 0];
			private _unitIndex = missionNamespace getVariable [MACRO_VARNAME_UI_UNITINDEX, 0];
			private _presetIndex = missionNamespace getVariable [MACRO_VARNAME_UI_PRESETINDEX, 1];

			// Fetch the categories namespace
			private _allCategoriesNamespace = missionNamespace getVariable [MACRO_VARNAME_NAMESPACE_CATEGORIES, locationNull];

			// Add all the category names to the listbox
			{
				_ctrlLBCategories lbAdd _x;
			} forEach (_allCategoriesNamespace getVariable [MACRO_VARNAME_NAMESPACE_ALLVARIABLES, []]);

			// Reselect the previously selected category
			if (_categoryIndex >= 0) then {
				private _unitIndexOld = _unitIndex;
				_ctrlLBCategories lbSetCurSel _categoryIndex;

				// If we also had a unit selected, select that one too
				if (_unitIndexOld >= 0) then {
					_ctrlLBUnits lbSetCurSel _unitIndexOld;
				};
			};

			// Fetch the presets namespace
			private _allPresetsNamespace = missionNamespace getVariable [MACRO_VARNAME_NAMESPACE_PRESETS, locationNull];

			// Add the manual preset option
			_ctrlLBPresets lbAdd "Custom...";

			// Add all the category names to the listbox
			{
				_ctrlLBPresets lbAdd format ["*  %1", _x];
			} forEach (_allPresetsNamespace getVariable [MACRO_VARNAME_NAMESPACE_ALLVARIABLES, []]);

			// If the custom preset was selected, reselect it now (before we re-add the EH)
			if (_presetIndex == 0) then {
				_ctrlLBPresets lbSetCurSel _presetIndex;
			};

			// Add the presets listbox EH *after* we selected the previous entry
			_ctrlLBPresets ctrlAddEventHandler ["LBSelChanged", {["ui_select_preset", _this] call ca_fnc_zeusUI}];

			// If we had a preset (other than the custom one) selected, reselect it
			if (_presetIndex > 0) then {
				_ctrlLBPresets lbSetCurSel _presetIndex;
			};

			// If the presets menu was previously opened, reopen it
			if (missionNamespace getVariable [MACRO_VARNAME_UI_PRESETS_ISSHOWN, false]) then {
				["ui_init", [MACRO_VARNAME_UI_ID_PRESETS]] call ca_fnc_zeusUI;
			};


			// Sync the UI visiblity to the Zeus interface
			removeMissionEventHandler ["Draw3D", missionNamespace getVariable [MACRO_VARNAME_UI_DRAW3D_EH, -1]];
			missionNamespace setVariable [MACRO_VARNAME_UI_DRAW3D_EH, addMissionEventHandler ["Draw3D", {
				private _watermark = (findDisplay 312) displayCtrl 15717;

				if (!isNull _watermark) then {
					["ui_toggle", [!ctrlShown _watermark]] call ca_fnc_zeusUI;
				};
			}]];
		};





		// Presets UI
		case MACRO_VARNAME_UI_ID_PRESETS: {

			// Mark the presets menu as being shown
			missionNamespace setVariable [MACRO_VARNAME_UI_PRESETS_ISSHOWN, true];

			// Fetch the main UI's position
			(ctrlPosition _zeusUI_mainCtrlGrp) params ["_posX", "_posY"];

			// Determine the height of the presets window in advance
			// NOTE: When modifying the presets menu, you need to recalculate this value so it fits all settings!
			private _posHeight = MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 3 + MACRO_POS_GAP_Y * 14 + MACRO_POS_PRESETS_SETTING_HEIGHT * 14;

			// Add some buffer to the total height
			_posHeight = _posHeight + MACRO_POS_GAP_Y;

			// Determine the position of the presets control group based on the main control group's position
			if (_posX + safeZoneW * (MACRO_POS_MAIN_WIDTH / 2) > 0.5) then {
				_posX = _posX - safeZoneW * MACRO_POS_PRESETS_WIDTH;
			} else {
				_posX = _posX + safeZoneW * MACRO_POS_MAIN_WIDTH;
			};
			if (_posY + safeZoneH * (MACRO_POS_MAIN_HEIGHT / 2) > 0.5) then {
				_posY = _posY + safeZoneH * (MACRO_POS_MAIN_HEIGHT - _posHeight);
			};


			// If the presets menu isn't open yet, create it
			if (isNull _zeusUI_presetsCtrlGrp) then {

				// Presets Control Group
				_zeusUI_presetsCtrlGrp = [
					"ControlsGroup",
					MACRO_IDC_MAIN_CTRLGRP,
					_posX,
					_posY,
					safeZoneW * MACRO_POS_PRESETS_WIDTH,
					safeZoneH * _posHeight
				] call _createCtrl;
				uiNamespace setVariable [MACRO_VARNAME_UI_PRESETSCTRLGRP, _zeusUI_presetsCtrlGrp];

				// Background
				[
					"Box",
					-1,
					0,
					0,
					safeZoneW * MACRO_POS_PRESETS_WIDTH,
					safeZoneH * _posHeight,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;

				// Background Outline
				[
					"Outline",
					-1,
					0,
					0,
					safeZoneW * MACRO_POS_PRESETS_WIDTH,
					safeZoneH * _posHeight,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_WHITE_OPAQUE)
				] call _createCtrl;

				// Close Button
				private _ctrlButtonExit = [
					"Button",
					-1,
					0,
					0,
					safeZoneW * 0.03,
					safeZoneH * MACRO_POS_MAIN_GAP_DRAGGING_Y,
					_zeusUI_presetsCtrlGrp,
					"CLOSE",
					"Red"
				] call _createCtrl;
				_ctrlButtonExit ctrlAddEventHandler ["ButtonClick", {["ui_close"] spawn ca_fnc_zeusUI}];	// SPAWN! Not call! Otherwise the game will crash! (gg BI)

				// Dummy Control (used to reset the focus)
				[
					"Frame",
					MACRO_IDC_PRESETS_DUMMYCTRL,
					0,
					0,
					0,
					0,
					_zeusUI_presetsCtrlGrp,
					[0,0,0,0]
				] call _createCtrl;


				// -----------------------------------------------------------------------------------------------------------------------------
				// Guerrilla AI - Settings Cover
				private _ctrlBox_GAI_settingsCover = [
					"Box",
					MACRO_IDC_PRESETS_GAI_SETTINGS_COVER,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * (MACRO_POS_GAP_Y * 7 + MACRO_POS_PRESETS_SETTING_HEIGHT * 7),
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_RED_DIM)
				] call _createCtrl;

				// Guerrilla AI - Checkbox Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"Enable Guerrilla AI:"
				] call _createCtrl;

				// Guerrilla AI - Checkbox
				private _ctrlCB_GAI = [
					"CheckBox",
					MACRO_IDC_PRESETS_GAI_CHECKBOX,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_CHECKBOX_WIDTH - MACRO_POS_GAP_X),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y),
					safeZoneW * MACRO_POS_CHECKBOX_WIDTH,
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Guerrilla AI - Flank Only Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 2 + MACRO_POS_PRESETS_SETTING_HEIGHT),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 3 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Flank only:"
				] call _createCtrl;

				// Guerrilla AI - Flank Only Checkbox
				private _ctrlCB_GAI_flankOnly = [
					"CheckBox",
					MACRO_IDC_PRESETS_GAI_FLANKONLY_CHECKBOX,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_CHECKBOX_WIDTH - MACRO_POS_GAP_X),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 2 + MACRO_POS_PRESETS_SETTING_HEIGHT),
					safeZoneW * MACRO_POS_CHECKBOX_WIDTH,
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Guerrilla AI - Maximum Approach Variation Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 3 + MACRO_POS_PRESETS_SETTING_HEIGHT * 2),
					safeZoneW * (MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Max approach variation:"
				] call _createCtrl;

				// Guerrilla AI - Maximum Approach Variation Slider
				private _ctrlSlider_GAI_maxApproachVariation = [
					"Slider",
					MACRO_IDC_PRESETS_GAI_MAXAPPROACHVARIATION_SLIDER,
					safeZoneW * MACRO_POS_PRESETS_INDENT_SLIDER_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 3 + MACRO_POS_PRESETS_SETTING_HEIGHT * 2),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 2 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// Guerrilla AI - Maximum Approach Variation Textbox
				private _ctrlTextBox_GAI_maxApproachVariation = [
					"TextBox",
					MACRO_IDC_PRESETS_GAI_MAXAPPROACHVARIATION_TEXT,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 3 + MACRO_POS_PRESETS_SETTING_HEIGHT * 2),
					safeZoneW * MACRO_POS_TEXTBOX_WIDTH,
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Guerrilla AI - Minimum Approach Distance Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 4 + MACRO_POS_PRESETS_SETTING_HEIGHT * 3),
					safeZoneW * (MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Min approach distance:"
				] call _createCtrl;

				// Guerrilla AI - Minimum Approach Distance Slider
				private _ctrlSlider_GAI_minApproachDistance = [
					"Slider",
					MACRO_IDC_PRESETS_GAI_MINAPPROACHDISTANCE_SLIDER,
					safeZoneW * MACRO_POS_PRESETS_INDENT_SLIDER_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 4 + MACRO_POS_PRESETS_SETTING_HEIGHT * 3),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 2 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// Guerrilla AI - Minimum Approach Distance TextBox
				private _ctrlTextBox_GAI_minApproachDistance = [
					"TextBox",
					MACRO_IDC_PRESETS_GAI_MINAPPROACHDISTANCE_TEXT,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 4 + MACRO_POS_PRESETS_SETTING_HEIGHT * 3),
					safeZoneW * MACRO_POS_TEXTBOX_WIDTH,
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Guerrilla AI - Maximum Approach Distance Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 5 + MACRO_POS_PRESETS_SETTING_HEIGHT * 4),
					safeZoneW * (MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Max approach distance:"
				] call _createCtrl;

				// Guerrilla AI - Maximum Approach Distance Slider
				private _ctrlSlider_GAI_maxApproachDistance = [
					"Slider",
					MACRO_IDC_PRESETS_GAI_MAXAPPROACHDISTANCE_SLIDER,
					safeZoneW * MACRO_POS_PRESETS_INDENT_SLIDER_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 5 + MACRO_POS_PRESETS_SETTING_HEIGHT * 4),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 2 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// Guerrilla AI - Maximum Approach Distance TextBox
				private _ctrlTextBox_GAI_maxApproachDistance = [
					"TextBox",
					MACRO_IDC_PRESETS_GAI_MAXAPPROACHDISTANCE_TEXT,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 5 + MACRO_POS_PRESETS_SETTING_HEIGHT * 4),
					safeZoneW * MACRO_POS_TEXTBOX_WIDTH,
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Guerrilla AI - Maximum Search Duration Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 6 + MACRO_POS_PRESETS_SETTING_HEIGHT * 5),
					safeZoneW * (MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Max search duration:"
				] call _createCtrl;

				// Guerrilla AI - Maximum Search Duration Slider
				private _ctrlSlider_GAI_maxSearchDuration = [
					"Slider",
					MACRO_IDC_PRESETS_GAI_MAXSEARCHDURATION_SLIDER,
					safeZoneW * MACRO_POS_PRESETS_INDENT_SLIDER_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 6 + MACRO_POS_PRESETS_SETTING_HEIGHT * 5),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 2 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// Guerrilla AI - Maximum Search Duration TextBox
				private _ctrlTextBox_GAI_maxSearchDuration = [
					"TextBox",
					MACRO_IDC_PRESETS_GAI_MAXSEARCHDURATION_TEXT,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 6 + MACRO_POS_PRESETS_SETTING_HEIGHT * 5),
					safeZoneW * MACRO_POS_TEXTBOX_WIDTH,
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Guerrilla AI - Search Area Size Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 7 + MACRO_POS_PRESETS_SETTING_HEIGHT * 6),
					safeZoneW * (MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Search area size:"
				] call _createCtrl;

				// Guerrilla AI - Search Area Size Slider
				private _ctrlSlider_GAI_searchAreaSize = [
					"Slider",
					MACRO_IDC_PRESETS_GAI_SEARCHAREASIZE_SLIDER,
					safeZoneW * MACRO_POS_PRESETS_INDENT_SLIDER_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 7 + MACRO_POS_PRESETS_SETTING_HEIGHT * 6),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 2 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// Guerrilla AI - Search Area Size TextBox
				private _ctrlTextBox_GAI_searchAreaSize = [
					"TextBox",
					MACRO_IDC_PRESETS_GAI_SEARCHAREASIZE_TEXT,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_GAP_Y * 7 + MACRO_POS_PRESETS_SETTING_HEIGHT * 6),
					safeZoneW * MACRO_POS_TEXTBOX_WIDTH,
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;


				// -----------------------------------------------------------------------------------------------------------------------------
				// Suppressive AI - Settings Cover
				private _ctrlBox_SAI_settingsCover = [
					"Box",
					MACRO_IDC_PRESETS_SAI_SETTINGS_COVER,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 7 + MACRO_POS_PRESETS_SETTING_HEIGHT * 7),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * (MACRO_POS_GAP_Y * 4 + MACRO_POS_PRESETS_SETTING_HEIGHT * 4),
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_RED_DIM)
				] call _createCtrl;

				// Suppressive AI - Checkbox Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 7 + MACRO_POS_PRESETS_SETTING_HEIGHT * 7),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"Enable Suppressive AI:"
				] call _createCtrl;

				// Suppressive AI - Checkbox
				private _ctrlCB_SAI = [
					"CheckBox",
					MACRO_IDC_PRESETS_SAI_CHECKBOX,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_CHECKBOX_WIDTH - MACRO_POS_GAP_X),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 7 + MACRO_POS_PRESETS_SETTING_HEIGHT * 7),
					safeZoneW * MACRO_POS_CHECKBOX_WIDTH,
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Suppressive AI - Suppression Multiplier Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 8 + MACRO_POS_PRESETS_SETTING_HEIGHT * 8),
					safeZoneW * (MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Suppression mul:"
				] call _createCtrl;

				// Suppressive AI - Suppression Multiplier Slider
				private _ctrlSlider_SAI_suppressionMul = [
					"Slider",
					MACRO_IDC_PRESETS_SAI_SUPPRESSIONMUL_SLIDER,
					safeZoneW * MACRO_POS_PRESETS_INDENT_SLIDER_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 8 + MACRO_POS_PRESETS_SETTING_HEIGHT * 8),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 2 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// Suppressive AI - Suppression Multiplier TextBox
				private _ctrlTextBox_SAI_suppressionMul = [
					"TextBox",
					MACRO_IDC_PRESETS_SAI_SUPPRESSIONMUL_TEXT,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 8 + MACRO_POS_PRESETS_SETTING_HEIGHT * 8),
					safeZoneW * MACRO_POS_TEXTBOX_WIDTH,
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Suppressive AI - Suppression Duration Multiplier Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 9 + MACRO_POS_PRESETS_SETTING_HEIGHT * 9),
					safeZoneW * (MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Suppression duration mul:"
				] call _createCtrl;

				// Suppressive AI - Suppression Duration Multiplier Slider
				private _ctrlSlider_SAI_suppressionDurationMul = [
					"Slider",
					MACRO_IDC_PRESETS_SAI_SUPPRESSIONDURATIONMUL_SLIDER,
					safeZoneW * MACRO_POS_PRESETS_INDENT_SLIDER_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 9 + MACRO_POS_PRESETS_SETTING_HEIGHT * 9),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 2 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// Suppressive AI - Suppression Duration Multiplier TextBox
				private _ctrlTextBox_SAI_suppressionDurationMul = [
					"TextBox",
					MACRO_IDC_PRESETS_SAI_SUPPRESSIONDURATIONMUL_TEXT,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 9 + MACRO_POS_PRESETS_SETTING_HEIGHT * 9),
					safeZoneW * MACRO_POS_TEXTBOX_WIDTH,
					safeZoneH * MACRO_POS_PRESETS_SETTING_HEIGHT,
					_zeusUI_presetsCtrlGrp
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Suppressive AI - Use Anims Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 10 + MACRO_POS_PRESETS_SETTING_HEIGHT * 10),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 3 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Use animations:"
				] call _createCtrl;

				// Suppressive AI - Use Anims Checkbox
				private _ctrlCB_SAI_useAnims = [
					"CheckBox",
					MACRO_IDC_PRESETS_SAI_USEANIMS_CHECKBOX,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_CHECKBOX_WIDTH - MACRO_POS_GAP_X),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y + MACRO_POS_GAP_Y * 10 + MACRO_POS_PRESETS_SETTING_HEIGHT * 10),
					safeZoneW * MACRO_POS_CHECKBOX_WIDTH,
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;


				// -----------------------------------------------------------------------------------------------------------------------------
				// Lambs AI - Settings Cover
				private _ctrlBox_LambsAI_settingsCover = [
					"Box",
					MACRO_IDC_PRESETS_LAMBS_SETTINGS_COVER,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 2 + MACRO_POS_GAP_Y * 11 + MACRO_POS_PRESETS_SETTING_HEIGHT * 11),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * (MACRO_POS_GAP_Y * 2 + MACRO_POS_PRESETS_SETTING_HEIGHT * 2),
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_RED_DIM)
				] call _createCtrl;

				// Lambs AI - Checkbox Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 2 + MACRO_POS_GAP_Y * 11 + MACRO_POS_PRESETS_SETTING_HEIGHT * 11),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"Enable Lambs AI:"
				] call _createCtrl;

				// Lambs AI - Checkbox
				private _ctrlCB_LambsAI = [
					"CheckBox",
					MACRO_IDC_PRESETS_LAMBS_CHECKBOX,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_CHECKBOX_WIDTH - MACRO_POS_GAP_X),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 2 + MACRO_POS_GAP_Y * 11 + MACRO_POS_PRESETS_SETTING_HEIGHT * 11),
					safeZoneW * MACRO_POS_CHECKBOX_WIDTH,
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;

				// -----------------------------------------------------------------------------------------------------------------------------
				// Lambs AI - Reinforce Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 2 + MACRO_POS_GAP_Y * 12 + MACRO_POS_PRESETS_SETTING_HEIGHT * 12),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_PRESETS_INDENT_SLIDER_X - MACRO_POS_GAP_X * 3 - MACRO_POS_TEXTBOX_WIDTH),
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"*  Enable reinforce:"
				] call _createCtrl;

				// Lambs AI - Reinforce Checkbox
				private _ctrlCB_LambsAI_reinforce = [
					"CheckBox",
					MACRO_IDC_PRESETS_LAMBS_REINFORCE_CHECKBOX,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_CHECKBOX_WIDTH - MACRO_POS_GAP_X),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 2 + MACRO_POS_GAP_Y * 12 + MACRO_POS_PRESETS_SETTING_HEIGHT * 12),
					safeZoneW * MACRO_POS_CHECKBOX_WIDTH,
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;


				// -----------------------------------------------------------------------------------------------------------------------------
				// VCOM - Settings Cover
				private _ctrlBox_VCOM_settingsCover = [
					"Box",
					MACRO_IDC_PRESETS_VCOM_SETTINGS_COVER,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 3 + MACRO_POS_GAP_Y * 13 + MACRO_POS_PRESETS_SETTING_HEIGHT * 13),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * (MACRO_POS_GAP_Y + MACRO_POS_PRESETS_SETTING_HEIGHT),
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_RED_DIM)
				] call _createCtrl;

				// VCOM Checkbox Text
				[
					"Text",
					-1,
					safeZoneW * MACRO_POS_GAP_X,
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 3 + MACRO_POS_GAP_Y * 13 + MACRO_POS_PRESETS_SETTING_HEIGHT * 13),
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_GAP_X * 2),
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					"Enable VCOM:"
				] call _createCtrl;

				// VCOM Checkbox
				private _ctrlCB_VCOM = [
					"CheckBox",
					MACRO_IDC_PRESETS_VCOM_CHECKBOX,
					safeZoneW * (MACRO_POS_PRESETS_WIDTH - MACRO_POS_CHECKBOX_WIDTH - MACRO_POS_GAP_X),
					safeZoneH * (MACRO_POS_MAIN_GAP_DRAGGING_Y + MACRO_POS_PRESETS_SETTING_GAP_Y * 3 + MACRO_POS_GAP_Y * 13 + MACRO_POS_PRESETS_SETTING_HEIGHT * 13),
					safeZoneW * MACRO_POS_CHECKBOX_WIDTH,
					safeZoneH * MACRO_POS_CHECKBOX_HEIGHT,
					_zeusUI_presetsCtrlGrp,
					SQUARE(MACRO_COLOUR_BACKGROUND)
				] call _createCtrl;



				// -----------------------------------------------------------------------------------------------------------------------------


				// Set up the numerical settings
				{
					_x call _setupNumericalSetting;
				} forEach [
				//		FORMAT:
				//	[slider control,	textbox control,	min value,	max value]
					[_ctrlSlider_GAI_maxApproachVariation,		_ctrlTextBox_GAI_maxApproachVariation,		0,	90],
					[_ctrlSlider_GAI_maxApproachDistance,		_ctrlTextBox_GAI_maxApproachDistance,		0,	1000],
					[_ctrlSlider_GAI_minApproachDistance,		_ctrlTextBox_GAI_minApproachDistance,		0,	100],
					[_ctrlSlider_GAI_maxSearchDuration,		_ctrlTextBox_GAI_maxSearchDuration,		5,	120],
					[_ctrlSlider_GAI_searchAreaSize,		_ctrlTextBox_GAI_searchAreaSize,		5,	50],
					[_ctrlSlider_SAI_suppressionMul,		_ctrlTextBox_SAI_suppressionMul,		0,	3],
					[_ctrlSlider_SAI_suppressionDurationMul,	_ctrlTextBox_SAI_suppressionDurationMul,	0,	3]
				];


				// Add the checkbox event handlers
				{
					_x ctrlAddEventHandler ["CheckedChanged", {["ui_checkbox_changed", _this] call ca_fnc_zeusUI}];
				} forEach [
					_ctrlCB_GAI,
					_ctrlCB_GAI_flankOnly,
					_ctrlCB_SAI,
					_ctrlCB_SAI_useAnims,
					_ctrlCB_LambsAI,
					_ctrlCB_LambsAI_reinforce,
					_ctrlCB_VCOM
				];

				// Load the previous settings
				["ui_checkbox_changed", [_ctrlCB_GAI,			missionNamespace getVariable [MACRO_VARNAME_PRESET_GAI, false]]] call ca_fnc_zeusUI;
				["ui_checkbox_changed", [_ctrlCB_GAI_flankOnly,		missionNamespace getVariable [MACRO_VARNAME_PRESET_GAI_FLANKONLY, false]]] call ca_fnc_zeusUI;
				["ui_checkbox_changed", [_ctrlCB_SAI,			missionNamespace getVariable [MACRO_VARNAME_PRESET_SAI, false]]] call ca_fnc_zeusUI;
				["ui_checkbox_changed", [_ctrlCB_SAI_useAnims,		missionNamespace getVariable [MACRO_VARNAME_PRESET_SAI_USEANIMS, false]]] call ca_fnc_zeusUI;
				["ui_checkbox_changed", [_ctrlCB_LambsAI,		missionNamespace getVariable [MACRO_VARNAME_PRESET_LAMBS, false]]] call ca_fnc_zeusUI;
				["ui_checkbox_changed", [_ctrlCB_LambsAI_reinforce,	missionNamespace getVariable [MACRO_VARNAME_PRESET_LAMBS_REINFORCE, false]]] call ca_fnc_zeusUI;
				["ui_checkbox_changed", [_ctrlCB_VCOM,			missionNamespace getVariable [MACRO_VARNAME_PRESET_VCOM, false]]] call ca_fnc_zeusUI;

				["ui_textbox_changed", [_ctrlTextBox_GAI_maxApproachVariation, nil, nil, nil, nil,	missionNamespace getVariable [MACRO_VARNAME_PRESET_GAI_MAXAPPROACHVARIATION, 45]]] call ca_fnc_zeusUI;
				["ui_textbox_changed", [_ctrlTextBox_GAI_minApproachDistance, nil, nil, nil, nil,	missionNamespace getVariable [MACRO_VARNAME_PRESET_GAI_MINAPPROACHDISTANCE, 50]]] call ca_fnc_zeusUI;
				["ui_textbox_changed", [_ctrlTextBox_GAI_maxApproachDistance, nil, nil, nil, nil,	missionNamespace getVariable [MACRO_VARNAME_PRESET_GAI_MAXAPPROACHDISTANCE, 1000]]] call ca_fnc_zeusUI;
				["ui_textbox_changed", [_ctrlTextBox_GAI_maxSearchDuration, nil, nil, nil, nil,		missionNamespace getVariable [MACRO_VARNAME_PRESET_GAI_MAXSEARCHDURATION, 30]]] call ca_fnc_zeusUI;
				["ui_textbox_changed", [_ctrlTextBox_GAI_searchAreaSize, nil, nil, nil, nil,		missionNamespace getVariable [MACRO_VARNAME_PRESET_GAI_SEARCHAREASIZE, 30]]] call ca_fnc_zeusUI;
				["ui_textbox_changed", [_ctrlTextBox_SAI_suppressionMul, nil, nil, nil, nil,		missionNamespace getVariable [MACRO_VARNAME_PRESET_SAI_SUPPRESSIONMUL, 1]]] call ca_fnc_zeusUI;
				["ui_textbox_changed", [_ctrlTextBox_SAI_suppressionDurationMul, nil, nil, nil, nil,	missionNamespace getVariable [MACRO_VARNAME_PRESET_SAI_SUPPRESSIONDURATIONMUL, 1]]] call ca_fnc_zeusUI;

			// Otherwise, just reposition it
			} else {
				private _pos = ctrlPosition _zeusUI_presetsCtrlGrp;
				_pos set [0, _posX];
				_pos set [1, _posY];
				_zeusUI_presetsCtrlGrp ctrlSetPosition _pos;
				_zeusUI_presetsCtrlGrp ctrlCommit 0;
			};
		};
	};
};
