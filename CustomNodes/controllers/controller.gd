@abstract
class_name Controller extends Node

var body : CharacterBody3D

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PARENTED:
			body = get_parent()
		NOTIFICATION_UNPARENTED:
			body = null

func send_command(command):
	for child in body.get_children():
		if child.has_method("handle_command"):
			if child.handle_command(command):
				return
