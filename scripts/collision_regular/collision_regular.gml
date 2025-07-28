function collision_regular(){
	repeat(abs(walk_speed * (right - left))){
	    can_move = true;
	    highest_z = 0;
    
	    // Here we go through each block, and check if it's height is lower than 
	    // our player's z-value. If it is, then it's walkable, and the player's
	    // "ground" is now at the block's height. 
		
		with (par_block){
			if is_player_colliding_horizontal(other.id){
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
			if is_player_colliding_vertical(other.id){
				break;	
			}
		}

	    // If the previous checks still allow our player to move, then do it!
	    if can_move y += (down - up);
	}
}