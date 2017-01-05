class CA
{
		class core
			{
				file = "ca\core";
				class getpos{};
			};
		class spawn
		{
			file = "ca\spawn";
			class spawngroup{};
		};
	class headless
	{
		file = "ca\headless";
		class hcinit{postInit = 1;};
		class hccount{};
		class hcfind{};
		class hcexec{};
		class hcmarker{};
	};
};
