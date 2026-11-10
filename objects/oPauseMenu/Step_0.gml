if instance_exists(oOptionsMenu) {
	exit;
}

// Positions
GUI_MULT = display_get_gui_width() / camera_get_view_width(view_camera[0]);

options_text = ["Resume", "Restart", "Options", "Main Menu"];
options_x = [24 * GUI_MULT, 24 * GUI_MULT, 24 * GUI_MULT, 24 * GUI_MULT];
options_y = [75 * GUI_MULT, 120 * GUI_MULT, 165 * GUI_MULT, 210 * GUI_MULT];
selection_rectangle_height = 40 * GUI_MULT;
selection_rectangle_length_right = 192 * GUI_MULT;
selection_rectangle_length_left = 8 * GUI_MULT;

// Mouse Use Test
if point_distance(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), mouse_xprevious, mouse_yprevious) > 1 || mouse_check_button_pressed(mb_left) {
	last_used_input = "mouse";
}

// Keyboard Input
if keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd) {
	item_index = (item_index + 1) mod 4;
	last_used_input = "keyboard";
}

if keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu) {
	item_index = (item_index - 1 + 4) mod 4;
	last_used_input = "keyboard";
}

if last_used_input == "mouse" {
	for (i = 0; i < 4; i++) {
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), options_x[i] - selection_rectangle_length_left, options_y[i] - selection_rectangle_height / 2, options_x[i] + selection_rectangle_length_right, options_y[i] + selection_rectangle_height / 2) {
			item_index = i;
		}
	}
}

// Selection
if keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left) {
	switch (item_index) {
		case 0:
			global.game_paused = false;
			instance_destroy();
		break;
		
		case 1:
			oPlayer.main_player_state = MainPlayerState.DEAD;
			oPlayer.respawn_timer = 0;
			global.game_paused = false;
			instance_destroy();
		break;
		
		case 2:
			instance_create_layer(0, 0, "Instances", oOptionsMenu);
		break;
		
		case 3:
			global.game_paused = false;
			oGameController.Save();
			room_transition(MainMenu, tr_spotlight, 60);
		break;
	}
}

// Mouse Previous Position Updating
mouse_xprevious = device_mouse_x_to_gui(0);
mouse_yprevious = device_mouse_y_to_gui(0);