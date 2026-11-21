extends Node3D

var timer = 0
var listOfObjs = []
var LastPos = null
var TrailObj 

func _ready() -> void:
	TrailObj = preload("res://powers/trail/trail_obj.tscn")

func _process(delta: float) -> void:
	timer += delta
	
	if(timer > 0.2):
		if(LastPos!=null):
			listOfObjs.append(SpawnTrail(LastPos,global_position))
			if(listOfObjs.size() > 40):
				listOfObjs.pop_front().queue_free()
			
		timer = 0
		LastPos = global_position
	
func SpawnTrail(pos1 : Vector3,pos2 : Vector3) -> Object:
		var obj :Area3D = TrailObj.instantiate()
		var height = pos1.distance_to(pos2)
		obj.changeHeight(height)
				
		obj.look_at_from_position(pos1,pos2)
		get_parent_node_3d().get_parent_node_3d().add_child(obj)
		
		return obj
			
