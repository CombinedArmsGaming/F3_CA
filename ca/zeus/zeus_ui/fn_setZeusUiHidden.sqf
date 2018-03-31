//	Zeus extensions for CA, by Bubbus.
//	
//	Shows or hides the zeus ui based on the input variable.
//
//	PARAMETERS:
//	
//		_shouldHide
//			True if should hide, else false to show.
//			

params ["_shouldHide"];

_zeusUiCtrls = missionNamespace getVariable ["ca_zeus_ctrls", []];

_fadeTo = 0;
if (_shouldHide) then {_fadeTo = 1} else {_fadeTo = 0};

disableSerialization;

{
	if (ctrlIDC _x == ca_zeus_hideBtn_idc) then
	{
		_x ctrlSetFade (_fadeTo min 0.8);
	}
	else
	{
		_x ctrlSetFade _fadeTo;
	};
	
	_x ctrlCommit 0.1;
	
} forEach _zeusUiCtrls;