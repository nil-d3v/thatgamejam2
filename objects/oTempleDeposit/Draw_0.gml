if !star_given && oPlayer.star_carried && place_meeting(x, y, oPlayer) {
	if oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC {
		draw_sprite_ext(sInputPromptKeyE, 0, x, y, 0.5, 0.5, 0, c_white, 1);
	} else {
		draw_sprite_ext(sInputPromptPoints, 0, x, y, 0.5, 0.5, 0, c_white, 1);
	}
}

if (star_active || star_image_alpha > 0) {
    gpu_set_blendmode(bm_add);

    // Outer glow
    draw_sprite_ext(
        sStar, 0,
        star_x, star_y,
        star_image_xscale * 1.5,
        star_image_yscale * 1.5,
        star_image_angle,
        c_yellow,
        star_image_alpha * 0.12
    );

    // Inner glow
    draw_sprite_ext(
        sStar, 0,
        star_x, star_y,
        star_image_xscale * 1.25,
        star_image_yscale * 1.25,
        star_image_angle,
        c_yellow,
        star_image_alpha * 0.25
    );

    gpu_set_blendmode(bm_normal);

    // Actual star
    draw_sprite_ext(
        sStar, 0,
        star_x, star_y,
        star_image_xscale,
        star_image_yscale,
        star_image_angle,
        c_white,
        star_image_alpha
    );
}