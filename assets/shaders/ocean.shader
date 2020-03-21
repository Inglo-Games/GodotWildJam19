shader_type canvas_item;

uniform float tile_factor = 50.0;
uniform float time_factor = 0.02;
uniform float wave_factor = 1.0;

uniform sampler2D uv_offset_texture : hint_black;
uniform vec2 uv_offset_scale = vec2(1.0);

void fragment() 
{
	vec2 adjusted_uv = UV * tile_factor;
	
	vec2 base_uv_offset = UV * uv_offset_scale;
	base_uv_offset += vec2(sin(TIME * time_factor), cos(TIME * time_factor / 2.0));
	
	vec2 texture_offset = texture(uv_offset_texture, base_uv_offset).rg;
	texture_offset = texture_offset * 2.0 - 1.0;
	texture_offset *= wave_factor;
	
	COLOR = texture(TEXTURE, adjusted_uv + texture_offset);
}