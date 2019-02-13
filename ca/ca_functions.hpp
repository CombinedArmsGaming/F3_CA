class CA
{
	class ai
	{
		file = "ca\ai";
		class unitGuerrillaAI{};
		class groupGuerrillaAI{};
		class unitSuppressiveAI{};
		class groupSuppressiveAI{};
		class fireWeaponSafe{};
		class compileVehicleWeapons{};
	};
	class core
	{
		file = "ca\core";
		class getdirpos{};
		class getmarkerarray{};
        	class groupMarker{};
	};
	class headless
	{
		file = "ca\headless";
		class hccount{};
		class hcexec{};
		class hcfind{};
		class hcinit{postInit = 1;};
		class hcmarker{};
	};
	class massspawn
	{
		file = "ca\massspawn";
		class massattack{};
		class masscharge{};
		class massfortify{};
		class masspatrol{};
		class massvehicleattack{};
		class massvehiclepatrol{};
		class massvehiclestatic{};
	};
	class misc
	{
		file = "ca\misc";
		class bodymanage{};
		class incfuelcon{};
		class parachute{};
        	class vehiclespawner{};
	};
	class respawn
	{
		file = "ca\respawn";
		class respawnwave{};
		class respawnwaveserver{};
	};
	class spawn
	{
		file = "ca\spawn";
		class spawnattack{};
		class spawncharge{};
		class spawnfortify{};
		class spawngroup{};
		class spawnpatrol{};
		class spawnvehicle{};
		class spawnvehicleattack{};
		class spawnvehiclegroup{};
		class spawnvehiclepatrol{};
		class spawnvehiclestatic{};
	};

	class zeusui
	{
		file = "ca\zeus_ui";
		class compileLists{postInit = 1;};
		class detectZeusDisplay{postInit = 1;};
		class server_spawnGroup{};
		class zeusUI{};
	};
};
