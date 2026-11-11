// Save Slots
function check_save_slots_data() {
	slot_stars = array_create(3, 0);
	slot_timer = array_create(3, 0);

	var _active_slot = oGameController.save_slot_index;
	oGameController.Save();

	for (var _slot = 1; _slot <= 3; _slot++) {
		oGameController.save_slot_index = _slot;
		oGameController.Load();
		slot_stars[_slot - 1] = oGameController.save_file.stars;
		slot_timer[_slot - 1] = oGameController.save_file.stats.timer;
	}
	oGameController.save_slot_index = _active_slot;
	oGameController.Load();
}
check_save_slots_data();

// Menu
row_index = 0;
column_index = 0;

// Input
last_used_input = "keyboard"; // keyboard / mouse
mouse_xprevious = device_mouse_x_to_gui(0);
mouse_yprevious = device_mouse_y_to_gui(0);