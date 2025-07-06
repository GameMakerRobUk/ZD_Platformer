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

if (state == "stairs"){
	var _xsign = right - left;
	repeat(abs(walk_speed * _xsign)){
		if (place_meeting(bbox_left + _xsign, y, obj_stairs) || place_meeting(bbox_right + _xsign, y, obj_stairs)){
			x += _xsign;	
			z = clamp(z + (_xsign * 0.5), 0, current_stairs.height);
			z_ground = z;
			//z_ground += (_xsign * 0.5);
		}else{
			show_debug_message("setting state to regular from stairs")
			state = "regular";	
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
				if other.z >= height{
					other.can_move = true;
	                if height > other.highest_z{
						other.z_ground = height;
						other.highest_z = height;   
	                }
	            }else{
					if (object_index == obj_stairs){
						show_debug_message("hitting stairs");
						other.current_stairs = id;
						other.state = "stairs";
						exit;
					}
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
if !place_meeting(x, y, par_block)
    z_ground = 0;
    
// These cool lines keep the player inside of the room. Save this one, it's a good one!
x = min(max(x, 0 + sprite_xoffset), room_width + sprite_xoffset - sprite_width);
y = min(max(y, 0 + sprite_yoffset), room_height + sprite_yoffset - sprite_height);

// This is for aesthetics. It puts our player in the correct depth.
// This is a magic script! Used very often in topdown games.
depth = -y - z_ground;

if (current_stairs != noone && state == "stairs"){
	depth = current_stairs.depth - 1;	
}