if (DEBUG_ON){
	draw_set_color(c_red);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	
	draw_set_colour(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	draw_text(bbox_left, bbox_top, string(height))
	
	draw_set_color(c_yellow);
	draw_rectangle(x, y - sprite_height, x + sprite_width, y, true);
}