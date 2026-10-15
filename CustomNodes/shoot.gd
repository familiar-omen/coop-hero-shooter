class_name Shoot extends Node

@export var prefab : PackedScene
@export var source : Marker3D

func shoot():
	var instance = prefab.instantiate()
	
	instance.transform = source.global_transform
	
	get_tree().root.add_child(instance)
