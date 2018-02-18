// Loop that disables thermal view on everything

[] spawn {
	while {true} do
	{
		{
			if ( !( _x getVariable ["TIEquipmentDisabled", false] ) )	then {
				_x setVariable ["TIEquipmentDisabled", true];
				_x disableTIEquipment true;
			};
		} forEach vehicles;
		sleep 5;
	};
};