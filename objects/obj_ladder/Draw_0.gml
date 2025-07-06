draw_self();
draw_set_colour(c_red);

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

draw_circle(x, y, 5, true);

var _x = x + (sprite_width/2);
var _y = y - (sprite_height / 2);
draw_set_colour(c_black);
draw_text(_x + 1, _y + 1, "y: " + string(y) + "\nh:" + string(height));

draw_set_colour(c_white);
draw_text(_x, _y, "y: " + string(y) + "\nh:" + string(height));