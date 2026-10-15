class_name LockonMissile extends Node

@export var raycast : RayCast3D
@export var damage : float
@export var lock_time : float
@export var missile : PackedScene
@export var lock_visual : PackedScene

@export var source : Marker3D

var active : bool
var locking : bool

var locked : Dictionary[Node3D, float] = {}
var visuals : Dictionary[Node3D, Node3D] = {}

func handle_command(command : Command) -> bool:
	if command is PrimaryCommand:
		active = true
		locking = true
		return true
	return false

func _physics_process(delta: float) -> void:
	if active:
		if locking:
			lock(delta)
			locking = false
		else:
			shoot()
			active = false

func lock(delta : float):
	var vision_request = VisionRequest.new()
	vision_request.query(get_parent().get_parent())
	
	for enemy in vision_request.can_see:
		locked.get_or_add(enemy, 0)
		locked[enemy] += delta
		
		var visual
		
		if enemy in visuals:
			visual = visuals[enemy]
		else:
			visual = visuals.get_or_add(enemy, lock_visual.instantiate())
			enemy.get_node("CenterOfMass").add_child(visual)
		
		visual.get_node("TargetLock").amount = locked[enemy]
		visual.get_node("TargetLock").maximum = lock_time

func shoot():
	var locks := locked
	locked = {}
	
	for visual in visuals.values():
		if visual: visual.queue_free()
	visuals.clear()
	
	for target in locks:
		if not target: continue
		
		var time = locks[target]
		
		if time < lock_time: continue
		
		var missile_instance = missile.instantiate()
		
		missile_instance.get_node("SimpleChase").set_indexed("target", target)
		missile_instance.get_node("SimpleChase").set_indexed("damage", damage)
		missile_instance.position = source.global_position
		
		get_tree().root.add_child(missile_instance)
		await get_tree().create_timer(0.1).timeout
