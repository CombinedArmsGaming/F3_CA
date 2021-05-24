// Clients only.
if (!hasInterface) exitWith {};


waitUntil
{
    // waituntil downed for the very first time, or dead 
    waitUntil { sleep 0.1; player getVariable ["ACE_isUnconscious", false] || player getvariable ["ca_playerisdeaddead",false] || (!alive player) };
    
    f_var_downtimeExperienceActive = true;

    _startedTime = time;
    // Want to change the downtime timer ? Change the 16 to however many seconds you wanna wait before entering spectate when unconcious, or 999 to disable downtime
    waitUntil { !(player getVariable ["ACE_isUnconscious", false] && (alive player)) or (time - _startedTime > CA2_Downtime_SpectatorWaitTime)};

    if ((player getVariable ["ACE_isUnconscious", false] && !CA2_Downtime_OptOut) || (player getvariable ["ca_playerisdeaddead",false]) || (!alive player)) then
    {
        
        [] spawn ca_fnc_downtimeSpectate;
    };    
    waitUntil {sleep 0.1;
    !( (player getVariable ["ACE_isUnconscious", true] && !CA2_Downtime_OptOut) || 
    (!alive player) ||
    (player getvariable ["ca_playerisdeaddead",true]))
    };

    f_var_downtimeExperienceActive = false;

    false

};
sleep 0.1; 
