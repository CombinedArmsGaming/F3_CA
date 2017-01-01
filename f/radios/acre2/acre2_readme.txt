GETTING STARTED WITH ACRE2
--------------------------------------------------
ACRE2 works somewhat differently to TFR in a number of ways, however it's also very configurable and can be made very similar to TFR if desired.

--------------------------------------------------
GENERAL NOTES

The first thing to note is that ACRE2 does not use dual-banding like TFR does, but rather you just add another radio to that unit type if you need to.
A player can have 4 active radios (ones they can broadcast on), but can listen to more, so you can theoretically add as many radios as desired.

Key binds are similar to TFR, but not identical. These can be changed as desired, but it's worth noting this, as many comms issues will be
due to people broadcasting on the wrong net due to their TFR key-bind muscle memory. Particularly important here is that CAPS is NOT your short range.
CAPS is instead the last active radio you used. If you only have a SR, then CAPS will function as before, as you won't be switching back and forth between radios. 

Local speech is also much more flexible in volume and attenuation. I find that you can hear other players much better than comparable volumes in TFR.

--------------------------------------------------
RADIO ASSIGNMENT

The radio assignment is defined in acre2_settings.sqf, and the framework will by default assign up to 3 radios to a unit, depending on the unit type.
It's also important to note that Long Range Radios are not always Backpack Radios (though obviously backpack radios are LR), 
so SLs etc will likely not need a backpack radio, unless they're going to be operating at a significant distance from CO.

By default the 3 defined radios are a 343 (SR), a 152 (LR) and a 117F (Backpack LR). So all units will recieve a 343, and then units will recieve a LR (152) and
extra LR (117F) will recieve those as defined.

--------------------------------------------------
INVENTORY SET UP

Radios are now inventory items, so you need to make sure you have the room for the radios in units' inventories 
(343/148/152 are all small and do not take up much room). This is mostly significant for backpack radios, as whilst they fit in small bags like Assault Packs,
there won't be much room left for other kit.

I'd suggest defining a backpack type for SLs and other units with LRs, as it does help with visual recognision (e.g the 3CB BAF radio bergens), 
but this isn't essential. 

It's important to make sure any air/vehicle crews have a LR (ideally a backpack) defined either on themselves or in the vehicle (radios can be added directly into vehicles,
see the ACRE2 site for more details), as vehicles do not natively have radios like in TFR. Vehicles do now have intercoms where appropriate, so vehicle/air crews no longer need a SR
channel to talk to each other on, and can instead just use normal direct voice.

--------------------------------------------------
RADIO CHANNELS

Radio channels are handled differently in ACRE2 compared to TFR, but are actually much simpler for the mission maker and players to set up.
Rather than assigning Alpha to 31, Bravo to 32, Command LR to 44, etc, radios now work on channels only (you don't need to set any frequencies).
This now means that Alpha would be on Channel 1, Bravo, Channel 2 etc. SR and LR radios also have seperate channels, so Alpha SR can be Channel 1,
and Command LR can also be Channel 1 without interference. 

Groups are already set to predefined radio channels in acre2_settings.sqf, which can be edited as desired, along with the channel names. The default set up is a general purpose one,
with a broad range of generic channels, named and assinged as appropriate. Players can obviously change channel very quickly though, so it's not essential that radios are predefined.
I'd strongly encourage it though, as it significantly reduces mission start up prep, as the amount of people needing to set up their radios is vastly reduced.

--------------------------------------------------
BABEL

The Babel system is enabled by default, and will only really come into play in missions with multiple factions, such as TvTs or Coops with 2 units cooperating.
In a nutshell, it prevents units who are not on the same side being able to understand other units. The languages a unit/side speaks can be changed/added to, so translators etc can be used.

--------------------------------------------------
OTHER SETTINGS

ACRE Radio Signal Loss 
 - This is the signal loss due to terrain/line of sight. TFR does not really model this, and I personally think it's a good addition. 
 It does mean that your units with LRs (particularly CO/FAC) need to be aware of their positioning, and can't sit in in a valley behind the rest of their units if they want to have decent comms.
 
ACRE Full Duplex
 - By default ACRE2 uses Half-Duplex radios, so you cannot broadcast and listen at the same time. This also means you can only have one person broadcasting on a channel at a time.
 Setting this to True changes the radios to Full-Duplex, where multiple people can broadcast at the same time, and users can broadcast and listen simultaneously. TFR uses Full-Duplex,
 so if you want parity here, set that to True. I personally recommend trying Half-Duplex, as it will help reduce messy radio comms.
 
ACRE Interference
 - Similar to Radio Signal Loss, multiple radios broadcasting on a channel will interfere with each other, causing signal degredation.
 
ACRE can AI hear players?
 - This sets whether the AI can hear players talking. I'm not sure how effective this is, but I can't see any reason to disable it (if it doesn't work it's no different to normal,
 if it does then that's another interesting gameplay element).