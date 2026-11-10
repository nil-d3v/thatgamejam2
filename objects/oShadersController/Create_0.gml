// Duplicate Check
if instance_number(oShadersController) > 1 {
	instance_destroy();
}

// Setup
application_surface_draw_enable(false);

// Surfaces
surf_copy = -1;

// Shader Uniforms
u_heat_time = shader_get_uniform(shaderHeatHaze, "u_time");
u_heat_strength = shader_get_uniform(shaderHeatHaze, "u_strength");
u_heat_speed = shader_get_uniform(shaderHeatHaze, "u_speed");
u_heat_frequency = shader_get_uniform(shaderHeatHaze, "u_frequency");
u_heat_height = shader_get_uniform(shaderHeatHaze, "u_height");
u_heat_noise = shader_get_uniform(shaderHeatHaze, "u_noise");
u_heat_camera_y = shader_get_uniform(shaderHeatHaze, "u_camera_y");
u_heat_world_scale = shader_get_uniform(shaderHeatHaze, "u_world_scale");
u_heat_tint = shader_get_uniform(shaderHeatHaze, "u_heat_tint");
u_heat_color = shader_get_uniform(shaderHeatHaze, "u_heat_color");

u_cloud_time = shader_get_uniform(shaderSkyClouds, "u_time");
u_cloud_speed = shader_get_uniform(shaderSkyClouds, "u_speed");
u_cloud_scale = shader_get_uniform(shaderSkyClouds, "u_scale");
u_cloud_density = shader_get_uniform(shaderSkyClouds, "u_density");
u_cloud_softness = shader_get_uniform(shaderSkyClouds, "u_softness");
u_cloud_opacity = shader_get_uniform(shaderSkyClouds, "u_opacity");
u_cloud_wind = shader_get_uniform(shaderSkyClouds, "u_wind");

u_ice_strength = shader_get_uniform(shaderIceVignette, "u_strength");
u_ice_radius = shader_get_uniform(shaderIceVignette, "u_radius");
u_ice_softness = shader_get_uniform(shaderIceVignette, "u_softness");
u_ice_color = shader_get_uniform(shaderIceVignette, "u_ice_color");
u_ice_noise = shader_get_uniform(shaderIceVignette, "u_noise");