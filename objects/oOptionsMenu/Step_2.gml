// Positions
GUI_MULT = display_get_gui_width() / camera_get_view_width(view_camera[0]);

options_text = ["Music Volume", "SFX Volume", "Back"];
options_variable = [string_replace(nameof(global.music_volume), "global.", ""), string_replace(nameof(global.sfx_volume), "global.", ""), noone];
options_x = [24 * GUI_MULT, 24 * GUI_MULT, 24 * GUI_MULT];
options_y = [100 * GUI_MULT, 140 * GUI_MULT, 180 * GUI_MULT];
selection_rectangle_height = 34 * GUI_MULT;
selection_rectangle_length_right = 440 * GUI_MULT;
selection_rectangle_length_left = 8 * GUI_MULT;
variable_display_x = 300 * GUI_MULT;
variable_arrows_distance = 12 * GUI_MULT;

// Mouse Use Test
if point_distance(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), mouse_xprevious, mouse_yprevious) > 1 || mouse_check_button_pressed(mb_left) {
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

if options_variable[item_index] != noone {
	var _current_value = variable_global_get(options_variable[item_index]) * 10;
	if keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(0, gp_padr) {
		variable_global_set(options_variable[item_index], ((_current_value + 1) mod 11) / 10);
	}
	if keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(0, gp_padl) {
		variable_global_set(options_variable[item_index], ((_current_value - 1 + 11) mod 11) / 10);
	}
}

// Mouse Input
if last_used_input == "mouse" {
	for (i = 0; i < 3; i++) {
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), options_x[i] - selection_rectangle_length_left, options_y[i] - selection_rectangle_height / 2, options_x[i] + selection_rectangle_length_right, options_y[i] + selection_rectangle_height / 2) {
			item_index = i;
		}
	}
}

for (i = 0; i < 3; i++) {
	if options_variable[i] != noone && mouse_check_button_pressed(mb_left) {
		var _current_value = variable_global_get(options_variable[i]) * 10;
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), variable_display_x + variable_arrows_distance, options_y[i] - sprite_get_height(sValueSelectionArrow) / 2, variable_display_x + variable_arrows_distance + sprite_get_width(sValueSelectionArrow), options_y[i] + sprite_get_height(sValueSelectionArrow) / 2) {
			variable_global_set(options_variable[i], ((_current_value + 1) mod 11) / 10);
		}
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), variable_display_x - variable_arrows_distance - sprite_get_width(sValueSelectionArrow), options_y[i] - sprite_get_height(sValueSelectionArrow) / 2, variable_display_x - variable_arrows_distance, options_y[i] + sprite_get_height(sValueSelectionArrow) / 2) {
			variable_global_set(options_variable[i], ((_current_value - 1 + 11) mod 11) / 10);
		}
	}
}

// Selection
if keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left) {
	switch (item_index) {
		case 2:
			instance_destroy();
		break;
	}
}

// Mouse Previous Position Update
mouse_xprevious = device_mouse_x_to_gui(0);
mouse_yprevious = device_mouse_y_to_gui(0);