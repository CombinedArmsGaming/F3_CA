_camPos = screenToWorld [0.5, 0.5];

params ["_def"];

_type = _def select 0;

hint _type;


switch (_type) do
{

	case "inf":
	{
		_units = _def select 1;
		_gear = _def select 2;
		_side = _def select 3;
		
		[_units, _camPos, _gear, _side] remoteExec ["ca_fnc_spawnGroupForZeus", 2];
	};
	
	case "veh":
	{
		_units = _def select 1;
		_veh = _def select 2;
		_gear = _def select 3;
		_side = _def select 4;
		
		[_units, _camPos, _veh, _gear, _side] remoteExec ["ca_fnc_spawnVehicleGroupForZeus", 2];
	};

};
