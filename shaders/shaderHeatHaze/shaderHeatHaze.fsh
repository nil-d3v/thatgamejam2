
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_strength;
uniform float u_speed;
uniform float u_frequency;
uniform float u_height;
uniform float u_noise;
uniform float u_camera_y;
uniform float u_world_scale;
uniform float u_heat_tint;
uniform vec3 u_heat_color;

void main() {
    vec2 uv = v_vTexcoord;

    // Reconstruct the world-space Y coordinate.
    float world_y = u_camera_y + uv.y / u_world_scale;

    // World-anchored distortion.
    float wave1 = sin(
        world_y * u_frequency + u_time * u_speed
    );

    float wave2 = sin(
        world_y * u_frequency * 0.47
        - u_time * u_speed * 0.7
    );

    float distortion = (wave1 + wave2 * u_noise) * u_strength;

    // Screen-space height mask.
    float heightMask = smoothstep(
        1.0 - u_height,
        1.0,
        uv.y
    );

    uv.x += distortion * heightMask;

    vec4 tex = texture2D(gm_BaseTexture, uv);

    // Subtle orange heat overlay.
    float tintAmount = heightMask * u_heat_tint;

    tex.rgb = mix(
        tex.rgb,
        tex.rgb * u_heat_color,
        tintAmount
    );

    gl_FragColor = tex * v_vColour;
}
