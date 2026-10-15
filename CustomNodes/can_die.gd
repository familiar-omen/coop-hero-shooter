class_name Death extends Node

func handle_effect(effect : Effect) -> bool:
	if effect is DeathEffect:
		var parent = get_parent()
		parent.queue_free()
		parent.visible = false
		return true
	return false
