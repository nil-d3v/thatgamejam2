switch (main_player_state) {
	case MainPlayerState.NORMAL:
	case MainPlayerState.DIALOGUE:
	case MainPlayerState.CUTSCENE:
	case MainPlayerState.TRANSITION:
		draw_sprite_ext(sprite_index, image_index, x, y, face * image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	break;
	
	case MainPlayerState.DEAD:
		draw_sprite_ext(sprite_index, image_index, x, y, face * image_xscale, image_yscale, image_angle, image_blend, clamp(respawn_timer / respawn_delay, 0, 1));
	break;
}