// We've got to set some values for the z-axis. We use these in the STEP event!
z               = 0; // The player's position along the z-axis.
z_ground        = 0; // The player's landing height, used if on a block or the floor.
z_speed         = 0; // The speed of travel along the z-axis.
z_speed_gravity = 1; // The speed of gravity along the z-axis.

walk_speed = 3;      // The speed of the player's walk.
jump_speed = 10;     // The power of the player's jump.



show_climb_button = false;
//climbing = false;

state = "regular";
current_stairs = noone;
