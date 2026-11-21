extends RigidBody3D

var Player
var speed = 20
var maxSpeed = 20
var health = 30
var contactDamage = 5
var Spawner
var counter = 0
func _physics_process(delta: float) -> void:
	if linear_velocity.length() < maxSpeed:
		apply_force(position.direction_to(Player.position) * speed,global_basis.z*-1)
	if(position.y < -20):
		Die()
	pass

func DealDamage(damage) -> int:
	health-=damage
	print(health)
	
	#TODO animasyon
	#TODO sayı çıkması
	if(health>0):
		return contactDamage
	else :
		Die()
		return 0

func Die()->void:
	#TODO animasyon
	Spawner.EnemyCount-=1
	queue_free()
	
