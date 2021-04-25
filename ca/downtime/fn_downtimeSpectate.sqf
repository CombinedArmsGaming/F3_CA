// CA spectator controller
// Controls spectate, as well as messages about being unconcious vs. dead.
// This script is called from fn_downtimemonitor each time you go down. IE go down and wake up, then down again = this script is ran twice. Handles death as well. 

// First step setup local functions/code blocks to be called later
// When ghoast = Dead dead and waiting for ca_respawnwave
_whenGhost =
{
    player allowDamage false;
    player setVariable ["ace_medical_allowDamage", false];

    [player, "CA2_Downtime"] call ace_common_fnc_hideUnit;
    [player, "CA2_Downtime"] call ace_common_fnc_muteUnit;
   
    [] spawn
    {
        uiSleep 1;

        if (player getVariable ["ca_playerisdeaddead", false] and (alive player)) then
        {
            "CA2_CutDowntime" cutRsc ["CA2_DowntimeDead", "PLAIN", -1, false];
        };
         // Add Freecam 
    [[0,1],[0,1,2]] call ace_spectator_fnc_updateCameraModes;
    [CA2_Downtime_SpectatorVisionModes, [-1,0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes;

    };

};

// Alive = unconcious in ace 
_whenAlive =
{
    player allowDamage true;
    player setVariable ["ace_medical_allowDamage", true];

    [player, "CA2_Downtime"] call ace_common_fnc_unhideUnit;
    [player, "CA2_Downtime"] call ace_common_fnc_unmuteUnit;
    [] spawn
    {
        uiSleep 1;

        if (player getVariable ["ACE_isUnconscious", false] and (alive player)) then
        {
            "CA2_CutDowntime" cutRsc ["CA2_DowntimeUnconscious", "PLAIN", -1, false];
        };
    // Restrict camera modes
    [CA2_Downtime_SpectatorCameraModes,[0,1,2]] call ace_spectator_fnc_updateCameraModes;
    [CA2_Downtime_SpectatorVisionModes, [-1,0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes;

    };

}; 

// Functionally the same as whenalive, but for situations where you respawn/wake up from unconcious
_whenDone =
{
    player allowDamage true;
    player setVariable ["ace_medical_allowDamage", true];
    // Restrict camera modes
    [CA2_Downtime_SpectatorCameraModes,[0,1,2]] call ace_spectator_fnc_updateCameraModes;
    [CA2_Downtime_SpectatorVisionModes, [-1,0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes;
    [player, "CA2_Downtime"] call ace_common_fnc_unhideUnit;
    [player, "CA2_Downtime"] call ace_common_fnc_unmuteUnit;

    "CA2_CutDowntime" cutFadeOut 0;

};



// Exit if dead dead and instant respawn 
if !(f_var_downtimeExperienceActive) exitWith {};

// Can't move around in spectator while unconscious unless we do this...
["unconscious", false] call ace_common_fnc_setDisableUserInputStatus;

// Set spectate. Overrides ca_ondeath
[true, true, false] call ace_spectator_fnc_setSpectator;
//Create a handle to compare when situation has changed from down to dead dead in the waitunil 
_isGhost = (player getvariable ["ca_playerisdeaddead",false]) && (alive player);

// Call initial state, depending on whether you've caught the bullet with you teeth vs. cigarette case 
[] call (if (_isGhost) then {_whenGhost} else {_whenAlive});
// Spectate controller. Will exit when fn_downtimemonitor says so (with input from ca_ondeath re ca_playerisdeaddead)
waitUntil
{
    // Compare current state to _isghost variable, if so, change state 
    if ((player getvariable ["ca_playerisdeaddead",false] and alive player) != _isGhost) then
    {
        _isGhost = player getvariable ["ca_playerisdeaddead",false] && (!ca_respawnwave);
        [] call (if (_isGhost) then {_whenGhost} else {_whenAlive});
        
    };
    sleep 0.1;
    !f_var_downtimeExperienceActive
};

// Exit script, apply mortal status. 
[] call _whenDone;

[false, true, false] call ace_spectator_fnc_setSpectator;
