class_name DamageEffect extends DirectionalEffect

var amount : float
var direction : Vector3

func update_direction(new_direction : Vector3):
	direction = new_direction
