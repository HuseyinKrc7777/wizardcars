extends Control

@export var Point : RigidBody2D
@export var Car : RigidBody3D
@export var ResetPoint : Node2D

var areatscn
var flametscn 
var lasertscn 
var ramtscn 
var trailtscn 

var PowersByGear = [null,null,null,null,null,null]
#0 -> 5
# 1 ->6


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Point.lock_rotation = true
	Point.global_position = ResetPoint.global_position
	
	areatscn = preload("res://powers/area/area.tscn")
	flametscn = preload("res://powers/flameBreath/flame_breath.tscn")
	lasertscn = preload("res://powers/laser/laser.tscn")
	ramtscn = preload("res://powers/ram/ram.tscn")
	trailtscn = preload("res://powers/trail/trail.tscn")
	
	SetPowerToGear(lasertscn,3)
	SetPowerToGear(trailtscn,4)
	SetPowerToGear(ramtscn,5)
	SetPowerToGear(areatscn,1)
	
	
	
var movement : Vector2
func _physics_process(delta: float) -> void:
	if movement != Vector2.ZERO:
		Point.apply_impulse(movement*3)
	movement = Vector2.ZERO
	if Input.is_action_just_pressed("space"):
		Point.global_position = ResetPoint.global_position
		

func SetPowerToGear(power,gear):
	var gearToArrayGear = gear-1
	var obj : Object = power.instantiate()
	Car.add_child(obj)
	
	obj.global_position = Car.global_position
	PowersByGear[gearToArrayGear] = obj
	
	if(CurrentGear!=gear):
		unloadPower(gear)
	
	pass

func changePower(gearFrom,gearTo):
	unloadPower(gearFrom)
	loadPower(gearTo)

func loadPower(gear):
	var gearToArrayGear = gear-1
	
	if PowersByGear[gearToArrayGear] != null:
		PowersByGear[gearToArrayGear].process_mode = Node.AUTO_TRANSLATE_MODE_ALWAYS
		PowersByGear[gearToArrayGear].show()
		
func unloadPower(gear):
	var gearToArrayGear = gear-1
	
	if PowersByGear[gearToArrayGear] != null:
		PowersByGear[gearToArrayGear].process_mode = Node.PROCESS_MODE_DISABLED
		PowersByGear[gearToArrayGear].hide()
	#powerobj.queue_free()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not event.relative.is_zero_approx():
		movement += event.relative 
		

enum gears{Neutral,First,Second,Third,Fourth,Fifth,Sixth,Reverse}


var CurrentGear = gears.Neutral
var LastGear = gears.Neutral
var LastTenGears = []
func shiftEntered(body: Node2D, extra_arg_0: int) -> void:
	if CurrentGear > 0 and CurrentGear<7:
		unloadPower(CurrentGear)
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
	
	if CurrentGear > 0 and CurrentGear<7:
		loadPower(CurrentGear)
	
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
