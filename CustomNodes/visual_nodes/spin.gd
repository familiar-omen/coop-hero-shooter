extends Node

@export var axis : Vector3 = Vector3.UP
@export_range(0, 60, 1, "suffix:degree/s") var angular_speed : float

func _process(delta: float) -> void:
	var parent : Node3D = get_parent()
	
	parent.rotate(axis.normalized(), angular_speed * delta)
