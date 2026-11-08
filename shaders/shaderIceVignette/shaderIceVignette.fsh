varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_strength;
uniform float u_radius;
uniform float u_softness;
uniform vec3 u_ice_color;
uniform float u_noise;

void main() {
    vec2 uv = v_vTexcoord;

    vec2 centered = uv - 0.5;
    centered.x *= 480 / 270;

    float dist = length(centered);

    float vignette = smoothstep(
        u_radius,
        u_radius + u_softness,
        dist
    );

    float variation = sin(uv.x * 28.0) *
                      sin(uv.y * 19.0) * u_noise;

    vignette = clamp(vignette + variation * vignette, 0.0, 1.0);

    vec4 tex = texture2D(gm_BaseTexture, uv);

    vec3 finalColor = mix(
        tex.rgb,
        u_ice_color,
        vignette * u_strength
    );

    gl_FragColor = vec4(finalColor, tex.a) * v_vColour;
}
