class_name StartleController extends Controller

@export var turn_time : float = 0.2
@export var turn_steps : int = 20

func handle_effect(effect : Effect):
	if effect is DamageEffect:
		var jump_command = JumpCommand.new()
		send_command(jump_command)
		
		var look_request = LookRequest.new().query(body)
		
		# can instead rotate hit direction with .rotated(Vector3.UP, -look_request.delta.x)
		var look_command = LookCommand.from_vector(-effect.direction)
		look_command.absolute = false
		look_command.delta -= look_request.delta
		if abs(look_command.delta.x) > PI:
			look_command.delta.x -= sign(look_command.delta.x) * PI * 2
		look_command.delta /= turn_steps
		
		var tween = create_tween()
		tween.set_loops(turn_steps)
		tween.bind_node(body)
		tween.tween_interval(turn_time / turn_steps)
		tween.tween_callback(send_command.bind(look_command))
