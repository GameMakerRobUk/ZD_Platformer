function mount_ladder(){
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