class_name LookCommand extends Command

var delta : Vector2
var absolute : bool

static func from_vector(direction : Vector3) -> LookCommand:
	var horizontal = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP)
	var vertical = Vector3(direction.x, 0, direction.z).signed_angle_to(direction, Vector3.RIGHT)
	var command = new()
	command.delta = Vector2(horizontal, vertical)
	command.absolute = true
	return command
