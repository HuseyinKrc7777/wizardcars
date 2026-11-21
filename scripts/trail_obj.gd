extends Area3D
@export var mesh : MeshInstance3D
@export var collisonShape : CollisionShape3D

func changeHeight(height : float) -> void:
	mesh.mesh.height = height
	collisonShape.shape.height = height
