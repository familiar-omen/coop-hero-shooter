class_name Splitable extends Node

@export var mesh_holder : GeometryInstance3D

func handle_effect(effect : Effect):
	if effect is CutEffect:
		var upper = new_part(effect.plane)
		var lower = new_part(-effect.plane)
		DeathEffect.new().apply(get_parent())
		
		#get_tree().create_timer(1).timeout.connect(func ():
			#DeathEffect.new().apply(upper)
			#DeathEffect.new().apply(lower)
		#)

func new_part(plane : Plane) -> RigidBody3D:
	plane = get_parent().global_transform.inverse() * plane
	
	var base := RigidBody3D.new()
	var visuals := MeshInstance3D.new()
	var collider := CollisionShape3D.new()
	var splitable = Splitable.new()
	var death = Death.new()
	
	var mesh = mesh_holder.bake_static_mesh() if mesh_holder is CSGCombiner3D else mesh_holder.mesh
	
	visuals.mesh = ArrayMesh.new()
	
	for i in range(mesh.get_surface_count()):
		var arrays: Array = mesh.surface_get_arrays(i)
		
		var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		var normals: PackedVector3Array = arrays[Mesh.ARRAY_NORMAL]
		
		cut(vertices, normals, plane)
		
		visuals.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
		visuals.mesh.surface_set_material(i, mesh.surface_get_material(i))
	
	collider.shape = visuals.mesh.create_convex_shape(true, true)
	
	splitable.mesh_holder = visuals
	
	base.add_child(collider)
	base.add_child(visuals)
	base.add_child(splitable)
	base.add_child(death)
	
	base.transform = get_parent().global_transform
	
	get_tree().root.add_child(base)
	
	base.linear_velocity -= plane.normal
	base.linear_velocity += Vector3.UP
	
	return base

func cut(vertices : PackedVector3Array, normals : PackedVector3Array, plane : Plane):
	for i in range(vertices.size()):
		if plane.is_point_over(vertices[i]):
			vertices[i] = plane.project(vertices[i])
			normals[i] = plane.normal
