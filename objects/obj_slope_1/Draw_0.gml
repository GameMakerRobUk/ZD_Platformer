draw_self();

//draw_set_colour(c_red);
//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

draw_set_alpha(0.5);
draw_set_colour(c_blue);

var _len = array_length(my_triangles);

for (var i = 0; i < _len; i ++){
	var _coords = my_triangles[i];
			
	draw_triangle(_coords.x1, _coords.y1, _coords.x2, _coords.y2, _coords.x3, _coords.y3, false);
}

draw_set_alpha(1);