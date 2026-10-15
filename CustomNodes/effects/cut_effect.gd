class_name CutEffect extends DirectionalEffect

var plane : Plane

func update_direction(new_direction : Vector3):
	var cross = new_direction.cross(plane.normal)
	
	var point1 = plane.get_center()
	var point2 = plane.get_center() + cross
	var point3 = plane.get_center() + new_direction
	
	plane = Plane(point1. point2, point3)
	
	push_warning("Untested code in CutEffect")
