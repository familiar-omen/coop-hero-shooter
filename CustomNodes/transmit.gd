class_name Transmit extends Node

@export var target : Node

func handle_effect(effect : Effect):
	effect.apply(target)
