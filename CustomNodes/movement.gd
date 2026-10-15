class_name Movement extends Node

@export var body : CharacterBody3D
@export_custom(0, "suffix:m/s")
var speed : float = 5

func handle_command(command : Command) -> bool:
	if command is MoveCommand:
		var velocity = body.basis * Vector3(command.direction.x, 0, command.direction.y) * speed
		body.velocity.x = velocity.x
		body.velocity.z = velocity.z
		return true
	if command is JumpCommand:
		if body.is_on_floor():
			body.velocity.y = 6
		return true
	return false

func _physics_process(delta: float) -> void:
	body.move_and_slide()
	body.velocity.x = 0
	body.velocity.z = 0
	body.velocity.y -= delta * 20
