// A slider is moving
case "ui_slider_move": {
	_eventExists = true;

	// Fetch our params
	_args params ["_ctrl", "_posX", "", "", ["_isDirectValue", false], ["_manualInput", false]];

	// Only continue if the mouse is moving over this slider
	if (_manualInput or {_ctrl == _zeusUI getVariable [MACRO_VARNAME_UI_ACTIVESLIDER, controlNull]}) then {

		// Fetch the slider's fill control
		private _ctrlFill = _ctrl getVariable [MACRO_VARNAME_UI_SLIDER_CTRLFILL, controlNull];

		// Fetch the control's position
		private _pos = ctrlPosition _ctrlFill;

		// Fetch the slider's max size
		private _maxSize = _ctrl getVariable [MACRO_VARNAME_UI_SLIDER_MAXSIZE, 1];

		// Fetch this control's min and max value
		private _valueMin = _ctrl getVariable [MACRO_VARNAME_UI_SETTING_MIN, 0];
		private _valueMax = _ctrl getVariable [MACRO_VARNAME_UI_SETTING_MAX, 1];

		// If we were given a direct value (0 to 1), clamp it and scale it with the maxSize
		private _value = _posX;
		if (_isDirectValue) then {
			_value = (_value - _valueMin) / (_valueMax - _valueMin);
			_pos set [2, ((_value max 0) min 1) * _maxSize];

		// Otherwise, determine the value from the position coordinate
		} else {
			_value = ((_posX - (_pos param [0, 0])) max 0) min _maxSize;
			_pos set [2, _value];

			_value = (_value / _maxSize) * (_valueMax - _valueMin) + _valueMin;
		};

		// Change the matching textbox's value accordingly
		if (!_manualInput) then {

			// Save the new value
			switch (ctrlIDC _ctrl) do {
				case MACRO_IDC_PRESETS_GAI_MAXAPPROACHVARIATION_SLIDER: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MAXAPPROACHVARIATION, _value, false];
				};
				case MACRO_IDC_PRESETS_GAI_MINAPPROACHDISTANCE_SLIDER: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MINAPPROACHDISTANCE, _value, false];
				};
				case MACRO_IDC_PRESETS_GAI_MAXAPPROACHDISTANCE_SLIDER: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MAXAPPROACHDISTANCE, _value, false];
				};
				case MACRO_IDC_PRESETS_GAI_MAXSEARCHDURATION_SLIDER: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_MAXSEARCHDURATION, _value, false];
				};
				case MACRO_IDC_PRESETS_GAI_SEARCHAREASIZE_SLIDER: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_GAI_SEARCHAREASIZE, _value, false];
				};
				case MACRO_IDC_PRESETS_SAI_SUPPRESSIONMUL_SLIDER: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_SAI_SUPPRESSIONMUL, _value, false];
				};
				case MACRO_IDC_PRESETS_SAI_SUPPRESSIONDURATIONMUL_SLIDER: {
					missionNamespace setVariable [MACRO_VARNAME_PRESET_SAI_SUPPRESSIONDURATIONMUL, _value, false];
				};
			};

			// Fetch the matching slider
			private _ctrlTextBox = _ctrl getVariable [MACRO_VARNAME_UI_SLIDER_CTRLTEXTBOX, controlNull];

			["ui_textbox_changed", [_ctrlTextBox, nil, nil, nil, nil, _value, true]] call ca_fnc_zeusUI;
		};

		// Move the fill control
		_ctrlFill ctrlSetPosition _pos;
		_ctrlFill ctrlCommit 0;
	};
};
