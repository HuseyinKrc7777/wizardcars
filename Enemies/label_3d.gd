extends Label3D
var camera
func _ready() -> void:
	camera = get_viewport().get_camera_3d()
	
func _process(delta: float) -> void:
	look_at(camera.position,camera.global_basis.y,true)
	pass
