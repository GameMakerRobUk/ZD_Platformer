// These variables check for inputs! They're used throughout this script.
left     = keyboard_check(vk_left)  or keyboard_check(ord("A"));
right    = keyboard_check(vk_right) or keyboard_check(ord("D"));
up       = keyboard_check(vk_up)    or keyboard_check(ord("W"));
down     = keyboard_check(vk_down)  or keyboard_check(ord("S"));
jump     = keyboard_check_pressed(vk_space);

if (!climbing){
	//Ladders
	var _ladder = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_ladder, false, true);

	if (_ladder != noone){
		show_climb_button = true;
		
		if (keyboard_check_pressed(ord("E"))){
			climbing = true;	
			//z_ground = _ladder.height;
		}
	}else{
		show_climb_button = false;	
	}
}else{
	
}

if (climbing){
	var _xsign = right - left;
	repeat(abs(walk_speed * _xsign)){
		if (place_meeting(bbox_left + _xsign, y, obj_ladder) && place_meeting(bbox_right + _xsign, y, obj_ladder)){
			x += _xsign;	
		}
	}
	
	var _ysign = down - up;
	
	repeat(abs(walk_speed * _ysign)){
		if (place_meeting(x, y + _ysign, obj_ladder)){
			//y += _ysign;
			z -= (_ysign);
			depth = -y - z_ground;
			//-lerp(0, 64, (y - _ladder.y) / 64);
		}else{
			climbing = false;
			//y += (z_ground / 2);
			//depth = -y - z_ground;
			exit;
		}
	}
	
	//var _block = instance_position(x, y, obj_block);
	//if (_block != noone){
	//	z = _block.height;
	//	z_ground = z;
	//}
	
	exit;
}

// To ensure pixel-perfect collision, we repeat this code as many times as there
// are pixels in the movement.
// This checks for left/right.
repeat(abs(walk_speed * (right - left)))
{
    can_move = true;
    highest_z = 0;
    
    // Here we go through each block, and check if it's height is lower than 
    // our player's z-value. If it is, then it's walkable, and the player's
    // "ground" is now at the block's height. 
    with (obj_block)
    {
        if place_meeting(x - (other.right - other.left), y, other)
            {
                if other.z >= height
                {
                    other.can_move = true;
                    if height > other.highest_z
                    {
                        other.z_ground = height;
                        other.highest_z = height;   
                    }
            }
            else
            {
                other.can_move = false;
                break;
            }
            
        }
    }

    // If the previous checks still allow our player to move, then do it!
    if can_move == true
        x += (right - left);
}

// To ensure pixel-perfect collision, we repeat this code as many times as there
// are pixels in the movement.
// This checks for up/down.
repeat(abs(walk_speed * (down - up)))
{
    can_move = true;
    highest_z = 0;
    
    // Here we go through each block, and check if it's height is lower than 
    // our player's z-value. If it is, then it's walkable, and the player's
    // "ground" is now at the block's height. 
    with (obj_block)
    {
        if place_meeting(x, y - (other.down - other.up), other)
            {
                if other.z >= height
                {
                    other.can_move = true;
                    if height > other.highest_z
                    {
                        other.z_ground = height;
                        other.highest_z = height;   
                    }
            }
            else
            {
                other.can_move = false;
                break;
            }
            
        }
    }

    // If the previous checks still allow our player to move, then do it!
    if can_move == true
        y += (down - up);
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
if !place_meeting(x, y, obj_block)
    z_ground = 0;
    
// These cool lines keep the player inside of the room. Save this one, it's a good one!
x = min(max(x, 0 + sprite_xoffset), room_width + sprite_xoffset - sprite_width);
y = min(max(y, 0 + sprite_yoffset), room_height + sprite_yoffset - sprite_height);

// This is for aesthetics. It puts our player in the correct depth.
// This is a magic script! Used very often in topdown games.
depth = -y - z_ground;