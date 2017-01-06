class CA
{
	class core
	{
		file = "ca\core";
		class getdirpos{};
		class setparams{preInit = 1;};
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
		class masspatrol{};
		class massfortify{};
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
	};
	class spawn
	{
		file = "ca\spawn";
		class spawnattack{};
		class spawngroup{};
		class spawnpatrol{};
		class spawnvehicle{};
		class spawnvehicleattack{};
		class spawnvehiclegroup{};
		class spawnvehiclepatrol{};
		class spawnvehiclestatic{};
	};
};
