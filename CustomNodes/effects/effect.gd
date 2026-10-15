@abstract
class_name Effect extends RefCounted

func apply(target : Node):
	for child in target.get_children():
		if child.has_method("handle_effect"):
			if child.handle_effect(self):
				return
