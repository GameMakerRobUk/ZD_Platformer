// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function run_gravity(_player){
	//show_debug_message("z_speed: " + string(z_speed) + " | abs(z_speed): " + string(abs(z_speed)));
	repeat abs(z_speed){
		with par_slope{
			if place_meeting(x, y, _player){
				var _x_diff = (_player.x - x);
				var _x_perc = _x_diff / sprite_get_width(sprite_index);
				var _z = clamp(height * _x_perc, ground, height);
		
				if (_player.z <= _z){
					_player.current_slope = id;
					_player.state = "slope";
					_player.z = _z;
					show_debug_message("gravity on a slope");
					z_speed = 0;
					exit;
				}
			}
		}
		
		z += sign(z_speed);
	}
	
	z_speed -= z_speed_gravity;
}