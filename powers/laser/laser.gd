extends Node3D
var bodyList = []

var counter = 0
var damageTime = 0.5
var damageAmount = 3

func _process(delta: float) -> void:
	counter+=delta
	if(counter > damageTime):
		counter = 0
		for enemy in bodyList:
			enemy.DealDamage(damageAmount)
func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body.is_in_group("Enemy")):
		bodyList.append(body)
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	var a = bodyList.find(body)
	if(a!=-1):
		bodyList.remove_at(a)
	pass # Replace with function body.
