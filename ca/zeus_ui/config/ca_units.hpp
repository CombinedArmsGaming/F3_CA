




// Start editing below here
// ---------------------------------------------------------------------------------------------------------------------------------------

class CA_ZeusUI_Units
{

	// Category definition
	class NATO_Infantry
	{
		categoryName = "NATO Infantry";			// This is the name of the category which you will see in-game.
		gear = "blu_f";					// This is the faction code as used in the F3 framework. Here, "blu_f", means the gear will be taken from the BLUFOR gearscript (aka NATO).
		side = "west";					// "west" means the units will bear allegiance to the western side (aka NATO). Available options are: "west", "east", "resistance" and "civilian".

		// Units definition
		class Rifleman
		{
			unitName = "NATO Rifleman";		// This is the name of the squad which will be shown in-game.
			units[] = {"rif"};			// This is the squad which will spawn - this just spawns one rifleman.
		};

		class Fireteam_6x
		{
			unitName = "NATO Fireteam 6x";
			units[] = {"ftl", "ar", "aar", "lat", "rif", "rif"};	// This spawns a full 6-man fireteam. You can have as many or as few units in a squad as you want.
		};

		class MAT_Team
		{
			unitName = "NATO MAT Team";
			units[] = {"mat", "amat"};
		};

		class MMG_Team
		{
			unitName = "NATO MMG Team";
			units[] = {"mmg", "ammg"};
		};
	};

	class NATO_Vehicles
	{
		categoryName = "NATO Vehicles";
		gear = "blu_f";
		side = "west";

		class M2A4_Slammer_UP
		{
			unitName = "M2A4 Slammer UP";		// This is the name of the vehicle which will be shown in-game.
			vehicle = "B_MBT_01_TUSK_F";		// This is the classname of the vehicle. You can get it by right-clicking a vehicle in 3DEN and selecting "Log > Log classes to clipboard"
			units[] = {"vc", "vd", "vg"};		// This is the crew of the vehicle.  The first unit in the list is always the commander.
		};

		class AMV7_Marshall		// Classnames can't contain '-'
		{
			unitName = "AMV-7 Marshall";
			vehicle = "B_APC_Wheeled_01_cannon_F";
			units[] = {"vc", "vd", "vg"};
		};

		class IFV6C_Panther
		{
			unitName = "IFV-6C Panther";
			vehicle = "B_APC_Tracked_01_rcws_F";
			units[] = {"vc", "vd", "vg"};
		};

		class Hunter_HMG
		{
			unitName = "Hunter HMG";
			vehicle = "B_MRAP_01_HMG_F";
			units[] = {"vc", "vd", "vg"};
		};
	};

	class CSAT_Infantry
	{
		categoryName = "CSAT Infantry";
		gear = "opf_f";
		side = "east";

		// Units definition
		class Rifleman
		{
			unitName = "CSAT Rifleman";
			units[] = {"rif"};
		};

		class Fireteam_6x
		{
			unitName = "CSAT Fireteam 6x";
			units[] = {"ftl", "ar", "aar", "lat", "rif", "rif"};
		};

		class MAT_Team
		{
			unitName = "CSAT MAT Team";
			units[] = {"amat", "mat"};
		};

		class MMG_Team
		{
			unitName = "CSAT MMG Team";
			units[] = {"mgag", "ammg"};
		};
	};

	class CSAT_Vehicles
	{
		categoryName = "CSAT Vehicles";
		gear = "opf_f";
		side = "east";

		class T100_Varsuk		// Classnames can't contain '-'
		{
			unitName = "T-100 Varsuk";
			vehicle = "O_MBT_02_cannon_F";
			units[] = {"vc", "vd", "vg"};
		};

		class MSE3_Marid
		{
			unitName = "MSE-3 Marid";
			vehicle = "O_APC_Wheeled_02_rcws_F";
			units[] = {"vc", "vd", "vg"};
		};

		class BTRK_Kamysh
		{
			unitName = "BTR-K Kamysh";
			vehicle = "O_APC_Tracked_02_cannon_F";
			units[] = {"vc", "vd", "vg"};
		};

		class Ifrit_HMG
		{
			unitName = "Ifrit HMG";
			vehicle = "O_MRAP_02_HMG_F";
			units[] = {"vc", "vd", "vg"};
		};
	};

	class AAF_Infantry
	{
		categoryName = "AAF Infantry";
		gear = "ind_f";
		side = "resistance";

		// Units definition
		class Rifleman
		{
			unitName = "AAF Rifleman";
			units[] = {"rif"};
		};

		class Fireteam_6x
		{
			unitName = "AAF Fireteam 6x";
			units[] = {"ftl", "ar", "aar", "lat", "rif", "rif"};
		};

		class MAT_Team
		{
			unitName = "AAF MAT Team";
			units[] = {"mat", "amat"};
		};

		class MMG_Team
		{
			unitName = "AAF MMG Team";
			units[] = {"ammg", "mmg"};
		};
	};

	class AAF_Vehicles
	{
		categoryName = "AAF Vehicles";
		gear = "ind_f";
		side = "resistance";

		class MBT52_Kuma		// Classnames can't contain '-'
		{
			unitName = "MBT-52 Kuma";
			vehicle = "I_MBT_03_cannon_F";
			units[] = {"vc", "vd", "vg"};
		};

		class AFV4_Gorgon
		{
			unitName = "AFV-4 Gorgon";
			vehicle = "I_APC_Wheeled_03_cannon_F";
			units[] = {"vc", "vd", "vg"};
		};

		class FV720_Mora
		{
			unitName = "FV-720 Mora";
			vehicle = "I_APC_tracked_03_cannon_F";
			units[] = {"vc", "vd", "vg"};
		};

		class Strider_HMG
		{
			unitName = "Strider HMG";
			vehicle = "I_MRAP_03_hmg_F";
			units[] = {"vc", "vd", "vg"};
		};
	};
};
