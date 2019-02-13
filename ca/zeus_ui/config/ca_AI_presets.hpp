/*
---------------------------- GUERRILLA AI -------------------------------------------------------------------------------------
AVAILABLE OPTIONS:
	flankOnly				(NUMBER)	Values: 0 or 1			Default: 0
	maxApproachVariation			(NUMBER)	Values: 0 ... 180		Default: 45
	minApproachDistance			(NUMBER)	Values: 0 ... infinite		Default: 50
	maxApproachDistance			(NUMBER)	Values: 0 ... infinite		Default: 1000
	maxSearchDuration			(NUMBER)	Values: 0 ... infinite		Default: 30
	searchAreaSize				(NUMBER)	Values: 0 ... infinite		Default: 30

---------------------------- SUPPRESSIVE AI -----------------------------------------------------------------------------------
AVAILABLE OPTIONS:
	suppressionMultiplier			(NUMBER)	Values: 0 ... infinite		Default: 1
	suppressionDurationMultiplier		(NUMBER)	Values: 0 ... infinite		Default: 1
	useAnimations				(NUMBER)	Values: 0 or 1			Default: 0
*/





// Start editing below here
// ---------------------------------------------------------------------------------------------------------------------------------------

class CA_ZeusUI_AI_Presets
{

	// Preset definition
	class Vanilla
	{
		presetName = "Vanilla A3";		// The name of the preset that will be visible in the Zeus UI.
		enableVCOM = 0;				// 1 means VCOM will be enabled on spawned units, 0 means it will be disabled
	};

	class gAI_sAI_VCOM_DefaultsOnly
	{
		presetName = "gAI + sAI + VCOM (with default values)";
		enableVCOM = 1;

		class GuerrillaAI			// If this class is present, guerrilla AI will be enabled. Without any further settings, the script will use the default values (see further below).
		{					// Alternatively (if there were any settings here), you can comment out/remove individual settings to apply default values for them specifically.
		};					// As an example, if you wanted to only modify the search area size, you wouldn't need to add any other settings in here - merely the one you want to modify.

		class SuppressiveAI			// If this class is present, suppressive AI will be enabled. Same rules as above.
		{
		};
	};

	class Assault
	{
		presetName = "Element - Assault";
		enableVCOM = 1;					// Enable VCOM

		class GuerrillaAI
		{
			flankOnly = 1;				// The units wil only move up on the two flanks, rather than spreading evenly across the frontline.
			maxApproachVariation = 30;		// Approach in a 30° cone towards the enemy. With flanking enabled, this results in two main directions of attack, at 30° of the direct LOS each.
		};

		class SuppressiveAI
		{
			suppressionMultiplier = 0.5;		// Suppress half as much as usual
			suppressionDurationMultiplier = 0.5;	// Suppress half as long as usual to encourage the AI to keep moving.
		};
	};

	class CoveringFire
	{
		presetName = "Element - Covering Fire";
		enableVCOM = 1;					// Enable VCOM

		// No guerrilla AI, because we don't want units with this preset to move - they should only stay in one position and lay down suppressive fire.

		class SuppressiveAI
		{
			suppressionMultiplier = 0.5;		// Suppress half as much as usual (lowers the amount of suppressive fire that the AI sends out).
			suppressionDurationMultiplier = 3;	// Suppress three times longer than usual at concealed targets before automatically ceasing fire.
		};
	};
};
