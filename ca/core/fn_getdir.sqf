params ["_direction"];
private "_dir";
_dir = 0;
switch (typename _direction) do {
	case "STRING": {_dir = markerDir _direction};
	case "OBJECT": {_dir = getDir _direction};
	case "GROUP": {_dir = getDir (leader _direction)};
	case "LOCATION": {_dir = direction _direction};
	case "ARRAY": {_dir = 0};
	case "SCALAR": {_dir = _direction};
};


_dir
