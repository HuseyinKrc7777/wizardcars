extends RigidBody3D

var Player
var speed = 20
var maxSpeed = 20
var health = 30
var startHealth = health
var contactDamage = 5
var Spawner
var counter = 0
@export var damageLabel : Label3D
func _physics_process(delta: float) -> void:
	if linear_velocity.length() < maxSpeed:
		apply_force(position.direction_to(Player.position) * speed,global_basis.z*-1)
	if(global_position.y < -20):
		Die()
	if(global_position.distance_to(Player.global_position) >150):
		Respawn()
	if(damageTextCooldownCounter < 1):
		damageTextCooldownCounter+=delta
	else:
		damageLabel.text = ""
	pass

var damageTextCooldownCounter = 1
func DealDamage(damage) -> int:
	health-=damage
	print(health)
	damageTextCooldownCounter = 0
	#TODO animasyon
	#TODO sayı çıkması
	damageLabel.text = "%d"%damage
	if(health>0):
		return contactDamage
	else :
		Die()
		return contactDamage*(health+startHealth / startHealth) 

func Respawn()->void:
	translate((global_position.distance_to(Player.global_position)+50) * global_position.direction_to(Player.global_position))
func Die()->void:
	#TODO animasyon
	Spawner.EnemyCount-=1
	queue_free()
	
