class_name TwoStateMotion extends Node

@export var visual : Node3D
@export_custom(0, "suffix:m") var inset : float
@export_custom(0, "suffix:s") var duration : float
var active = false
var tween : Tween

@onready
var original_pos := visual.position

func handle_effect(effect : Effect):
	if effect is ActivationEffect:
		if effect.active and not active:
			if tween: tween.stop()
			
			tween = create_tween()
			tween.tween_property(visual, "position", original_pos - inset * visual.basis.z, duration)
			
			active = true
		
		if not effect.active and active:
			if tween: tween.stop()
			
			tween = create_tween()
			tween.tween_property(visual, "position", original_pos, duration)
			
			active = false
		
		#return true
	#return false
