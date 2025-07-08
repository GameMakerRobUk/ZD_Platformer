left     = keyboard_check(vk_left)  or keyboard_check(ord("A"));
right    = keyboard_check(vk_right) or keyboard_check(ord("D"));
up       = keyboard_check(vk_up)    or keyboard_check(ord("W"));
down     = keyboard_check(vk_down)  or keyboard_check(ord("S"));
jump     = keyboard_check_pressed(vk_space);

if (state == "regular"){
	//Ladders
	var _ladder = collision_ladder();

	if (_ladder != noone){
		show_climb_button = true;
		
		if (keyboard_check_pressed(ord("E"))){	
			state = "climbing";
			lowest_z = _ladder.ground;
			current_ladder = _ladder;
			show_debug_message("Mounting ladder | " + string({lowest_z : lowest_z, z : z, z_ground : z_ground, y : y, state : state}))
			exit;
		}
	}else{
		show_climb_button = false;	
	}
}

if (state == "slope"){
	var _xsign = right - left;
	repeat(abs(walk_speed * _xsign)){
		if (place_meeting(bbox_left + _xsign, y, obj_slope) || place_meeting(bbox_right + _xsign, y, obj_slope)){
			x += _xsign;	
			
			//if (x >= current_slope.bbox_left && x <= current_slope.bbox_right){
				//z = clamp(z + (_xsign * 0.5), 0, current_slope.height);
				//z_ground = z;
			//}
			//Calculate z based on player x position relative to slope
			var _x_diff = (x - current_slope.x);
			var _x_perc = _x_diff / sprite_get_width(current_slope.sprite_index);
			var _z = clamp(current_slope.height * _x_perc, 0, current_slope.height);
			
			show_debug_message("_x_diff: " + string(_x_diff) + " | _x_perc: " + string(_x_perc) + " | _z: " + string(_z));
			
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
		
		var _on_slope = false;
		//Check if we're still on the slope
		for (var i = 0; i < array_length(current_slope.my_triangles); i ++){
			var _coords = current_slope.my_triangles[i];
			
			if (point_in_triangle(x, y - z, _coords.x1, _coords.y1, _coords.x2, _coords.y2, _coords.x3, _coords.y3)){
				_on_slope = true;
				break;
			}
		}
		
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

// To ensure pixel-perfect collision, we repeat this code as many times as there
// are pixels in the movement.
// This checks for left/right.

if (state == "regular"){
	repeat(abs(walk_speed * (right - left)))
	{
	    can_move = true;
	    highest_z = 0;
    
	    // Here we go through each block, and check if it's height is lower than 
	    // our player's z-value. If it is, then it's walkable, and the player's
	    // "ground" is now at the block's height. 
		
		
		with (par_block){
			if place_meeting(x - (other.right - other.left), y, other){
				if (object_index == obj_slope){
					show_debug_message("hitting slope");
					other.current_slope = id;
					other.state = "slope";
					exit;
				}
				if other.z >= height{
					other.can_move = true;
	                if height > other.highest_z{
						other.z_ground = height;
						other.highest_z = height;   
	                }
	            }else{
					other.can_move = false;
					break;
	            }
            
	        }
	    }

	    // If the previous checks still allow our player to move, then do it!
	    if can_move x += (right - left);
	}

	// To ensure pixel-perfect collision, we repeat this code as many times as there
	// are pixels in the movement.
	// This checks for up/down.
	repeat(abs(walk_speed * (down - up))){
	    can_move = true;
	    highest_z = 0;
    
	    // Here we go through each block, and check if it's height is lower than 
	    // our player's z-value. If it is, then it's walkable, and the player's
	    // "ground" is now at the block's height. 
	    with (par_block){
			if place_meeting(x, y - (other.down - other.up), other){
				if other.z >= height{
	                other.can_move = true;
	                if height > other.highest_z{
	                    other.z_ground = height;
	                    other.highest_z = height;   
	                }
				}else{
					other.can_move = false;
		            break;
				}
			}
		}

	    // If the previous checks still allow our player to move, then do it!
	    if can_move y += (down - up);
	}

}

// If the user is pressing the JUMP BUTTON and our player is on the ground,
// then do a jump!
if jump
and z = z_ground
    z_speed = jump_speed;
    
// The next few checks regulate speed and gravity along the z-axis.
z += z_speed;
z_speed -= z_speed_gravity;

// ... and make sure not to fall through the ground!
if z <= z_ground
{
    z = z_ground;
    z_speed = 0;
}

// If not on a block, then set the ground back to the floor.
//if !place_meeting(x, y, par_block)
//    z_ground = 0;

if (state != "slope" && !place_meeting(x, y, par_block)){
    z_ground = 0;
}

//Depth
depth = -y - z_ground;

if (current_slope != noone && state == "slope"){
	depth = current_slope.depth - 1;	
}