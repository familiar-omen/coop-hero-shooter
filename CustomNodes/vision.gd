class_name Vision extends Node

@export var cone : Area3D

func handle_request(request : Request):
	if request is VisionRequest:
		var space_state = cone.get_world_3d().direct_space_state
		
		for entity in cone.get_overlapping_bodies():
			var origin = cone.global_position
			var end = entity.get_node("CenterOfMass").global_position
			#var direction = end - origin
			#var plane = Plane(direction, end)
			#
			#end = plane.project(end + Vector3(randfn(0, 0.2), randfn(0, 0.2), randfn(0, 0.2)))
			
			var query = PhysicsRayQueryParameters3D.create(origin, end)
			query.collision_mask = 2

			var result = space_state.intersect_ray(query)
			
			if not result.get("collider"):
				request.can_see.append(entity)
		return true
	return false
