event_inherited();
//mask_index = spr_stairs_mask,

ground = 0;

my_triangles = [
{ 
	x1 : bbox_left, 
	y1 : bbox_bottom,
	x2 : bbox_left, 
	y2 : bbox_top,
	x3 : bbox_left + ((bbox_right - bbox_left) * 0.5),   
	y3 : bbox_top,
},
{
	x1 : bbox_left,
	y1 : bbox_top,
	x2 : bbox_left + ((bbox_right - bbox_left) * 0.5),  
	y2 : bbox_top,
	x3 : bbox_left + ((bbox_right - bbox_left) * 0.5),  
	y3 : bbox_top - (bbox_bottom - bbox_top),
},
{
	x1 : bbox_left + ((bbox_right - bbox_left) * 0.5),  
	y1 : bbox_top,	
	x2 : bbox_left + ((bbox_right - bbox_left) * 0.5),   
	y2 : bbox_top - (bbox_bottom - bbox_top),
	x3 : bbox_right,
	y3 : bbox_top - (bbox_bottom - bbox_top),
},
{
	x1 : bbox_left + ((bbox_right - bbox_left) * 0.5),  	
	y1 : bbox_top - (bbox_bottom - bbox_top),
	x2 : bbox_right,
	y2 : bbox_top - (bbox_bottom - bbox_top),
	x3 : bbox_right,
	y3 : bbox_top - ((bbox_bottom - bbox_top) * 2),
}
]