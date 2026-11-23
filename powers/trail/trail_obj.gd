extends Area3D
@export var mesh : MeshInstance3D
@export var collisonShape : CollisionShape3D
var damageAmount = 5
func changeHeight(height : float) -> void:
	mesh.mesh.height = height
	collisonShape.shape.height = height


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		
		body.DealDamage(damageAmount)
		print(damageAmount)
	pass # Replace with function body.
