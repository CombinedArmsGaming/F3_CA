/*
========================================================================================================================================
        AUTHOR:
                Cre8or
========================================================================================================================================
        DESCRIPTION:
                Finds all members of a group and runs the unitGuerrillaAI function on each of them. All parameters are passed as-is to
                the unitGuerrillaAI function.
========================================================================================================================================
        ARGUMENTS:
                0:      (OBJECT) Unit
                        (GROUP) Group of AI units       [alternatively]
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

                        Whether or not the AI should only ever flank its target.
                        A group of AI that is set to only flank will frequently break up into two teams when approaching a target, with
                        one team approaching from the left, and one from the right. With flanking disabled, the group will scatter evenly
                        and attempt to approach as a line formation.
                ------------------------------------------------------------------------------------------------------------------------
                2:      (NUMBER) Maximum approach variation
                        Default: 45

                        Maximum angle (in degrees) that the AI is willing to deviate from the direct Line-Of-Sight to the target. Higher
                        values mean the AI will approach from further away (useful for flanking), while lower numbers will make it
                        approach more directly (useful for rushing/chasing).
                        NOTE: Do not set this to more than 90, or the AI will orbit around the target, or even run away from it.
                ------------------------------------------------------------------------------------------------------------------------
                3:      (NUMBER) Maximum search duration
                        Default: 30

                        Maximum duration (in seconds) that the AI will spend sweeping the last known location of a target before reporting
                        it as missing.
                        NOTE: If the target is still in the vicinity (but the AI can't see it) the AI will know about its presence, and
                        will not give up searching for it unless it manages to sneak away.
                ------------------------------------------------------------------------------------------------------------------------
                4:      (NUMBER) Maximum approach distance
                        Default: 1000

                        Guerrila units won't chase or approach targets that are farther away than this distance. Useful for making units
                        follow waypoints further before breaking off to go after hostiles (100 or 200 meters). Also useful for makin
                        units chase down snipers that are a few kilometers away (provided the AI is aware of the sniper), by setting the
                        distance to a really large number (like 5000 meters)
========================================================================================================================================
        EXAMPLES:
                        [this] spawn ca_fnc_groupGuerrillaAI                            // inside a unit's init field
                ------------------------------------------------------------------------------------------------------------------------
                        [_group, true, 60] spawn ca_fnc_groupGuerrillaAI                // inside a script, where _group is a group
                        // NOTE: this method is suited for use in EDEN or from scripts
                ------------------------------------------------------------------------------------------------------------------------
                        [this, true, 20] spawn ca_fnc_groupGuerrillaAI                  // inside a unit's execution field in Zeus
                        // NOTE: this method is suited for use in Zeus
========================================================================================================================================
*/





// Fetch the paramters
params [["_unit", objNull, [objNull, grpNull]], ["_flankOnly", false, [false]], ["_maxApproachVariation", 45, [45]], ["_maxApproachDistance", 1000, [1000]], ["_maxSearchDuration", 30, [30]]];





// Call the unitGuerrillaAI function on every member of the unit's group
{
        [_x, _flankOnly, _maxApproachVariation, _maxApproachDistance, _maxSearchDuration] spawn ca_fnc_unitGuerrillaAI;
} forEach units _unit;
