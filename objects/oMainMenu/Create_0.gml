// Menu
item_index = 0;

// Input
last_used_input = "keyboard"; // keyboard / mouse
mouse_xprevious = device_mouse_x_to_gui(0);
mouse_yprevious = device_mouse_y_to_gui(0);

// Check for existing save files
var _active_slot = oGameController.save_slot_index;

non_empty_save_file = noone;

for (var i = 1; i <= 3; i++) {
    oGameController.SetSlotIndex(i);

    if (oGameController.save_file.stats.timer > 0) {
        non_empty_save_file = i;
        break;
    }
}

// Restore previously active save slot
oGameController.SetSlotIndex(_active_slot);
