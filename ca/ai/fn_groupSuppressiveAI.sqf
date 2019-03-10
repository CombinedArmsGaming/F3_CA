#include "macros.hpp"

/*
========================================================================================================================================
        AUTHOR:
                Cre8or

========================================================================================================================================
        DESCRIPTION:
                Enables suppressive AI behaviour on a group of units.

                NOTE: Group ownership will be transfered to the server, which will execute the suppressive AI function on its end.
                This is to ensure that the scripts continue to work, even in the unlikely event that whichever machine called this
                function becomes unavailable (game crashed / player disconnected).
                For most intents and purposes, you should be using this function rather than ca_fnc_unitSuppressiveAI.

========================================================================================================================================
        ARGUMENTS:
                0:      (GROUP) Group of units           OR:             (OBJECT) Unit
                        REQUIRED

                        If a GROUP is passed, the script will iterate through the group's members and execute the suppressive AI script
                        on each of them. This is the preferred method, as groups remain valid until the last member dies. Most suited
                        for use in triggers or from within scripts.
                        If an OBJECT is passed, the script will look at the unit to determine who else is in its group, before executing
                        the suppressive AI script on each of them.
                ------------------------------------------------------------------------------------------------------------------------
                1:      (NUMBER) Suppression Multiplier
                        OPTIONAL - Default: 1

                        A multiplier to increase or decrease the amount of suppressive fire the unit will lay down on targets. This
                        value primarily affects suppression on covering targets, with higher (or lower) numbers making the unit suppress
                        more (or less), respectively.
                ------------------------------------------------------------------------------------------------------------------------
                2:      (NUMBER) Suppression Duration Multiplier
                        OPTIONAL - Default: 1

                        A multiplier to increase or decrease the duration that the AI will  suppress hidden targets for (30 seconds, by
                        default). Higher numbers increase that duration, lower numbers decrease it.
                ------------------------------------------------------------------------------------------------------------------------
                3:      (BOOL) Use Animations
                        OPTIONAL - Default: false

                        If enabled, the unit will use tactical movement animations when suppressing, allowing it to move while
			firing at its target. Best used in combination with Guerrilla AI.
			This is disabled by default because the AI will sometimes warp through (or into) objects/buildings/vehicles
			while playing the animations.

========================================================================================================================================
        EXAMPLES:
                        [this] spawn ca_fnc_groupSuppressiveAI				// inside a unit's init field in 3DEN,
                                                                                        // or inside a unit's execution field in Zeus
                        // Using the minimum amount of parameters, everything not specified will use default values
                ------------------------------------------------------------------------------------------------------------------------
                        [_group, 10, 2] spawn ca_fnc_groupSuppressiveAI               // inside a script, where _group is a group
                        // Intense suppression with long duration (useful for base defense, or just covering elements)

========================================================================================================================================
*/





// Fetch the parameters
params [
        ["_group", grpNull, [objNull, grpNull]],
        ["_suppressionMul", 1, [1]],
        ["_suppressionDelayMul", 1, [1]],
        ["_useAnims", false, [false]]
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
                                if ((_x getVariable ["Cre8ive_LocalityStatus", 0]) == 0) then {
                                        _x setVariable ["Cre8ive_LocalityStatus", 1, false];    // Awaiting locality transfer (prevent concurrent transfers from other scripts)

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
                _this remoteExec ["ca_fnc_groupSuppressiveAI", 2, false];
        };



        // The units are local, now we call the unitSuppressiveAI function on every member of the unit's group
        {
                [_x, _suppressionMul, _suppressionDelayMul, _useAnims] MACRO_SPAWN(ca_fnc_unitSuppressiveAI,"ca\ai\fn_unitSuppressiveAI.sqf");
        } forEach units _group;
};
