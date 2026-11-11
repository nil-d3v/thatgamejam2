oGameController.save_file.stars = 5;
instance_destroy(oPlayer);

// dialogue
dialogue_timer = 0;
credits_started = false;

// pos
posx = 0
posy = 0

player_xpos = 236;
player_ypos = 168;

// set time
times = [
	0 * 60,
	5 * 60,
	5 * 60,
	3 * 60,
	3 * 60,
	3 * 60,
	5 * 60
];

// text
texts = [
	"",
	"Made by Tuvo and 0xNil",
	"Time : " + format_time(oGameController.save_file.stats.timer) + "\nDeaths : " + string(oGameController.save_file.stats.deaths),
	"Music from pixabay.com\nand NoCopyrightSounds",
	"SFX from freesound.org",
	"Inspired from\nTethergeist and Celeste",
	"Thank You for playing!"
];

// state
current_text = 0
text_timer = 0
text_alpha = 0;
alpha_decrease_finished = true;