// Draw the shadow under the player, scaled according to how high the player is off the ground.
var _scale = 1 - abs((z_ground - z)*.005);
draw_sprite_ext(spr_player_shadow, 0, x, y - z_ground, _scale, _scale, image_angle, image_blend, image_alpha);

// Draw the player at the right height using "z", and at the wobble angle.
draw_sprite_ext(sprite_index, image_index, x, y - z, image_xscale, image_yscale, 0, image_blend, image_alpha);

draw_set_color(c_red);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

//var _text = climbing? "Climbing" : "Not Climbing";
//draw_text(x, y, _text);

if (show_climb_button){
	draw_text(x, y - sprite_height, "E : Climb");	
}