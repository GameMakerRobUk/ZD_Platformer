draw_set_color(c_black);
//draw_text(0, 0, "z: " + string(z) + "\nz_ground: " + string(z_ground) + "\ny: " + string(y));
draw_text(x, y, string(x) + "," + string(y + (down - up)) + "," + string(z));

draw_set_color(c_white);
draw_text(x + 1, y + 1, string(x) + "," + string(y + (down - up)) + "," + string(z));