function get_my_zbox(){
	var _s = {left : bbox_left, right : bbox_right, top : bbox_top - z, bottom : bbox_bottom - z}	
	return _s;
}

function collision_ladder(){
	
	//Colliding with a ladder with bounding box
	var _ladder_bbox = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_ladder, false, true);
	
	with (_ladder_bbox){
		if (y > other.y) continue;
		if (other.bbox_left < bbox_left) continue;
		if (other.bbox_right > bbox_right) continue;
		return _ladder_bbox;	
	}
	
	var _zbox = get_my_zbox();
	var _ladder_zbox = noone;
	
	with (obj_ladder){
		//if (height != other.z) continue;
		if (y > other.y) continue;
		if (other.bbox_left < bbox_left) continue;
		if (other.bbox_right > bbox_right) continue;
		
		var _result = rectangle_in_rectangle(_zbox.left, _zbox.top, _zbox.right, _zbox.bottom, bbox_left, bbox_top, bbox_right, bbox_bottom);
		if (_result > 0){
			_ladder_zbox = id;
			break;
		}
	}
	
	return _ladder_zbox;
	
	//var _ladder_y_plane = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_ladder, false, true);

	//if (_ladder_y_plane == noone) return noone;
	
	//show_debug_message("_ladder.y: " + string(_ladder_y_plane.y) + " | y: " + string(y));
	//show_debug_message("_ladder.height: " + string(_ladder_y_plane.height) + " | z: " + string(z));
	
	//if (_ladder_y_plane.height > z && _ladder_y_plane.y > y) return noone;
	//return _ladder_y_plane;
}