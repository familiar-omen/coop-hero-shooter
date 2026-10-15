class_name Health extends Node

@export 
var maximum : float
var current : float

func _ready() -> void:
	current = maximum

func handle_effect(effect : Effect):
	if effect is DamageEffect:
		current -= effect.amount
		
		if current <= 0:
			DeathEffect.new().apply(get_parent())
		return true
	return false

func handle_request(request : Request):
	if request is HealthRequest:
		request.current = current
		request.maximum = maximum
		return true
	return false
