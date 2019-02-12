// Make sure the code is only run on the server
if (!isServer) exitWith {};

[] spawn {
//Get all the players currently in spectate
_specplayers = [] call ace_spectator_fnc_players;
// Move them to the marker or group

if (ca_respawnmode == 3) then {
//declare if everyone is dead or not
_alldead = true;
_leader = "";
{

if (leader group _x in _specplayers) then { _alldead = false; _leader = leader group _x} else {

        {if ( !(_x in _specplayers) ) exitWith {
                _alldead = false;
                _leader = _x;
        }} count group _x;

};

//If everyones dead then tp to respawn marker
if (_allDead) then {_x setPos (getmarkerpos ca_respawnmarker)} else {
_x setPos (getpos _leader);

};

} forEach _specplayers;


} else {
{
        _x setPos (getmarkerpos ca_respawnmarker);
} forEach _specplayers;
};

// Set variables so it cannot be spammed
missionNamespace setVariable ['ca_respawnwave',true, true];
missionNamespace setVariable ['ca_respawnready',false, true];
//Remove a wave
_number = ca_norespawnwaves;
missionNamespace setVariable ['ca_norespawnwaves',(_number - 1), true];
// Post message letting everyone know there is a wave on.
ca_respawnmsg remoteExec ["systemChat"];
//Let the wave last for 60 seconds just incase anyone dies etc.
_time = time;
missionNamespace setVariable ['ca_respawntime',_time, true]; // For the countdown on the respawn panel.
sleep ca_wavetime;
missionNamespace setVariable ['ca_respawnwave',false, true];
sleep ca_wavecooldown;
missionNamespace setVariable ['ca_respawnready',true, true];
};
