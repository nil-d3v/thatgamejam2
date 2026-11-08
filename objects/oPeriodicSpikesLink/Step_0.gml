if (global.game_paused) {exit;};

if timer <= 0 {
	enabled = !enabled;
	timer = enabled ? enabled_time : disabled_time;
}

if enabled {
	image_index = 0;	
} else {
	if timer <= 15 {
		image_index = 1;
	} else {
		image_index = 2;
	}
}