class_name PlayerController extends Controller

@export var sensitivity : Vector2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseMotion:
		var command = LookCommand.new()
		command.delta = -event.relative * sensitivity
		send_command(command)

func _physics_process(_delta: float) -> void:
	var move_command = MoveCommand.new()
	move_command.direction = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	send_command(move_command)
	
	if Input.is_action_pressed("use_primary"):
		var primary_command = PrimaryCommand.new()
		send_command(primary_command)
		
	if Input.is_action_just_pressed("select_next"):
		var command = SelectNextCommand.new()
		send_command(command)
	
	if Input.is_action_just_pressed("select_prev"):
		var command = SelectPrevCommand.new()
		send_command(command)
	
	if Input.is_action_just_pressed("jump"):
		var command = JumpCommand.new()
		send_command(command)
	
	if Input.is_action_just_pressed("punch"):
		var command = PunchCommand.new()
		send_command(command)
