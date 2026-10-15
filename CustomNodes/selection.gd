class_name Selection extends Node

var index : int

func handle_command(command : Command) -> bool:
	if command is SelectNextCommand:
		index += 1
		index %= get_child_count()
		return true
	if command is SelectPrevCommand:
		index -= 1
		index %= get_child_count()
		return true
	
	var selected_child = get_child(index)
	
	if selected_child.has_method("handle_command"):
		return selected_child.handle_command(command)
	
	return false
