////draw_sprite_ext(sprite_index, image_index, x, y - z, image_xscale, image_yscale, 0, image_blend, image_alpha);
var _text = "z: " + string(z) + "\nz_ground:" + string(z_ground) + "\ny: " + string(y);
draw_set_color(c_black);
//draw_text(0, 0, "z: " + string(z) + "\nz_ground: " + string(z_ground) + "\ny: " + string(y));
//draw_text(x, y, _text);
//draw_text(x, y, state);

draw_set_color(c_white);
//draw_text(x + 1, y + 1, _text)
////draw_text(x + 1, y + 1, state);

draw_set_colour(c_yellow);

var _xsign = right - left;
draw_rectangle(bbox_left + _xsign, bbox_top, bbox_right + _xsign, bbox_bottom, true);

draw_set_color(c_red);
draw_circle(x, y, 5, true);

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


