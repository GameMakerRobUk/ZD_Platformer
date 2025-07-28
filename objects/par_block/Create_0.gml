/// @description Insert description here
// You can write your code in this editor
depth = -y;
height = bbox_bottom - bbox_top;
ground = 0;

method(, function is_player_colliding_horizontal(_player){
	if place_meeting(x - (_player.right - _player.left), y, _player){
		
		if (object_get_parent(object_index) == par_slope){
			show_debug_message("hitting slope");
			_player.current_slope = id;
			_player.state = "slope";
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
})

method(, function is_player_colliding_vertical(_player){
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
})
