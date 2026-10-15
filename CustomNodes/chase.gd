class_name SimpleChase extends Node

@export var target : Node3D
@export var speed : float
@export var damage : float
@export var closeness : float = 0.5

func _physics_process(delta: float) -> void:
	if not target: return
	
	var parent : Node3D = get_parent()
	var centerOfMass = target.get_node("CenterOfMass")
	var target_position = (centerOfMass if centerOfMass else target).global_position
	var direction = (target_position - parent.global_position).normalized()
	
	parent.look_at(target_position)
	parent.position += direction * speed * delta
	
	if abs(target_position - parent.global_position).length() < closeness:
		var damageEffect = DamageEffect.new()
		damageEffect.amount = damage
		damageEffect.direction = direction
		damageEffect.apply(target)
		
		var deathEffect = DeathEffect.new()
		deathEffect.apply(get_parent())
