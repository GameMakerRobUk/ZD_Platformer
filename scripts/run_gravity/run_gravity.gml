function run_gravity(_player){
	show_debug_message("run_gravity");
	repeat abs(z_speed){
		with par_slope{
			if place_meeting(x, y, _player){
				var _x_diff = (_player.x - x);
				var _x_perc = _x_diff / sprite_get_width(sprite_index);
				var _z = clamp(height * _x_perc, ground, height);
				
				show_debug_message("player_slope_z: " + string(_z) + " | current z: " + string(_player.z))
		
				if (_player.z < _z){
					_player.current_slope = id;
					_player.state = "slope";
					
					show_debug_message("Setting state to slope from run_gravity")
					_player.z = _z;
					_player.z_ground = _z;
					//show_debug_message("Setting state to slope from run_gravity")
					z_speed = 0;
					exit;
				}
			}
		}
		
		z += sign(z_speed);
	}
	
	z_speed -= z_speed_gravity;
}