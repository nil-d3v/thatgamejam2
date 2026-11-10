// Menu
item_index = 0;

// Input
last_used_input = "keyboard"; // keyboard / mouse
mouse_xprevious = device_mouse_x_to_gui(0);
mouse_yprevious = device_mouse_y_to_gui(0);

// Check for an existing save file
non_empty_save_file = noone;
for (i = 1; i <= 3; i++) {
	oGameController.SetSlotIndex(i);
	oGameController.Load();
	if oGameController.save_file != oGameController.base_save_file {
		non_empty_save_file = i;
		break;
	}
}

if non_empty_save_file == noone {
	oGameController.SetSlotIndex(1);
} else {
	oGameController.SetSlotIndex(non_empty_save_file);
}