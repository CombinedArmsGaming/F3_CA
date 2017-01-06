if !(player == headless) exitwith {};

while {true} do {
_count = {local _x} count allUnits;

missionNamespace setVariable ["hcount",_count, true];
sleep 10;
};
