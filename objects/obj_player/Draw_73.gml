#region Sprite Masking

with par_block{
	
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(false,false,false,true);
	draw_set_alpha(0);
	draw_rectangle(0,0, room_width,room_height, false);

	draw_set_alpha(0.5);
	draw_sprite(sprite_index,image_index, x,y);
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true,true,true,true);

	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	gpu_set_alphatestenable(true);
	
	draw_sprite(spr_player_silhouette,0, other.x, other.y);
	gpu_set_alphatestenable(false);
	gpu_set_blendmode(bm_normal);
	
	draw_set_alpha(1);
}

#endregion



////draw_sprite_ext(sprite_index, image_index, x, y - z, image_xscale, image_yscale, 0, image_blend, image_alpha);
//var _y_text = "y: " + string(y);
//var _z_text = "z: " + string(z);

//if (current_slope != noone){
//	_z_text += " / " + string(current_slope.height);
//	_y_text += " / " + string(current_slope.y);
//}

//var _text = _y_text + "\n" + _z_text + "\nz_ground:" + string(z_ground);
//draw_set_color(c_black);
////draw_text(0, 0, "z: " + string(z) + "\nz_ground: " + string(z_ground) + "\ny: " + string(y));
//draw_text(x, y, _text);
////draw_text(x, y, state);

//draw_set_color(c_white);
//draw_text(x + 1, y + 1, _text)
////draw_text(x + 1, y + 1, state);

//draw_set_colour(c_yellow);

//var _xsign = right - left;
//draw_rectangle(bbox_left + _xsign, bbox_top, bbox_right + _xsign, bbox_bottom, true);

//draw_set_color(c_red);
//draw_circle(x, y, 5, true);



