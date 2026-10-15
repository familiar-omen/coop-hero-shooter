class_name PushButton extends Node

@export var togglable : bool

var pushed := false

func handle_effect(effect : Effect):
	if effect is InteractEffect and (not pushed or togglable):
		pushed = !pushed
		
		var active_effect = ActivationEffect.new()
		active_effect.active = pushed
		active_effect.apply(get_parent())
		return true
	return false
