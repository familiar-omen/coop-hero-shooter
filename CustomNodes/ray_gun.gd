class_name RayGun extends Node

@export var raycast : RayCast3D
@export var damage : float

@export var source : Marker3D

@export var beam : PackedScene
@onready
var beam_instance : Node3D = beam.instantiate()

var shooting = false

func handle_command(command : Command) -> bool:
	if command is PrimaryCommand:
		shoot()
		return true
	return false

func shoot():
	var end_point = raycast.global_position + raycast.global_basis * raycast.target_position
	
	if raycast.get_collider():
		var damageEffect = DamageEffect.new()
		damageEffect.amount = damage
		damageEffect.direction = -raycast.global_basis.z
		damageEffect.apply(raycast.get_collider())
		end_point = raycast.get_collision_point()
	
	shooting = true
	
	if not beam_instance.get_parent():
		source.add_child(beam_instance)
	
	beam_instance.beam_length = source.global_position.distance_to(end_point)
	beam_instance.look_at(end_point, Vector3.UP, false)

func _physics_process(delta: float) -> void:
	if not shooting and beam_instance.get_parent():
		source.remove_child(beam_instance)
	shooting = false
