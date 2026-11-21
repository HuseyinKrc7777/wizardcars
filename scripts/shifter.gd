extends Control

@export var Point : RigidBody2D
@export var Car : RigidBody3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Point.lock_rotation = true
var movement : Vector2
func _physics_process(delta: float) -> void:
	if movement != Vector2.ZERO:
		Point.apply_impulse(movement*3)
	movement = Vector2.ZERO
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not event.relative.is_zero_approx():
		movement += event.relative 
		

enum gears{Neutral,First,Second,Third,Fourth,Fifth,Sixth,Reverse}


var CurrentGear = gears.Neutral
var LastGear = gears.Neutral
var LastTenGears = []
func shiftEntered(body: Node2D, extra_arg_0: int) -> void:
	LastGear = CurrentGear
	if extra_arg_0 == 0:
		CurrentGear = gears.Neutral
	if extra_arg_0 == 1:
		CurrentGear = gears.First
	elif extra_arg_0 == 2:
		CurrentGear = gears.Second
	elif extra_arg_0 == 3:
		CurrentGear = gears.Third
	elif extra_arg_0 == 4:
		CurrentGear = gears.Fourth
	elif extra_arg_0 == 5:
		CurrentGear = gears.Fifth
	elif extra_arg_0 == 6:
		CurrentGear = gears.Sixth
	elif extra_arg_0 == -1:
		CurrentGear = gears.Reverse
	# boy-5  boy-4 boy-3   boy-2  boy-1 
	# 1      0       2        0      1
	#boy-5 == boy-1 ve boy -4 == boy-2 
	# boy - 5 + 1 == boy-3
	#if Input.is_action_pressed("space"):
	var size : int = LastTenGears.size()

	if(LastGear!=CurrentGear):
		LastTenGears.append(CurrentGear)
	
	if(size > 5 and LastTenGears[size-5] == LastTenGears[size-1] and LastTenGears[size-4] == LastTenGears[size-2] and LastTenGears[size-5] + 1 == LastTenGears[size-3]):
		Car.jump()
		LastTenGears.clear()
		
	if(size > 10):
		LastTenGears.pop_front()
