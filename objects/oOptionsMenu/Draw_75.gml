// Overlay
draw_set_alpha(0.9);
draw_set_color(#333333);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_alpha(1);

// Title
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_font(fOptionsMenuTitle);
draw_text(options_x[0], 50, "Options");
draw_set_font(-1);
draw_set_valign(fa_top);
draw_set_color(c_white);

// Options
for (i = 0; i < 3; i++) {
	if item_index == i {
		draw_set_color(c_white);
		draw_rectangle(options_x[i] - selection_rectangle_length_left, options_y[i] - selection_rectangle_height / 2, options_x[i] + selection_rectangle_length_right, options_y[i] + selection_rectangle_height / 2, false)
		draw_set_color(c_black);
		draw_set_valign(fa_middle);
		draw_set_font(fOptionsMenuLabelSelected);
		draw_text(options_x[i], options_y[i], options_text[i]);
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	} else {
		draw_set_color(c_white);
		draw_set_valign(fa_middle);
		draw_set_font(fOptionsMenuLabels);
		draw_text(options_x[i], options_y[i], options_text[i]);
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	}
	if options_variable[i] != noone {
		draw_set_color(item_index == i ? c_black : c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(item_index == i ? fOptionsMenuLabelSelected : fOptionsMenuLabels);
		draw_text(variable_display_x, options_y[i], string(variable_global_get(options_variable[i]) * 10));
		draw_sprite_ext(sValueSelectionArrow, 0, variable_display_x + variable_arrows_distance, options_y[i], 1, 1, 0, item_index == i ? c_black : c_white, 1);
		draw_sprite_ext(sValueSelectionArrow, 0, variable_display_x - variable_arrows_distance, options_y[i], -1, 1, 0, item_index == i ? c_black : c_white, 1);
		draw_set_font(-1);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_color(c_white);
	}
}