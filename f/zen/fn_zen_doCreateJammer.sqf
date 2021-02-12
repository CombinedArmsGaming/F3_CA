/*
Created By: Gibbs
*/
params ["_object", "_jammerType", "_jammerRange"];

switch(_jammerType) do
{
	case 0:
	{
		[_object, _jammerRange, _jammerRange, _jammerRange, _jammerRange, _jammerRange, _jammerRange] call kyk_ew_fnc_broadcastJammerAdd;
	};
	case 1:
	{
		[_object, _jammerRange, 0, 0, 0, 0, 0] call kyk_ew_fnc_broadcastJammerAdd;
	};
	case 2:
	{
		[_object, 0, _jammerRange, 0, 0, 0, 0] call kyk_ew_fnc_broadcastJammerAdd;
	};	
	case 3:
	{
		[_object, 0, 0, _jammerRange, 0, 0, 0] call kyk_ew_fnc_broadcastJammerAdd;
	};
	case 4:
	{
		[_object, 0, 0, 0, _jammerRange, 0, 0] call kyk_ew_fnc_broadcastJammerAdd;
	};	
	case 5:
	{
		[_object, 0, 0, 0, 0, _jammerRange, 0] call kyk_ew_fnc_broadcastJammerAdd;
	};
	case 6:
	{
		[_object, 0, 0, 0, 0, 0, _jammerRange] call kyk_ew_fnc_broadcastJammerAdd;
	};	
};
