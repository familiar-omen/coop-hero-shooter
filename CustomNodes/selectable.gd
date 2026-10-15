class_name Selectable extends Node

@export_enum("none", "enemy", "ally")
var selection_type : String = "none"

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			var new_empty : Array[Node] = []
			selectables.get_or_add(selection_type, new_empty).append(get_parent())
		NOTIFICATION_EXIT_TREE:
			selectables.get_or_add(selection_type, empty).erase(get_parent())

const empty : Array[Node] = []

static var selectables : Dictionary[String, Array]
static func get_all(type : String) -> Array[Node]:
	return selectables.get(type, empty)
