class_name LookAtPlayerController extends Controller

@export var shoot_interval : float
var cd = 0

func _physics_process(_delta: float) -> void:
	var vision_request = VisionRequest.new()
	vision_request.query(get_parent())
	
	var players = vision_request.can_see
	
	if not players: return
	
	var player = players.pick_random() #TODO:: reduce
	
	var direction = body.global_position.direction_to(player.global_position)
	
	var look_command = LookCommand.from_vector(direction)
	send_command(look_command)
	
	var move_command = MoveCommand.new()
	move_command.direction = Vector2.UP
	send_command(move_command)

	cd += _delta

	if cd > shoot_interval:
		var command = PrimaryCommand.new()
		send_command(command)
		cd = 0
