if (state == "slope"){
	var _on_slope = "false";
	//Slopes = check if x/y is within 2 triangles
	var _x1 = current_slope.x;
	var _y1 = current_slope.y;
	var _x2 = _x1;
	var _y2 = current_slope.bbox_top;
	var _x3 = current_slope.bbox_right;
	var _y3 = current_slope.bbox_top;
	
	draw_set_color(c_lime);
	draw_triangle(_x1, _y1, _x2, _y2, _x3, _y3, false);
	
	if (point_in_triangle(x, y - z, _x1, _y1, _x2, _y2, _x3, _y3)){
		_on_slope = "true";
	}
	
	_x1 = current_slope.bbox_left;
	_y1 = current_slope.bbox_top;
	_x2 = current_slope.bbox_right;
	_y2 = current_slope.bbox_top;
	_x3 = current_slope.bbox_right;
	_y3 = current_slope.bbox_top - (current_slope.bbox_bottom - current_slope.bbox_top);
	
	draw_set_color(c_green);
	draw_triangle(_x1, _y1, _x2, _y2, _x3, _y3, false);
	
	if (point_in_triangle(x, y - z, _x1, _y1, _x2, _y2, _x3, _y3)){
		_on_slope = "true";
	}
	
	draw_set_color(c_black);
	draw_text(x, y, "on_slope: " + _on_slope);
}

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