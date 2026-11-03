if room != SplashScreen && room != MainMenu {
	if keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P")) {
		if global.game_paused {
			global.game_paused = false;
			instance_destroy(oPauseMenu);
		} else {
			global.game_paused = true;
			instance_create_layer(0, 0, "Instances", oPauseMenu);
		}
	}
}