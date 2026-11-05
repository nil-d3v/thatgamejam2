varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texel;
uniform float u_dissolve;
uniform float u_noiseScale;
uniform vec4 u_imageColor;

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void main() {
	vec4 base = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

	vec2 pixelCoord = floor(v_vTexcoord / u_texel);
	vec2 noiseCoord = floor(pixelCoord / u_noiseScale);

	float noise = hash(noiseCoord);

	if (noise < u_dissolve) {
		discard;
	}
	gl_FragColor = vec4(u_imageColor.rgb, u_imageColor.a * base.a);
}