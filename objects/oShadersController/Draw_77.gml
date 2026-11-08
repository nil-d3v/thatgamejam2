if surface_exists(application_surface) {
	if room == RoomMountain {
		shader_set(shaderIceVignette);

		shader_set_uniform_f(u_ice_strength, 0.5);
		shader_set_uniform_f(u_ice_radius, 0.35);
		shader_set_uniform_f(u_ice_softness, 0.30);
		shader_set_uniform_f(u_ice_color, 0.35, 0.65, 0.85);
		shader_set_uniform_f(u_ice_noise, 0.08);

		draw_surface(application_surface, 0, 0);

		shader_reset();
	} else if room == RoomDunes || room == RoomTomb || room == RoomLink {
		var cam = view_camera[0];
		var cam_y = camera_get_view_y(cam);
		var cam_h = camera_get_view_height(cam);

		shader_set(shaderHeatHaze);
		
		shader_set_uniform_f(u_heat_time, current_time / 1000);
		shader_set_uniform_f(u_heat_camera_y, cam_y);
		shader_set_uniform_f(u_heat_world_scale, 1.0 / cam_h);
		shader_set_uniform_f(u_heat_strength, 0.005);
		shader_set_uniform_f(u_heat_speed, 2.0);
		shader_set_uniform_f(u_heat_frequency, 0.05);
		shader_set_uniform_f(u_heat_height, 0.65);
		shader_set_uniform_f(u_heat_noise, 0.35);
		shader_set_uniform_f(u_heat_tint, 0.28);
		shader_set_uniform_f(u_heat_color, 1.0, 0.65, 0.35);

		draw_surface(application_surface, 0, 0);

		shader_reset();
	} else {
		draw_surface(application_surface, 0, 0);
	}
}