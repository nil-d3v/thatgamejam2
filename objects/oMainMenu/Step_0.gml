// Positions
GUI_MULT = display_get_gui_width() / camera_get_view_width(view_camera[0]);

options_text = [non_empty_save_file == noone ? "Play" : "Continue with Save " + string(oGameController.save_slot_index), "Save Files", "Options"];
options_x = [24 * GUI_MULT, 24 * GUI_MULT, 24 * GUI_MULT];
options_y = [75 * GUI_MULT, 135 * GUI_MULT, 195 * GUI_MULT];
selection_rectangle_height = 50 * GUI_MULT;
selection_rectangle_length_right = 192 * GUI_MULT;
selection_rectangle_length_left = 8 * GUI_MULT;

// Keyboard Input
if keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd) {
	item_index = (item_index + 1) mod 3;
}

if keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu) {
	item_index = (item_index - 1 + 3) mod 3;
}

// Mouse Input
//if point_distance(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious) > 10 {
    
//}

// Selection
if keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left) {
	switch (item_index) {
		case 0:
			room_transition(MainRoom, tr_spotlight, 60);
		break;
		
		case 1:
			// Open save files menu
		break;
		
		case 2:
			// Open options menu
		break;
	}
}