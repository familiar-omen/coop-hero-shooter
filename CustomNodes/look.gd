class_name Look extends Node

@export var horizontal_hinge : Node3D
@export var vertical_hinge : Node3D

func handle_command(command: Command) -> bool:
	if command is LookCommand:
		if command.absolute:
			horizontal_hinge.rotation.y = 0
			vertical_hinge.rotation.x = 0
		
		horizontal_hinge.rotate_y(command.delta.x)
		vertical_hinge.rotate_x(command.delta.y)
		vertical_hinge.rotation_degrees.x = clampf(vertical_hinge.rotation_degrees.x, -180, 180)
		return true
	return false

func handle_request(request: Request) -> bool:
	if request is LookRequest:
		request.delta = Vector2(
			horizontal_hinge.rotation.y,
			vertical_hinge.rotation.x
		)
		return true
	return false
