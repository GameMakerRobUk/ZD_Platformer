left     = keyboard_check(vk_left)  or keyboard_check(ord("A"));
right    = keyboard_check(vk_right) or keyboard_check(ord("D"));
up       = keyboard_check(vk_up)    or keyboard_check(ord("W"));
down     = keyboard_check(vk_down)  or keyboard_check(ord("S"));
jump     = keyboard_check_pressed(vk_space);

#region jump

if (jump && z == z_ground){
	
	//Check to see if there's somewhere to jump to based on the player direction
	var _jump_inst = instance_position(x, y, parJump);
	if (_jump_inst != noone){
		
		state = "jumping"
		timer = 0;
	
		start_x = x;
		start_y = y;
		start_z = z;
		
		//Get the jump curve direction based on the jump image_index [r,d,l,u]
		curve = {
			asset : _jump_inst.curves[_jump_inst.image_index],
			inc : _jump_inst.inc,
		}
	}
}
#endregion

if (state == "slope"){
	var _xsign = right - left;
	repeat(abs(walk_speed * _xsign)){
		if (place_meeting(bbox_left + _xsign, y, par_slope) || place_meeting(bbox_right + _xsign, y, par_slope)){
			x += _xsign;	
			
			//Calculate z based on player x position relative to slope
			var _x_diff = (x - current_slope.x);
			var _x_perc = _x_diff / sprite_get_width(current_slope.sprite_index);
			var _z = clamp(current_slope.height * _x_perc, current_slope.ground, current_slope.height);
		
			z = current_slope.ground + _z;
	
			z_ground = z;
			
			//Exit slope
			if (_xsign == 1){
				if (bbox_left > current_slope.bbox_right){
					show_debug_message("exiting slope moving right")
					state = "regular";
					exit;
				}
			}
			if (_xsign == -1){
				if (bbox_right < current_slope.bbox_left){
					state = "regular";
					z = ceil(z);
					exit;
				}
			}
			
		}else{
			show_debug_message("setting state to regular from slope")
			state = "regular";	
		}
	}
	
	var _ysign = down - up;
	
	repeat (abs(walk_speed * _ysign)){
		y += _ysign;
		
		var _on_slope = is_on_slope(current_slope)
		
		if (!_on_slope){
			show_debug_message("no longer on slope");
			state = "regular";
			z_ground = 0; //@Rob this might need to be updated for slopes on higher planes
		}
	}
}

if (state == "climbing"){
	var _xsign = right - left;
	repeat(abs(walk_speed * _xsign)){
		if (place_meeting(bbox_left + _xsign, y, obj_ladder) && place_meeting(bbox_right + _xsign, y, obj_ladder)){
			x += _xsign;	
		}
	}
	
	var _ysign = down - up;
	
	repeat(abs(walk_speed * _ysign)){
		if (place_meeting(x, y - z, obj_ladder)){
			z -= (_ysign);
			depth = -y - z_ground;
		}else{
			if (place_meeting(x, y, obj_ladder) && _ysign = 1){
				y += _ysign;
			}else{
				
				if (_ysign == 1){
					show_debug_message("y: " + string(y) + " | bottom_dismount_y: " + string(current_ladder.bottom_dismount_y));
					while (y != current_ladder.bottom_dismount_y){
						y += sign(current_ladder.bottom_dismount_y - y);	
					}
					show_debug_message("_ysign == 1")
					z = lowest_z;
				}
				z_ground = z;
				
				show_debug_message("Dismounting ladder | " + string({lowest_z : lowest_z, z : z, z_ground : z_ground, y : y, state : state}))

				show_debug_message("setting state to regular from climbing")
				state = "regular";

				exit;
			}
		}
	}
	
	exit;
}

if (state == "regular"){
	mount_ladder();
	collision_regular();
}
    
// The next few checks regulate speed and gravity along the z-axis.
run_gravity(id);

// ... and make sure not to fall through the ground! @Rob maybe replace this code
if (z <= z_ground){
	
	if (state == "falling"){
		state = "regular";	
	}
    z = z_ground;
    z_speed = 0;
	
	#region Lame Slope check code - causes the speed bug when at bottom of slope and moving vertically?
	
	if (place_meeting(x, y, par_slope)){
		
		if (state != "slope"){
			var _slope = instance_place(x, y, par_slope);
			
			if (!is_on_slope(_slope)){
				while (place_meeting(x, y, _slope)){
					y ++;
				}
			}
		}
	}
	
	#endregion
}

if (state != "slope" && !place_meeting(x, y, par_block)){
    z_ground = 0;
}

//Depth
depth = -y - z_ground;

if (current_slope != noone && state == "slope"){
	depth = current_slope.depth - 1;	
}

if (state == "jumping"){
	if (timer <= 1){
		var _channel_z = animcurve_get_channel(curve.asset, "z");
		z = start_z + animcurve_channel_evaluate(_channel_z, timer);
		
		var _channel_x = animcurve_get_channel(curve.asset, "x");
		x = start_x + animcurve_channel_evaluate(_channel_x, timer);
		
		var _channel_y = animcurve_get_channel(curve.asset, "y");
		y = start_y + animcurve_channel_evaluate(_channel_y, timer);

		timer += curve.inc;
		if (timer >= 1){
	
			show_debug_message("jumping finished\nz: " + string(z));
			state = "falling";	
			
			with par_block{
				if (place_meeting(x, y, obj_player)){
					show_debug_message("meeting with player, height: " + string(height) + " | z: " + string(obj_player.z))
					if (height == obj_player.z){
						obj_player.z_ground = height;
						state = "regular";	
						break;
					}
				}
			}
		}
	}
}