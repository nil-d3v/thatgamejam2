if instance_exists(oOptionsMenu) || instance_exists(oSaveFilesMenu) {
	exit;
}

// Positions
GUI_MULT = display_get_gui_width() / camera_get_view_width(view_camera[0]);

options_text = [non_empty_save_file == noone ? "Play" : "Continue with Save " + string(oGameController.save_slot_index), "Save Files", "Options"];
options_x = [24 * GUI_MULT, 24 * GUI_MULT, 24 * GUI_MULT];
options_y = [75 * GUI_MULT, 135 * GUI_MULT, 195 * GUI_MULT];
selection_rectangle_height = 50 * GUI_MULT;
selection_rectangle_length_right = 192 * GUI_MULT;
selection_rectangle_length_left = 8 * GUI_MULT;

// Mouse Use Test
if point_distance(device_mouse_y_to_gui(0), device_mouse_y_to_gui(0), mouse_xprevious, mouse_yprevious) > 1 || mouse_check_button_pressed(mb_left) {
	last_used_input = "mouse";
}

// Keyboard Input
if keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd) {
	item_index = (item_index + 1) mod 3;
	last_used_input = "keyboard";
}

if keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu) {
	item_index = (item_index - 1 + 3) mod 3;
	last_used_input = "keyboard";
}

if last_used_input == "mouse" {
	for (i = 0; i < 3; i++) {
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), options_x[i] - selection_rectangle_length_left, options_y[i] - selection_rectangle_height / 2, options_x[i] + selection_rectangle_length_right, options_y[i] + selection_rectangle_height / 2) {
			item_index = i;
		}
	}
}

// Selection
if keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left) {
	switch (item_index) {
		case 0:
			room_transition(MainRoom, tr_spotlight, 60);
		break;
		
		case 1:
			instance_create_layer(0, 0, "Instances", oSaveFilesMenu);
		break;
		
		case 2:
			instance_create_layer(0, 0, "Instances", oOptionsMenu);
		break;
	}
}

// Mouse Previous Position Updating
mouse_xprevious = device_mouse_y_to_gui(0);
mouse_yprevious = device_mouse_y_to_gui(0);