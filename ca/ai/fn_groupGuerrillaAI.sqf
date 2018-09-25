#include "macros.hpp"

/*
========================================================================================================================================
        AUTHOR:
                Cre8or

========================================================================================================================================
        DESCRIPTION:
                Enables guerrilla AI behaviour on a group of units.

                NOTE: Group ownership will be transfered to the server, which will execute the guerrilla AI function on its end.
                This is to ensure that the scripts continue to work, even in the unlikely event that whichever machine called this
                function becomes unavailable (game crashed / player disconnected).
                For most intents and purposes, you should be using this function rather than ca_fnc_unitGuerrillaAI.

========================================================================================================================================
        ARGUMENTS:
                0:      (GROUP) Group of units           OR:             (OBJECT) Unit
                        REQUIRED

                        If a GROUP is passed, the script will iterate through the group's members and execute the guerrilla AI script
                        on each of them. This is the preferred method, as groups remain valid until the last member dies. Most suited
                        for use in triggers or from within scripts.
                        If an OBJECT is passed, the script will look at the unit to determine who else is in its group, before executing
                        the guerrilla AI script on each of them.
                ------------------------------------------------------------------------------------------------------------------------
                1:      (BOOL) Flank only
                        OPTIONAL - Default: false

                        A group of AI that is set to only flank will tend to break up into two teams when approaching a target, with one
                        team approaching from the left, and one from the right. With flanking disabled, the group will scatter evenly and
                        attempt to approach the target in a line formation.
                ------------------------------------------------------------------------------------------------------------------------
                2:      (NUMBER) Maximum approach variation
                        OPTIONAL - Default: 45

                        Maximum angle (in degrees) that the AI is willing to deviate from the direct Line-Of-Sight to the target. Higher
                        values mean units will approach from further away (useful for flanking), while lower numbers will make it
                        approach more directly (useful for rushing/chasing).
                        NOTE: Do not set this to more than 90, or the AI might orbit around the target, or even run away from it.
                ------------------------------------------------------------------------------------------------------------------------
                3:      (NUMBER) Minimum approach distance
                        OPTIONAL - Default: 50

                        Guerrilla units that are closer than this value (in meters) to their target will stop leaping forward, and instead
                        rush directly to their target.
                        Useful for urban environments, as the AI seems to have trouble pathfinding around buildings while flanking.
                ------------------------------------------------------------------------------------------------------------------------
                4:      (NUMBER) Maximum approach distance
                        OPTIONAL - Default: 1000

                        Guerrilla units won't chase or approach targets that are farther away than this distance (in meters).
                        Small numbers are useful for making AI follow waypoints longer, before breaking off to go after hostiles
                        (e.g. 100-200 meters). Large numbers (e.g. 1000-5000 meters) are useful for making AI chase down very distant
                        targets (such as snipers), provided the AI is aware of their presence.
                ------------------------------------------------------------------------------------------------------------------------
                5:      (NUMBER) Maximum search duration
                        OPTIONAL - Default: 30

                        Maximum duration (in seconds) that the AI will spend sweeping the last known location of a target before reporting
                        it as missing.
                        NOTE: If the target is still in the vicinity (but the AI can't see it) the AI will still be aware of its presence
                        and refuse to walk away, even if exceeding the maximum search duration. However, if the target manages to move out
                        of the AI's search area (see "minimum approach distance"), it will finally be reported as missing. The AI will then
                        stop searching and resume normal behaviour.
                ------------------------------------------------------------------------------------------------------------------------
                6:      (NUMBER) Search area size
                        OPTIONAL - Default: 30

                        Determines the size (in meters) of the area that the AI will search, upon arriving at a target's last known position.
                        NOTE: The search area is a square centered on the last known position, with a side length equal to twice this value.
                        As an example, 30 meters means the AI will search a 60m*60m large square (= 3600m²) centered on the target's
                        last known position.

========================================================================================================================================
        EXAMPLES:
                        [this] spawn ca_fnc_groupGuerrillaAI                            // inside a unit's init field in 3DEN,
                                                                                        // or inside a unit's execution field in Zeus
                        // Using the minimum amount of parameters, everything not specified will use default values
                ------------------------------------------------------------------------------------------------------------------------
                        [_group, true, 60] spawn ca_fnc_groupGuerrillaAI                // inside a script, where _group is a group
                        // The group will break into two fireteams which will approach from a wide angle (60°)
                ------------------------------------------------------------------------------------------------------------------------
                        [this, false, 0, 100, 99999] spawn ca_fnc_groupGuerrillaAI	// inside a unit's init field
                        // Makes a group chase down targets in a straight line, regardless of how far they are

========================================================================================================================================
*/





// Fetch the parameters
params [
        ["_group", grpNull, [objNull, grpNull]],
        ["_flankOnly", false, [false]],
        ["_maxApproachVariation", 45, [45]],
        ["_minApproachDistance", 50, [50]],
        ["_maxApproachDistance", 1000, [1000]],
        ["_maxSearchDuration", 30, [30]],
        ["_searchAreaSize", 30, [30]]
];





// Run the rest of the function is unscheduled environment
isNil {

        // If this function is being called by a client, offload to the server (to compensate for disconnecting/crashing/game-freezing players)
        if (!isServer) exitWith {

                // Only continue if this group isn't already being transfered
                if ((_group getVariable ["Cre8ive_LocalityStatus", 0]) == 0) then {
                        _group setVariable ["Cre8ive_LocalityStatus", 1, false];

                        // Workaround to preserve the units' loadout, due to "setGroupOwner" being bugged
                        {
                                _x setVariable ["Cre8ive_Loadout", getUnitLoadout _x, false];
                        } forEach units _group;

                        // Transfer the group ownership to the server, as some commands require locality
                        if (typeName _group == typeName objNull) then {
                                _group = group _group;  // (If the passed argument is a unit, get its group instead)
                        };
                        [_group, 2] remoteExec ["setGroupOwner", 2, false];

                        // Reapply the units' loadouts after locality changed
                        {
                                if ((_unit getVariable ["Cre8ive_LocalityStatus", 0]) == 0) then {
                                        _unit setVariable ["Cre8ive_LocalityStatus", 1, false];    // Awaiting locality transfer (prevent concurrent transfers from other scripts)

                                        // Detect locality changes
                                        _x addEventHandler ["Local", {
                                                params ["_unit", "_local"];

                                                if ((_unit getVariable ["Cre8ive_LocalityStatus", 0]) != 1) exitWith {};

                                                _unit setVariable ["Cre8ive_LocalityStatus", 2, false];    // Locality transfer completed
                                                _unit setUnitLoadout (_unit getVariable ["Cre8ive_Loadout", []]);
                                        }];
                                };

                        } forEach units _group;
                };

                // Let the server handle the rest
                _this remoteExec ["ca_fnc_groupGuerrillaAI", 2, false];
        };



        // The units are local, now we call the unitGuerrillaAI function on every member of the unit's group
        {
                [_x, _flankOnly, _maxApproachVariation, _minApproachDistance, _maxApproachDistance, _maxSearchDuration, _searchAreaSize] MACRO_SPAWN(ca_fnc_unitGuerrillaAI,"ca\ai\fn_unitGuerrillaAI.sqf");
        } forEach units _group;

        _group allowFleeing 0;
};
