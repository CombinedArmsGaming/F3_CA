// A textbox was modified
case "ui_textbox_changed": {
	_eventExists = true;

	// Fetch our params
	_args params ["_ctrl", ["_key", 0], "", "", "", ["_input", ""], ["_manualInput", false]];

	// If the enter key was pressed, reset the focus
	if (_key == 28) then {

		// Set the focus onto the dummy control
		ctrlSetFocus (_zeusUI_presetsCtrlGrp controlsGroupCtrl MACRO_IDC_PRESETS_DUMMYCTRL);

	// Otherwise, process the input
	} else {

		// If the input isn't a string, make it one
		if !(_input isEqualType "") then {
			_input = str _input;
		};

		// If the input is null, use the control's text instead
		if (_input == "") then {
			_input = ctrlText _ctrl;
		};

		// Set the text
		_ctrl ctrlSetText _input;

		// Change the matching slider's value accordingly
		if (!_manualInput) then {

			private _inputNum = parseNumber _input;

			// Save the new value
			switch (ctrlIDC _ctrl) do {
				case MACRO_IDC_PRESETS_GAI_MAXAPPROACHVARIATION_TEXT: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MAXAPPROACHVARIATION, _inputNum, false];
				};
				case MACRO_IDC_PRESETS_GAI_MINAPPROACHDISTANCE_TEXT: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MINAPPROACHDISTANCE, _inputNum, false];
				};
				case MACRO_IDC_PRESETS_GAI_MAXAPPROACHDISTANCE_TEXT: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MAXAPPROACHDISTANCE, _inputNum, false];
				};
				case MACRO_IDC_PRESETS_GAI_MAXSEARCHDURATION_TEXT: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MAXSEARCHDURATION, _inputNum, false];
				};
				case MACRO_IDC_PRESETS_GAI_SEARCHAREASIZE_TEXT: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_SEARCHAREASIZE, _inputNum, false];
				};
				case MACRO_IDC_PRESETS_SAI_SUPPRESSIONMUL_TEXT: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_SAI_SUPPRESSIONMUL, _inputNum, false];
				};
				case MACRO_IDC_PRESETS_SAI_SUPPRESSIONDURATIONMUL_TEXT: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_SAI_SUPPRESSIONDURATIONMUL, _inputNum, false];
				};
			};

			// Update the matching slider
			private _ctrlSlider = _ctrl getVariable [MACRO_VARNAME_UI_SLIDER_CTRLSLIDER, controlNull];
			["ui_slider_move", [_ctrlSlider, _inputNum, nil, nil, true, true]] call ca_fnc_zeusUI;
		};
	};
};
