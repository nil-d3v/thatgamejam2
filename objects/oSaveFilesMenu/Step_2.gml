// Positions
GUI_MULT = display_get_gui_width() / camera_get_view_width(view_camera[0]);

options_x = [20 * GUI_MULT, 102 * GUI_MULT, 280 * GUI_MULT, 360 * GUI_MULT];
files_y = [70 * GUI_MULT, 135 * GUI_MULT, 200 * GUI_MULT];

// Selection Rectangle
selection_rectangle_height = 36 * GUI_MULT;
selection_rectangle_rounding_radius = 20 * GUI_MULT;
selection_rectangle_width = 60 * GUI_MULT;

// Back Button
button_back_xpos = 24 * GUI_MULT;
button_back_ypos = 238 * GUI_MULT;
button_back_text = "Back";

// Mouse Use Test
if point_distance(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), mouse_xprevious, mouse_yprevious) > 1 || mouse_check_button_pressed(mb_left) {
    last_used_input = "mouse";
}

// Keyboard Input
if keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd) {
    row_index = (row_index + 1) mod 4;
    last_used_input = "keyboard";
}

if keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu) {
    row_index = (row_index - 1 + 4) mod 4;
    last_used_input = "keyboard";
}

if keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(0, gp_padr) {
    column_index = (column_index + 1) mod 2;
    last_used_input = "keyboard";
}

if keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(0, gp_padl) {
    column_index = (column_index - 1 + 2) mod 2;
    last_used_input = "keyboard";
}

// Mouse Selection
if last_used_input == "mouse" {
    for (i = 0; i < 3; i++) {
        if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
            options_x[2] - selection_rectangle_width / 2,
            files_y[i] - selection_rectangle_height / 2,
            options_x[2] + selection_rectangle_width / 2,
            files_y[i] + selection_rectangle_height / 2) {
            row_index = i;
            column_index = 0;
        }

        if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
            options_x[3] - selection_rectangle_width / 2,
            files_y[i] - selection_rectangle_height / 2,
            options_x[3] + selection_rectangle_width / 2,
            files_y[i] + selection_rectangle_height / 2) {
            row_index = i;
            column_index = 1;
        }
    }

    if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
        button_back_xpos - 8 * GUI_MULT,
        button_back_ypos - selection_rectangle_height / 2,
        button_back_xpos + string_width(button_back_text) + 8 * GUI_MULT,
        button_back_ypos + selection_rectangle_height / 2) {
        row_index = 3;
    }
}

// Selection
if keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left) {
    if row_index == 3 {
        instance_destroy();
    } else {
        if column_index == 0 {
            oGameController.SetSlotIndex(row_index + 1);
            oGameController.Load();
        } else {
            var _old_slot_index = oGameController.save_slot_index;
            oGameController.SetSlotIndex(row_index + 1);
            oGameController.Wipe();
            oGameController.SetSlotIndex(_old_slot_index);
			check_save_slots_data();
        }
    }
}

// Mouse Previous Position Update
mouse_xprevious = device_mouse_x_to_gui(0);
mouse_yprevious = device_mouse_y_to_gui(0);
