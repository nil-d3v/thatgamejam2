
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texel_size;
uniform vec4 u_glow_color;
uniform float u_glow_strength;
uniform float u_glow_radius;
uniform float u_time;
uniform float u_pulse;

void main() {
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);

    float glow = 0.0;

    // Sample neighboring pixels around the sprite
    for (float x = -4.0; x <= 4.0; x += 1.0) {
        for (float y = -4.0; y <= 4.0; y += 1.0) {
            vec2 offset = vec2(x, y) * u_texel_size * u_glow_radius;

            float sample_alpha = texture2D(
                gm_BaseTexture,
                v_vTexcoord + offset
            ).a;

            float distance_from_center = length(vec2(x, y));

            float falloff = 1.0 - smoothstep(
                1.0,
                4.0,
                distance_from_center
            );

            glow = max(glow, sample_alpha * falloff);
        }
    }

    // Only draw the halo outside the original star
    glow *= (1.0 - tex.a);

    // Gentle pulse
    float pulse = 1.0 + sin(u_time * 2.0) * u_pulse;

    float glow_alpha = glow * u_glow_strength * pulse;

    vec3 final_rgb = mix(
        u_glow_color.rgb,
        tex.rgb,
        tex.a
    );

    float final_alpha = max(tex.a, glow_alpha * u_glow_color.a);

    gl_FragColor = vec4(
        final_rgb,
        final_alpha
    ) * v_vColour;
}
