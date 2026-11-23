extends Node

@export var Player : RigidBody3D

var timer = 0
var EnemyCount = 0
var enemySpawnTime = 5
var basicEnemy 

func _ready() -> void:
	basicEnemy = preload("res://Enemies/basic_enemy.tscn")
	pass

func _process(delta: float) -> void:
	timer += delta
	if(timer > enemySpawnTime):
		var number = 5
		if(EnemyCount < 50):
			spawnEnemy(basicEnemy,number)
		EnemyCount+=number
		timer = 0
	pass
	
func spawnEnemy(enemy,count : int) -> void:
	for i in range(count):
		var obj : RigidBody3D = enemy.instantiate()
		obj.Player = Player
		obj.Spawner = self
		var angle = randi_range(0,360)
		#needed help here for direction calculation
		var randomDirection = Vector3.RIGHT.rotated(Vector3.UP, angle)
		var randomPosition = Player.global_position+Player.linear_velocity*5 + randomDirection * 45.0

		#var randomPosition = Player.global_position.
		randomPosition.y = Player.position.y + 1
		add_child(obj)
		obj.global_position = randomPosition
	pass
