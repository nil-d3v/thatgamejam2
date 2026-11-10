draw_self();

if !dialogue_ongoing {
	if player_on_range && oPlayer.talked_to_child {
		if player_available {
			draw_sprite_ext(sInputPromptKeyE, 0, x, y, 0.5, 0.5, 0, c_white, 1);
		} else {
			draw_sprite_ext(sInputPromptPoints, 0, x, y, 0.5, 0.5, 0, c_white, 1);
		}
	}
}