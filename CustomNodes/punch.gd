class_name Punch extends Node

@export var source : Marker3D
@export_custom(0, "suffix:m") var distance : float

func handle_command(command : Command) -> bool:
	if command is PunchCommand:
		punch()
		return true
	return false

func punch():
	var space_state = source.get_world_3d().direct_space_state
	
	var query := PhysicsRayQueryParameters3D.new()
	query.from = source.global_position
	query.to = query.from - source.global_basis.z * distance
	#query.collision_mask = 2

	var result = space_state.intersect_ray(query)
	
	if "collider" in result:
		var push_effect = InteractEffect.new()
		push_effect.apply(result.collider)
		
		var cut_effect = CutEffect.new()
		cut_effect.plane = Plane(get_parent().global_basis.x, result.position)
		cut_effect.apply(result.collider)
