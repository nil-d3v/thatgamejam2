varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texel;
uniform vec4 u_outlineColor;
uniform float u_outlineSize;
uniform float u_outlineAlpha;

void main() {
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);

    // Original sprite's color
    vec4 base = tex * v_vColour;

    // Search for the maximal alpha around the pixel
    float maxAlpha = 0.0;

    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            if (x == 0 && y == 0)
                continue;

            vec2 offset = vec2(float(x), float(y))
                        * u_texel * u_outlineSize;

            float a = texture2D(
                gm_BaseTexture,
                v_vTexcoord + offset
            ).a;

            maxAlpha = max(maxAlpha, a);
        }
    }

    // Detection of the outline
    float edge = max(0.0, maxAlpha - tex.a);

    // Final outline's alpha
    float outlineA = edge * u_outlineAlpha * u_outlineColor.a * v_vColour.a;

    // Outline creation
    float finalA = base.a + outlineA * (1.0 - base.a);

    vec3 finalRGB = base.rgb * base.a + u_outlineColor.rgb * outlineA * (1.0 - base.a);

    finalRGB /= max(finalA, 0.001);

    gl_FragColor = vec4(finalRGB, finalA);
}