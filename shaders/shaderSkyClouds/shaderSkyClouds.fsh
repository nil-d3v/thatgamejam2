varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_speed;
uniform float u_scale;
uniform float u_density;
uniform float u_softness;
uniform float u_opacity;
uniform float u_wind;

float hash(vec2 p)
{
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p)
{
    vec2 i = floor(p);
    vec2 f = fract(p);

    f = f * f * (3.0 - 2.0 * f);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

void main()
{
    vec2 uv = v_vTexcoord;

    uv.x += u_time * u_speed * u_wind;

    vec2 p = uv * u_scale;

    float n = noise(p);
    n = mix(n, noise(p * 2.0) * 0.5 + n * 0.5, 0.35);

    float cloud = smoothstep(
        u_density - u_softness,
        u_density + u_softness,
        n
    );

    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);

    vec3 cloudColor = vec3(0.78, 0.84, 0.91);

    gl_FragColor = vec4(
        cloudColor * cloud,
        cloud * u_opacity * tex.a
    ) * v_vColour;
}
