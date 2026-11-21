extends RigidBody3D
@export var shifter : Control
@export var Camera : Camera3D
enum gears{Neutral,First,Second,Third,Fourth,Fifth,Sixth,Reverse}

var health = 100
var contactDamageVelocityMultiplier = 1.2
var baseContactDamage = 10
var Defense = 2

func _physics_process(delta: float) -> void:
	var gear = shifter.CurrentGear
	var movement = Input.get_axis("left","right")
	var forward := -global_transform.basis.z
	var value = 50
	if(gear == gears.Reverse):
		value*=-1/7
	if  linear_velocity.length() >= (gear-1)*2 and linear_velocity.length() < gear*5 :
		apply_force(forward * value,forward)
	
	angular_velocity.y = movement * 3 * -+1
	pass

func jump() -> void:
	pass
	#apply_impulse(global_basis.y * 15)
	

var prepos : Vector3 
func _process(delta: float) -> void:
	if prepos ==null:
		prepos = position
		return
	
	var diffrence = position - prepos
	Camera.position += diffrence
	prepos = position
	

func _unhandled_key_input(event: InputEvent) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Enemy"):
		var speedDiff = (linear_velocity - body.linear_velocity).length()
		var damage = baseContactDamage + speedDiff * contactDamageVelocityMultiplier
		var recievedDamage = clamp(body.DealDamage(damage) - Defense,0,99)
		health-=recievedDamage
		print(health)
	pass # Replace with function body.
