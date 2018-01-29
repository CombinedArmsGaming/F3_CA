params ["_btnIDC", "_zeusDeployment"];

zeus_deployment = _zeusDeployment;

_onOff = "OFF";
_colour = [1, 1, 1, 1];

if (zeus_deployment) then 
{
	_onOff = "ON";
	_colour = [1, 0, 0, 1];
};
_btnText = format ["Zeus Deployment %1.", _onOff];


[_btnIDC, _btnText, _colour] call
{
	params ["_btnIDC", "_btnText", "_colour"];
	disableSerialization;
	
	_btn = (findDisplay 312) displayCtrl _btnIDC;
	
	_btn ctrlSetText _btnText;
	_btn ctrlSetTextColor _colour;

};