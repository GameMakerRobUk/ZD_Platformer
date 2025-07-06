////draw_sprite_ext(sprite_index, image_index, x, y - z, image_xscale, image_yscale, 0, image_blend, image_alpha);
var _text = "z: " + string(z) + "\nz_ground:" + string(z_ground) + "\ny: " + string(y);
draw_set_color(c_black);
//draw_text(0, 0, "z: " + string(z) + "\nz_ground: " + string(z_ground) + "\ny: " + string(y));
draw_text(x, y, _text);
//draw_text(x, y, state);

draw_set_color(c_white);
draw_text(x + 1, y + 1, _text)
////draw_text(x + 1, y + 1, state);

draw_set_colour(c_yellow);

var _xsign = right - left;
draw_rectangle(bbox_left + _xsign, bbox_top, bbox_right + _xsign, bbox_bottom, true);

draw_set_color(c_red);
draw_circle(x, y, 5, true);