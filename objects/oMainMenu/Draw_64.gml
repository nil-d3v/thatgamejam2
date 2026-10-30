for (i = 0; i < 3; i++) {
	if item_index == i {
		draw_set_color(c_white);
		draw_rectangle(options_x[i] - selection_rectangle_length_left, options_y[i] - selection_rectangle_height / 2, options_x[i] + selection_rectangle_length_right, options_y[i] + selection_rectangle_height / 2, false)
		draw_set_color(c_black);
		draw_set_valign(fa_middle);
		draw_set_font(fMainMenuSelected);
		draw_text(options_x[i], options_y[i], options_text[i]);
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	} else {
		draw_set_color(c_white);
		draw_set_valign(fa_middle);
		draw_set_font(fMainMenuItem);
		draw_text(options_x[i], options_y[i], options_text[i]);
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	}
}