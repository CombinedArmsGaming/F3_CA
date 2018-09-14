//	Zeus extensions for CA, by Bubbus.
//	
//	Updates the state of a global var and updates the appearance of a button based upon it.
//  Intended for boolean vars.
//
//	PARAMETERS:
//	
//		_btnIDC
//			The control ID for the on-screen zeus deployment button.
//			
//		_globalVar
//			The global variable to update.
//
//		_desiredVal
//			The value to set _globalVar to.
//
//		_formatString
//			Text to apply to the button.  Supports one format argument which will be set to "ON" or "OFF" based on _desiredVal.
//

params ["_btnIDC", "_globalVar", "_desiredVal", "_formatString"];

currentNamespace setVariable [_globalVar, _desiredVal];

_onOff = "OFF";
_colour = [1, 1, 1, 1];

if (_desiredVal) then 
{
	_onOff = "ON";
	_colour = [1, 0, 0, 1];
};
_btnText = format [_formatString, _onOff];


[_btnIDC, _btnText, _colour] call
{
	params ["_btnIDC", "_btnText", "_colour"];
	disableSerialization;
	
	_btn = (findDisplay 312) displayCtrl _btnIDC;
	
	_btn ctrlSetText _btnText;
	_btn ctrlSetTextColor _colour;

};