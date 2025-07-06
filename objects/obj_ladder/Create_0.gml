block = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, par_block, false, true);
height = block.height;
depth = block.depth - 1;

bottom_dismount_y = y + ground + 10; // 10 because of the height of the player collision box