#define DB 50

class CfgSounds
{
	class briefingVoiceover
	{
		name = "Olymp Briefing";						// display name
		sound[] = { "sound\BriefingVoice.ogg", DB, 1, 200 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "" };			// subtitles

		titlesFont = "LCD14";		// OFP:R - titles font family
		titlesSize = 0.1;			// OFP:R - titles font size

		forceTitles = 0;			// Arma 3 - display titles even if global show titles option is off (1) or not (0)
		titlesStructured = 1;		// Arma 3 - treat titles as Structured Text (1) or not (0)
	};
	class sound_obj_1
	{
		name = "Obj 1";						// display name
		sound[] = { "kb\sound\Obj_1.ogg", DB, 1, 200 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "Objective is under our control. continue on mission." };			// subtitles
	};
	class sound_obj_2
	{
		name = "Obj 2";						// display name
		sound[] = { "kb\sound\Obj_2.ogg", DB, 1, 200 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "Objective secure. Proceed as planned." };			// subtitles
	};
	class sound_obj_3
	{
		name = "Obj 3";						// display name
		sound[] = { "kb\sound\Obj_3.ogg", DB, 1, 200 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "Objective is under our control. Solid work, Lieutenant." };			// subtitles
	};
	class sound_obj_4
	{
		name = "Obj 4";						// display name
		sound[] = { "kb\sound\Obj_4.ogg", DB, 1, 200 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "Objective secured! Area is under our control." };			// subtitles
	};
	class sound_obj_5
	{
		name = "Obj 5";						// display name
		sound[] = { "kb\sound\Obj_5.ogg", DB, 1, 200 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "All Objectives seized. Head for the Loa and await further orders." };			// subtitles
	};
	class AAS_radioambient1
	{
		// how the sound is referred to in the editor (e.g. trigger effects)
		name = "AAS_radioambient1";

		// filename, volume, pitch, distance (optional)
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio1", 1, 1 };

		// subtitle delay in seconds, subtitle text
		titles[] = {};
	};
	class AAS_radioambient2
	{
		name = "AAS_radioambient2";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio2", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient3
	{
		name = "AAS_radioambient3";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio3", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient4
	{
		name = "AAS_radioambient4";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio4", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient5
	{
		name = "AAS_radioambient5";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio5", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient6
	{
		name = "AAS_radioambient6";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio6", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient7
	{
		name = "AAS_radioambient7";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio7", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient8
	{
		name = "AAS_radioambient8";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio8", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient9
	{
		name = "AAS_radioambient9";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio9", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient10
	{
		name = "AAS_radioambient10";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio10", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient11
	{
		name = "AAS_radioambient11";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio11", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient12
	{
		name = "AAS_radioambient12";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio12", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient13
	{
		name = "AAS_radioambient13";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio13", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient14
	{
		name = "AAS_radioambient14";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio14", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient15
	{
		name = "AAS_radioambient15";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio15", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient16
	{
		name = "AAS_radioambient16";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio16", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient17
	{
		name = "AAS_radioambient17";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio17", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient18
	{
		name = "AAS_radioambient18";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio18", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient19
	{
		name = "AAS_radioambient19";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio19", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient20
	{
		name = "AAS_radioambient20";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio20", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient21
	{
		name = "AAS_radioambient21";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio21", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient22
	{
		name = "AAS_radioambient22";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio22", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient23
	{
		name = "AAS_radioambient23";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio23", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient24
	{
		name = "AAS_radioambient24";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio24", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient25
	{
		name = "AAS_radioambient25";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio25", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient26
	{
		name = "AAS_radioambient26";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio26", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient27
	{
		name = "AAS_radioambient27";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio27", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient28
	{
		name = "AAS_radioambient28";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio28", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient29
	{
		name = "AAS_radioambient29";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio29", 1, 1 };
		titles[] = {};
	};
	class AAS_radioambient30
	{
		name = "AAS_radioambient30";
		sound[] = { "@A3\Sounds_F\sfx\radio\ambient_radio30", 1, 1 };
		titles[] = {};
	};
};