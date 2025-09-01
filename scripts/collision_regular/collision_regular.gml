function is_player_colliding_horizontal_slope(_player){
	//show_debug_message("is_player_colliding_horizontal_slope")
	if place_meeting(x - (_player.right - _player.left), y, _player){
		
		var _x_diff = (_player.x - x);
		var _x_perc = _x_diff / sprite_get_width(sprite_index);
		var _z = clamp(height * _x_perc, ground, height);
		
		if (depth < _player.depth){
			_player.depth = depth - 1;	
		}
		
		//if player z is greater than _z then there's no collision
		if (_player.z > _z){
			show_debug_message("player.z <= _z")
			return false;	
		}
		
		if (_player.z == _z){
			show_debug_message("Setting state to slope from is_player_colliding_horizontal_slope")
			_player.current_slope = id;
			_player.state = "slope";
			exit;
		}
		_player.can_move = false;
		return true;
		
		//if (object_get_parent(object_index) == par_slope){
		//	show_debug_message("hitting slope");
		//	_player.current_slope = id;
		//	_player.state = "slope";
		//	exit;
		//	return true;
		//}
		
		//if _player.z >= height{
		//	_player.can_move = true;
	    //    if height > _player.highest_z{
		//		_player.z_ground = height;
		//		_player.highest_z = height;   
	    //    }
		//	return false;
	    //}
			
		//_player.can_move = false;
		//return true;
		////break;
	}	
}

function is_player_colliding_vertical_slope(_player){
	if place_meeting(x, y - (_player.down - _player.up), _player){
		//show_debug_message("player colliding with slope vertically");
		var _x_diff = (_player.x - x);
		var _x_perc = _x_diff / sprite_get_width(sprite_index);
		var _z = clamp(height * _x_perc, ground, height);
		
		if (depth < _player.depth){
			_player.depth = depth - 1;	
		}
		
		//if player z is greater than _z then there's no collision
		if (_player.z > _z){
			return false;	
		}
		
		if (_player.z == _z){
			show_debug_message("Setting state to slope from is_player_colliding_vertical_slope")
			_player.current_slope = id;
			_player.state = "slope";
			exit;
		}
		
		_player.can_move = false;
		return true;
		//if _player.z >= height{
	    //    _player.can_move = true;
	    //    if height > _player.highest_z{
	    //        _player.z_ground = height;
	    //        _player.highest_z = height;   
	    //    }
		//	return false;
		//}
		//_player.can_move = false;
		//return true;
	}	
}

function is_player_colliding_horizontal_block(_player){
	//show_debug_message("block is_player_colliding_vertical")
	if place_meeting(x - (_player.right - _player.left), y, _player){
		
		if (object_get_parent(object_index) == par_slope){
			show_debug_message("hitting slope");
			_player.current_slope = id;
			_player.state = "slope";
			show_debug_message("Setting state to slope from is_player_colliding_horizontal_block")
			exit;
			return true;
		}
		
		if _player.z >= height{
			_player.can_move = true;
	        if height > _player.highest_z{
				_player.z_ground = height;
				_player.highest_z = height;   
	        }
			return false;
	    }
			
		_player.can_move = false;
		return true;
		//break;
	}	
}

function is_player_colliding_vertical_block(_player){
	//show_debug_message("block is_player_colliding_vertical")
	if place_meeting(x, y - (_player.down - _player.up), _player){
		if _player.z >= height{
	        _player.can_move = true;
	        if height > _player.highest_z{
	            _player.z_ground = height;
	            _player.highest_z = height;   
	        }
			return false;
		}
		_player.can_move = false;
		return true;
		//break;
	}	
}



function collision_regular(){
	repeat(abs(walk_speed * (right - left))){
	    can_move = true;
	    highest_z = 0;
    
	    // Here we go through each block, and check if it's height is lower than 
	    // our player's z-value. If it is, then it's walkable, and the player's
	    // "ground" is now at the block's height. 
		
		with (par_block){
			if collision_horizontal(other.id){
				break;	
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
			if collision_vertical(other.id){
				break;	
			}
		}

	    // If the previous checks still allow our player to move, then do it!
	    if can_move y += (down - up);
	}
}