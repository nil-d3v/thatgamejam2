if (global.game_paused) {exit;};

if !triggered && oPlayer.groundPlatform == id {
	triggered = true;
	movement_timer = movement_duration;
}

if triggered {
	move();
}