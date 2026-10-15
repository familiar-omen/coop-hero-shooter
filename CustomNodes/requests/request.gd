@abstract
class_name Request extends RefCounted
	
func query(target : Node):
	for child in target.get_children():
		if child.has_method("handle_request"):
			if child.handle_request(self):
				break
	return self
