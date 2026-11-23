extends Node

@export var Player : RigidBody3D

@export var Floor1 : StaticBody3D
@export var Floor2: StaticBody3D
@export var Floor3: StaticBody3D
@export var Floor4: StaticBody3D
var middle
var floors = []
func _ready() -> void:
	floors = [Floor1,Floor2,Floor3,Floor4]
var counter = 0
func _physics_process(delta: float) -> void:
	counter += delta
	if(counter > 1):
		changeGroundPositions()
		
		counter = 0
		

func changeGroundPositions()->void:
	var playerPos = Player.global_position + Player.linear_velocity
	var middle = (Floor1.global_position + Floor2.global_position) / 2.0
	var edgeDistance = Floor1.global_position.distance_to(Floor3.global_position) / 2
	if(playerPos.distance_to(middle) < edgeDistance):
		return
	var dists = []
	for floor in floors:
		dists.append(playerPos.distance_to(floor.global_position))
		
	var mindist = min(dists[0],dists[1],dists[2],dists[3])
	var floorint = dists.find(mindist)
		
	var dir = middle.direction_to(floors[floorint].global_position) 
	var newMiddle =  floors[floorint].global_position +  middle.distance_to(floors[floorint].global_position) * dir
	var middleDists = []
	for floor in floors:
		middleDists.append(floor.global_position.distance_to(newMiddle))
	var moveAmount = middle.distance_to(floors[0].global_position) * 2
	for i in range(floors.size()):
		if(i==floorint):
			continue
		var floor :StaticBody3D = floors[i]
		var dist = middleDists[i]
		if(middleDists.rfind(dist)!=i or middleDists.find(dist)!=i):
			floor.translate(dir*moveAmount)
		else:
			floor.translate(dir*moveAmount*2)
		
func spawnObstacles() ->void:
	pass
