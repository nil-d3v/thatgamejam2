// Overlay
draw_set_alpha(0.9);
draw_set_color(#333333);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_alpha(1);

// Title
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_font(fPauseMenuTitle);
draw_text(24, 50, "Game Paused");
draw_set_font(-1);
draw_set_valign(fa_top);
draw_set_color(c_white);

// Options
for (i = 0; i < 4; i++) {
	if item_index == i {
		draw_set_color(c_white);
		draw_rectangle(options_x[i] - selection_rectangle_length_left, options_y[i] - selection_rectangle_height / 2, options_x[i] + selection_rectangle_length_right, options_y[i] + selection_rectangle_height / 2, false)
		draw_set_color(c_black);
		draw_set_valign(fa_middle);
		draw_set_font(fPauseMenuSelected);
		draw_text(options_x[i], options_y[i], options_text[i]);
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	} else {
		draw_set_color(c_white);
		draw_set_valign(fa_middle);
		draw_set_font(fPauseMenuItem);
		draw_text(options_x[i], options_y[i], options_text[i]);
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	}
}