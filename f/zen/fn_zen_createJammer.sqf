/*
Created By: Gibbs
*/
params ["_object"];

if (isNull _object) then
{
	systemChat "No object selected.";
}
else
{
	["Create Jammer", 
	[
		["COMBO", "Jammer Type", [[0, 1, 2, 3, 4, 5, 6], ["All Types", "Radio", "Phones (ACE)", "Detonators (Clackers)", "Drones", "GPS", "Radar"], 0]],
		["SLIDER", "Jammer Range", [1, 30000, 2000, 0]]
	],
	{
		params ["_dialogValues", "_args"];
		_dialogValues params ["_jammerType", "_jammerRange"];
		_args params ["_object"];
		[_object, _jammerType, _jammerRange] remoteExec ["f_fnc_zen_doCreateJammer", 2];
	}, 
	{},
	[_object]] call zen_dialog_fnc_create;
};
