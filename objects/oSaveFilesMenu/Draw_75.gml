// Overlay
draw_set_alpha(0.9);
draw_set_color(#333333);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_alpha(1);

// Title
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_font(fSaveFilesMenuTitle);
draw_text(24 * GUI_MULT, 32 * GUI_MULT, "Save Files");
draw_set_font(-1);
draw_set_valign(fa_top);

// Options
for (i = 0; i < 3; i++) {
    // Save File Title
    draw_set_color(c_white);
    draw_set_valign(fa_middle);
    draw_set_font(fSaveFilesMenuLabels);
    draw_text(options_x[0], files_y[i], "Save " + string(i + 1));
    draw_set_font(-1);
    draw_set_valign(fa_top);

    // Current Save File Info
    if i + 1 == oGameController.save_slot_index {
        draw_set_color(c_white);
        draw_set_valign(fa_middle);
        draw_set_font(fSaveFilesMenuCurrentInfo);
        draw_text(options_x[0], files_y[i] + 18 * GUI_MULT, "current");
        draw_set_font(-1);
        draw_set_valign(fa_top);
    }

    // Progress
    draw_set_color(c_white);
    draw_set_valign(fa_middle);
    draw_set_font(fSaveFilesMenuProgressInfo);
    draw_text(options_x[1], files_y[i],
        (slot_stars[i] == 0 && slot_timer[i] == 0)
        ? "Empty"
        : string(slot_stars[i]) + " Stars");
    draw_set_font(-1);
    draw_set_valign(fa_top);

    // Load
    if row_index == i && column_index == 0 {
        draw_set_color(c_white);
        draw_roundrect_ext(
            options_x[2] - selection_rectangle_width / 2,
            files_y[i] - selection_rectangle_height / 2,
            options_x[2] + selection_rectangle_width / 2,
            files_y[i] + selection_rectangle_height / 2,
            selection_rectangle_rounding_radius,
            selection_rectangle_rounding_radius,
            false
        );
        draw_set_color(c_black);
    } else {
        draw_set_color(c_white);
    }

	draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fSaveFilesMenuButtons);
    draw_text(options_x[2], files_y[i], "Load");
    draw_set_font(-1);
    draw_set_valign(fa_top);
	draw_set_halign(fa_left);

    // Wipe
    if row_index == i && column_index == 1 {
        draw_set_color(c_white);
        draw_roundrect_ext(
            options_x[3] - selection_rectangle_width / 2,
            files_y[i] - selection_rectangle_height / 2,
            options_x[3] + selection_rectangle_width / 2,
            files_y[i] + selection_rectangle_height / 2,
            selection_rectangle_rounding_radius,
            selection_rectangle_rounding_radius,
            false
        );
        draw_set_color(c_black);
    } else {
        draw_set_color(c_white);
    }

	draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fSaveFilesMenuButtons);
    draw_text(options_x[3], files_y[i], "Wipe");
    draw_set_font(-1);
    draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

// Back Button
draw_set_valign(fa_middle);
draw_set_font(fSaveFilesMenuButtons);

if row_index == 3 {
    draw_set_color(c_white);
    draw_roundrect_ext(
        button_back_xpos - 8 * GUI_MULT,
        button_back_ypos - selection_rectangle_height / 2,
        button_back_xpos + string_width(button_back_text) + 8 * GUI_MULT,
        button_back_ypos + selection_rectangle_height / 2,
        selection_rectangle_rounding_radius,
        selection_rectangle_rounding_radius,
        false
    );
    draw_set_color(c_black);
} else {
    draw_set_color(c_white);
}

draw_text(button_back_xpos, button_back_ypos, button_back_text);

draw_set_font(-1);
draw_set_valign(fa_top);
draw_set_color(c_white);
