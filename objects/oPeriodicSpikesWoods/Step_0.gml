if (global.game_paused) {exit;};

timer--;

if timer <= 0 {
	enabled = !enabled;
	timer = enabled ? enabled_time : disabled_time;
}

if enabled {
	sprite_index = base_sprite_index;
} else {
	sprite_index = sPeriodicSpikesEmpty
}