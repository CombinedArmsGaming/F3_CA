/*
========================================================================================================================================
        AUTHOR:
                Cre8or

========================================================================================================================================
        DESCRIPTION:
                Enables guerrilla AI behaviour on a group of units.

                NOTE: Group ownership will be transfered to the server, which will also run the guerrilla function on its end.
                This is to ensure that the guerrilla AI continues to function, even in the event that whichever machine called this
                function is no longer connected (game crashed / player disconnected).
                For most intents and purposes, you should be using this function rather than ca_fnc_unitGuerrillaAI.

========================================================================================================================================
        ARGUMENTS:
                0:      (GROUP) Group of units           OR:             (OBJECT) Unit
                        Default: N/A

                        If a GROUP is passed, the script will iterate through the group's members and execute the guerrilla AI script
                        on each of them. This is the preferred method, as groups remain valid until the last member dies. Most suited
                        for use in triggers or from within scripts.
                        If an OBJECT is passed, the script will look at the unit to determine who else is in its group, before executing
                        the guerrilla AI script on each of them. This method should only be used in Zeus, as you can use the exact same
                        parameters as with "ca_fnc_unitGuerrillaAI". However, refrain from using this method in triggers or in scripts,
                        as it may not work if the unit is dead, or no longer valid (if it was deleted).
                ------------------------------------------------------------------------------------------------------------------------
                1:      (BOOL) Flank only
                        Default: false

                        A group of AI that is set to only flank will tend to break up into two teams when approaching a target, with one
                        team approaching from the left, and one from the right. With flanking disabled, the group will scatter evenly and
                        attempt to approach the target in a line formation.
                ------------------------------------------------------------------------------------------------------------------------
                2:      (NUMBER) Maximum approach variation
                        Default: 45

                        Maximum angle (in degrees) that the AI is willing to deviate from the direct Line-Of-Sight to the target. Higher
                        values mean the AI will approach from further away (useful for flanking), while lower numbers will make it
                        approach more directly (useful for rushing/chasing).
                        NOTE: Do not set this to more than 90, or the AI might orbit around the target, or even run away from it.
                ------------------------------------------------------------------------------------------------------------------------
                3:      (NUMBER) Minimum approach distance
                        Default: 50

                        Guerrilla units that are closer than this value (in meters) to their target will stop leaping forward, and instead
                        rush directly to their target.
                        Useful for urban environments, as the AI seems to have trouble pathfinding around buildings while flanking.
                ------------------------------------------------------------------------------------------------------------------------
                4:      (NUMBER) Maximum approach distance
                        Default: 1000

                        Guerrilla units won't chase or approach targets that are farther away than this distance (in meters).
                        Small numbers are useful for making AI follow waypoints longer, before breaking off to go after hostiles
                        (e.g. 100-200 meters). Large numbers (e.g. 1000-5000 meters) are useful for making AI chase down very distant
                        targets (such as snipers), provided the AI is aware of their presence.
                ------------------------------------------------------------------------------------------------------------------------
                5:      (NUMBER) Maximum search duration
                        Default: 30

                        Maximum duration (in seconds) that the AI will spend sweeping the last known location of a target before reporting
                        it as missing.
                        NOTE: If the target is still in the vicinity (but the AI can't see it) the AI will still be aware of its presence
                        and refuse to walk away, even if exceeding the maximum search duration. However, if the target manages to move out
                        stop searching and resume normal behaviour.
                ------------------------------------------------------------------------------------------------------------------------
                6:      (NUMBER) Search area size
                        Default: 30

                        Determines the size (in meters) of the area that the AI will search, upon arriving at a target's last known position.
                        NOTE: The search area is a square centered on the last known position, with a side length equal to twice this value.
                        As an example, 30 meters means the AI will search a 60m*60m large square (= 3600m²) centered on the target's
                        last known position.

========================================================================================================================================
        EXAMPLES:
                        [this] spawn ca_fnc_groupGuerrillaAI                            // inside a unit group's init field in 3DEN
                ------------------------------------------------------------------------------------------------------------------------
                        [_group, true, 60] spawn ca_fnc_groupGuerrillaAI                // inside a script, where _group is a group
                        // NOTE: this method is suited for use in EDEN or from scripts
                ------------------------------------------------------------------------------------------------------------------------
                        [this, true, 20] spawn ca_fnc_groupGuerrillaAI                  // inside a unit's execution field in Zeus
                        // NOTE: this method is suited for use in Zeus
                ------------------------------------------------------------------------------------------------------------------------
                        [this, false, 0, 100, 5000] spawn ca_fnc_groupGuerrillaAI        // inside a unit's init field
                                                                                        // example preset for a group of chasing AI

========================================================================================================================================
*/





// Fetch the paramters
params [
        ["_unit", objNull, [objNull, grpNull]],
        ["_flankOnly", false, [false]],
        ["_maxApproachVariation", 45, [45]],
        ["_minApproachDistance", 50, [50]],
        ["_maxApproachDistance", 1000, [1000]],
        ["_maxSearchDuration", 30, [30]],
        ["_searchAreaSize", 30, [30]]
];





// If this function is being called by a client, offload to the server (to compensate for disconnecting/crashing/game-freezing players)
if (!isServer) exitWith {
        _this remoteExec ["ca_fnc_groupGuerrillaAI", 2, false];

        // Workaround to preserve the units' loadout, due to "setGroupOwner" being bugged
        {
                _x setVariable ["Cre8ive_GuerrillaAI_Loadout", getUnitLoadout _x, false];
        } forEach units _unit;

        // Transfer the group ownership to the server, as some commands require locality
        private _group = _unit;
        if (typeName _unit == typeName objNull) then {
                _group = group _unit;
        };
        [_group, 2] remoteExec ["setGroupOwner", 2, false];
        _group allowFleeing 0;

        // Reapply the units' loadouts after locality changed
        {
                _x addEventHandler ["Local", {
                        params ["_unit", "_local"];

                        if (_unit getVariable ["Cre8ive_GuerrillaAI_LocalityChanged", false]) exitWith {};

                        _unit setVariable ["Cre8ive_GuerrillaAI_LocalityChanged", true, false];
                        _unit setUnitLoadout (_unit getVariable ["Cre8ive_GuerrillaAI_Loadout", []]);
                }];

        } forEach units _unit;
};

// Call the unitGuerrillaAI function on every member of the unit's group
{
        [_x, _flankOnly, _maxApproachVariation, _minApproachDistance, _maxApproachDistance, _maxSearchDuration, _searchAreaSize] spawn ca_fnc_unitGuerrillaAI;
        //[_x, _flankOnly, _maxApproachVariation, _minApproachDistance, _maxApproachDistance, _maxSearchDuration, _searchAreaSize] execVM "ca\ai\fn_unitGuerrillaAI.sqf";
} forEach units _unit;
