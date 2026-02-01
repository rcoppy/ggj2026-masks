shader_type spatial;
render_mode depth_draw_opaque, unshaded, shadows_disabled;

uniform sampler2D noise_tex : hint_default_white;
uniform vec4 smoke_color : source_color = vec4(0.3, 0.3, 0.3, 0.6);
uniform float speed = 0.5;

void fragment() {
    vec2 uv1 = UV + vec2(TIME * speed * 0.1, TIME * speed);
    vec2 uv2 = UV + vec2(TIME * -speed * 0.1, TIME * speed * 0.7);
    
    float n1 = texture(noise_tex, uv1).r;
    float n2 = texture(noise_tex, uv2).r;
    float combined_noise = (n1 + n2) * 0.5;
    
    float alpha_mask = combined_noise * UV.y;
    
    ALBEDO = smoke_color.rgb;
    ALPHA = clamp(alpha_mask, 0.0, 1.0) * smoke_color.a;
}
