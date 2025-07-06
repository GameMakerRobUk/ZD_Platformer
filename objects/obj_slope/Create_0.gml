event_inherited();
//mask_index = spr_stairs_mask,

my_triangles = [
{ 
	x1 : x, y1 : y,
	x2 : x, y2 : bbox_top,
	x3 : bbox_right, y3 : bbox_top,
},
{
	x1 : bbox_left,
	y1 : bbox_top,
	x2 : bbox_right,
	y2 : bbox_top,
	x3 : bbox_right,
	y3 : bbox_top - (bbox_bottom - bbox_top),
}
]