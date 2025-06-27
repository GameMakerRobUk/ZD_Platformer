//draw_sprite_ext(sprite_index, image_index, x, y - z, image_xscale, image_yscale, 0, image_blend, image_alpha);

draw_set_color(c_black);
//draw_text(0, 0, "z: " + string(z) + "\nz_ground: " + string(z_ground) + "\ny: " + string(y));
draw_text(x, y, string(z) + "," + string(z_ground));
//draw_text(x, y, state);

draw_set_color(c_white);
draw_text(x + 1, y + 1, string(z) + "," + string(z_ground));
//draw_text(x + 1, y + 1, state);