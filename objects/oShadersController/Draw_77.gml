if surface_exists(application_surface) {
	// Ice Vignette
	if room == RoomMountain && !global.game_paused {
		shader_set(shaderIceVignette);

		shader_set_uniform_f(u_ice_strength, 0.5);
		shader_set_uniform_f(u_ice_radius, 0.45);
		shader_set_uniform_f(u_ice_softness, 0.30);
		shader_set_uniform_f(u_ice_color, 0.35, 0.65, 0.85);
		shader_set_uniform_f(u_ice_noise, 0.08);

		draw_surface(application_surface, 0, 0);

		shader_reset();
	// Heat Haze
	} else if (room == RoomDunes || room == RoomTomb || room == RoomLink) && !global.game_paused {
		var cam = view_camera[0];
		var cam_y = camera_get_view_y(cam);
		var cam_h = camera_get_view_height(cam);

		shader_set(shaderHeatHaze);
		
		shader_set_uniform_f(u_heat_time, current_time / 1000);
		shader_set_uniform_f(u_heat_camera_y, cam_y);
		shader_set_uniform_f(u_heat_world_scale, 1.0 / cam_h);
		shader_set_uniform_f(u_heat_strength, 0.015);
		shader_set_uniform_f(u_heat_speed, 2.0);
		shader_set_uniform_f(u_heat_frequency, 0.05);
		shader_set_uniform_f(u_heat_height, 0.65);
		shader_set_uniform_f(u_heat_noise, 0.4);
		shader_set_uniform_f(u_heat_tint, 0.5);
		shader_set_uniform_f(u_heat_color, 1.0, 0.65, 0.35);

		draw_surface(application_surface, 0, 0);

		shader_reset();
	} else {
		draw_surface(application_surface, 0, 0);
	}
	
	// Death
	if (instance_exists(oPlayer) && oPlayer.main_player_state == MainPlayerState.DEAD) {

	    var _surf_width = surface_get_width(application_surface);
	    var _surf_height = surface_get_height(application_surface);

	    var _shader_time = 1 - abs(1 - 2 * (1 - oPlayer.respawn_timer / oPlayer.respawn_delay));

	    _shader_time = clamp(_shader_time, 0, 1);

	    var _distortion_amount = 0.030 * _shader_time;
	    var _aberration_amount = 0.005 * _shader_time;

	    // Create or resize the copy surface
	    if (!surface_exists(surf_copy) || surface_get_width(surf_copy) != _surf_width || surface_get_height(surf_copy) != _surf_height) {

	        if (surface_exists(surf_copy)) {
	            surface_free(surf_copy);
	        }

	        surf_copy = surface_create(_surf_width, _surf_height);
	    }

	    if (surface_exists(surf_copy)) {

	        // Copy the original application surface
	        surface_set_target(surf_copy);
	        draw_clear_alpha(c_black, 0);
	        draw_surface(application_surface, 0, 0);
	        surface_reset_target();

	        // Apply death shader directly to the screen
	        shader_set(shaderChromaticAberration);

	        shader_set_uniform_f(
	            shader_get_uniform(shaderChromaticAberration, "u_time"),
	            _shader_time
	        );

	        shader_set_uniform_f(
	            shader_get_uniform(shaderChromaticAberration, "u_distortion"),
	            _distortion_amount
	        );

	        shader_set_uniform_f(
	            shader_get_uniform(shaderChromaticAberration, "u_aberration"),
	            _aberration_amount
	        );

	        draw_surface(surf_copy, 0, 0);

	        shader_reset();
	    }
	}
}