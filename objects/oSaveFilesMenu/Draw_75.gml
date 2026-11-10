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
draw_text(24, 50, "Save Files");
draw_set_font(-1);
draw_set_valign(fa_top);
draw_set_color(c_white);

// Options
for (i = 0; i < 3; i++) {
	// Save file title
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_font(fSaveFilesMenuLabels);
	draw_text(options_x[0], files_y[i], "Save " + string(i + 1));
	draw_set_font(-1);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	
	// Selected Info
	if i + 1 == oGameController.save_slot_index {
		draw_set_color(c_white);
		draw_set_valign(fa_middle);
		draw_set_font(fSaveFilesMenuCurrentInfo);
		draw_text(options_x[0], files_y[i] + 18, "current");
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	}
	
	// Progress
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_font(fSaveFilesMenuProgressInfo);
	draw_text(options_x[1], files_y[i], (slot_stars[i] == 0 && slot_timer[i] == 0) ? "Empty" : string(slot_stars[i]) + " Stars");
	draw_set_font(-1);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	
	// Load
	draw_sprite(sSaveFilesMenuLoadButton, row_index == i && column_index == 0 ? 1 : 0, options_x[2], files_y[i])
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_font(fSaveFilesMenuButtons);
	draw_text(options_x[2] + button_text_offset, files_y[i], "Load");
	draw_set_font(-1);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	
	// Wipe
	draw_sprite(sSaveFilesMenuWipeButton, row_index == i && column_index == 1 ? 1 : 0, options_x[3], files_y[i])
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_font(fSaveFilesMenuButtons);
	draw_text(options_x[3] + button_text_offset, files_y[i], "Wipe");
	draw_set_font(-1);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}

// Back Button
draw_set_valign(fa_middle);
draw_set_font(fSaveFilesMenuButtons);
var _rectangle_horizontal_padding = 8;
var _rectangle_height = 28;
var _button_back_text = "Back";
if row_index == 3 {
	draw_set_color(c_white);
	draw_rectangle(button_back_xpos - _rectangle_horizontal_padding, button_back_ypos - _rectangle_height / 2, button_back_xpos + string_width(_button_back_text) + _rectangle_horizontal_padding, button_back_ypos + _rectangle_height / 2, false)
	draw_set_color(c_black);
} else {
	draw_set_color(c_white);
}
draw_text(button_back_xpos, button_back_ypos, _button_back_text);
draw_set_font(-1);
draw_set_valign(fa_top);
draw_set_color(c_white);