// Afterimages
for (i = 0; i < array_length(afterimages); i++) {
	if afterimages[i][2] >= 1 || afterimages[i][3] <= 0 {
		continue;
	}
	var _texture = sprite_get_texture(sPlayerDash, 0);
	var _texel_w = texture_get_texel_width(_texture);
	var _texel_h = texture_get_texel_height(_texture);

	shader_set(shaderDissolve);

	shader_set_uniform_f(u_dissolve_texel, _texel_w, _texel_h);
	shader_set_uniform_f(u_dissolve_scale, 2.0);
    shader_set_uniform_f(u_dissolve_amount, afterimages[i][2]);
	shader_set_uniform_f(u_dissolve_color, 1.0, 1.0, 1.0, 1.0);

    draw_sprite_ext(sPlayerDash, 0, afterimages[i][0], afterimages[i][1], 1, 1, 0, c_white, afterimages[i][3]);

    shader_reset();
	
	afterimages[i][2] += 0.05;
	afterimages[i][3] -= 0.05;
}

// Draw Player
var _player_alpha = (main_player_state == MainPlayerState.DEAD) ? clamp(respawn_timer / respawn_delay, 0, 1) : 1;
if movement_player_state == MovementPlayerState.DASHING {
	var _dash_progress = 1 - dashTimer / dashDelay;
	var _texture = sprite_get_texture(sprite_index, 0);
	var _outline_texel_w = texture_get_texel_width(_texture);
	var _outline_texel_h = texture_get_texel_height(_texture);

	shader_set(shaderDashOutline);

	shader_set_uniform_f(u_outline_texel, _outline_texel_w, _outline_texel_h);
	shader_set_uniform_f(u_outline_color, 0.35, 0.65, 1.0, 1.0);
	shader_set_uniform_f(u_outline_size, 1.5);
	shader_set_uniform_f(u_outline_alpha, _dash_progress);

	draw_sprite_ext(sprite_index, image_index, x, y, face * xscale, yscale, image_angle, image_blend, _player_alpha);

	shader_reset();
} else {
	draw_sprite_ext(sprite_index, image_index, x, y, face * xscale, yscale, image_angle, image_blend, _player_alpha);
}

// Dash Charge Particles
if oPlayer.movement_player_state == MovementPlayerState.DASHING {
	// Setup
	var _player_center_x = x;
	var _player_center_y = y - 24;
	var _particles_max_distance = 30;
	if !dashChargeParticlesInitialized {
		for (i = 0; i < dashChargeParticleCount; i++) {
			var _particle_angle = i * 360 / dashChargeParticleCount;
			dashChargeParticles[i] = [_player_center_x + lengthdir_x(_particles_max_distance, _particle_angle), _player_center_y + lengthdir_y(_particles_max_distance, _particle_angle), choose(1, 1.5), _particle_angle] // x, y, size, angle
		}
		dashChargeParticlesInitialized = true;
	// Movement
	} else if dashTimer >= 6 {
		for (i = 0; i < dashChargeParticleCount; i++) {
			dashChargeParticles[i][3] = (dashChargeParticles[i][3] + 10) mod 360;
			dashChargeParticles[i][0] = _player_center_x + lengthdir_x(_particles_max_distance, dashChargeParticles[i][3]);
			dashChargeParticles[i][1] = _player_center_y + lengthdir_y(_particles_max_distance, dashChargeParticles[i][3]);
		}
	} else {
		for (i = 0; i < dashChargeParticleCount; i++) {
			var _particle_distance = _particles_max_distance * (dashTimer / 5.5);
			dashChargeParticles[i][2] -= 0.3
			dashChargeParticles[i][3] = (dashChargeParticles[i][3] + 15) mod 360;
			dashChargeParticles[i][0] = _player_center_x + lengthdir_x(_particle_distance, dashChargeParticles[i][3]);
			dashChargeParticles[i][1] = _player_center_y + lengthdir_y(_particle_distance, dashChargeParticles[i][3]);
		}
	}
	// Drawing
	for (i = 0; i < dashChargeParticleCount; i++) {
		draw_set_color(c_blue);
		draw_rectangle(round(dashChargeParticles[i][0] - dashChargeParticles[i][2] / 2), round(dashChargeParticles[i][1] - dashChargeParticles[i][2] / 2), round(dashChargeParticles[i][0] + dashChargeParticles[i][2] / 2), round(dashChargeParticles[i][1] + dashChargeParticles[i][2] / 2), false);
		draw_set_color(c_white);
	}
}