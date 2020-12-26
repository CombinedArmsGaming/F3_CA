

// Should only run for players.

// MAKE SURE THE PLAYER INITIALIZES PROPERLY
waitUntil
{
	uiSleep 1;
	!isNull player
};

[] spawn ca_fnc_downtimeMonitor;
[] spawn ca_fnc_blockSelfInteractWhileUnconscious;
