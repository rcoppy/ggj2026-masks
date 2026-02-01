shader_type spatial;
render_mode depth_draw_opaque, unshaded, shadows_disabled;

uniform sampler2D noise_tex : hint_default_white;
uniform vec4 root_color : source_color = vec4(1.0, 0.75, 0.3, 1.0);
uniform vec4 tip_color : source_color = vec4(1.0, 0.03, 0.0, 1.0);
uniform float fire_speed = 1.0;
uniform float fire_aperture = 0.22;

void fragment() {
    vec2 shifted_uv = UV + vec2(0.0, TIME * fire_speed);
    float fire_noise = texture(noise_tex, shifted_uv).r;
    
    float noise = UV.y * (((UV.y + fire_aperture) * fire_noise - fire_aperture) * 75.0);
    
    vec3 fire_color = mix(tip_color.rgb, root_color.rgb, clamp(noise * 0.05, 0.0, 1.0));
    
    ALBEDO = fire_color;
    ALPHA = clamp(noise, 0.0, 1.0);
}