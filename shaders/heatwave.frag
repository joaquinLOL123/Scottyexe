#pragma header

uniform float iTime;

//modification of https://www.shadertoy.com/view/td3GRn :^)

void main() {
    
    vec2 uv = openfl_TextureCoordv;

    // Time varying pixel color
    float jacked_time = 5.5*iTime;
    const vec2 scale = vec2(0.9);

    uv += 0.012*sin(scale*jacked_time + length( uv )*22.0) * uv.y;
    gl_FragColor = flixel_texture2D(bitmap, uv).rgba;
}