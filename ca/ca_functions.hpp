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
		class setrank{};
		class specialistMarker{};
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
	class hierarchy
	{
		file = "ca\hierarchy";
		class setupGroup{};
		class becomeco {};
		class setupJIP{};
		class treeselect{};
		class updateradioCHs{};
		class respawngroup{};
		class giveSpecialistMarker{};
		class transferSquadTickets{};
		class movegroup{};
		class selectgroup{};
		class registergroup{};
		class changerank{};
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
		class aidriver{};
		class incfuelcon{};
		class parachute{};
        class vehiclespawner{};
	};
	class respawn
	{
		file = "ca\respawn";
		class respawnwave{};
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
		class activateZeusPlayer{};
		class compileLists{postInit = 1;};
		class detectZeusDisplay{postInit = 1;};
		class giveUnitGodmode{};
		class server_spawnGroup{};
		class zeusUI{};
	};
};
