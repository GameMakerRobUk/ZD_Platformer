function is_on_slope(_slope){

	for (var i = 0; i < array_length(_slope.my_triangles); i ++){
		var _coords = _slope.my_triangles[i];
			
		if (point_in_triangle(x, y - z, _coords.x1, _coords.y1, _coords.x2, _coords.y2, _coords.x3, _coords.y3)){
			return true;
		}
	}
	
	return false;
}