params ["_position"];
private "_pos";
_pos = [];
switch (typename _position) do {
	case "STRING": {_pos = getMarkerPos _position};
	case "OBJECT": {_pos = getPosATL _position};
	case "GROUP": {_pos = getPosATL (leader _position)};
	case "LOCATION": {_pos = position _position};
	case "ARRAY": {_pos = _position;};
};


_pos
