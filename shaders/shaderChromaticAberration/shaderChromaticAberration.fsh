varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_distortion;
uniform float u_aberration;

void main() {
	vec2 uv = v_vTexcoord;
	vec2 centered = uv - vec2(0.5);

	float radius = length(centered);
	float wave = sin(radius * 35.0 - u_time * 8.0);
	
	vec2 distortedUV = uv + normalize(centered + vec2(0.0001)) * wave * u_distortion * radius;
	vec2 direction = normalize(centered + vec2(0.0001));
	vec2 chromaOffset = direction * u_aberration;

	float r = texture2D(gm_BaseTexture, distortedUV + chromaOffset).r;
	float g = texture2D(gm_BaseTexture, distortedUV).g;
	float b = texture2D(gm_BaseTexture, distortedUV - chromaOffset).b;
	float a = texture2D(gm_BaseTexture, distortedUV).a;

	gl_FragColor = vec4(r, g, b, a) * v_vColour;
}
