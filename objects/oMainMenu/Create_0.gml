// Menu
item_index = 0;

// Mouse
mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

// Check for an existing save file
non_empty_save_file = noone;
for (i = 1; i <= 3; i++) {
	oGameController.SetSlotIndex(i);
	oGameController.Load();
	if oGameController.save_file != oGameController.base_save_file {
		_non_empty_save_file = i;
		break;
	}
}

if non_empty_save_file == noone {
	oGameController.SetSlotIndex(1);
} else {
	oGameController.SetSlotIndex(_non_empty_save_file);
}