if !dialogue_ongoing {
	if player_on_range {
		if player_available {
			draw_sprite(sNPCIndicatorAvailable, 0, normal_to_gui_x(x), normal_to_gui_y(y));
		} else {
			draw_sprite(sNPCIndicatorRange, 0, normal_to_gui_x(x), normal_to_gui_y(y));
		}
	}
}