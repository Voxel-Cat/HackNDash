extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 24
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO
var Jumps = 2
var Dashes = 2
var Head_Rotation = 0 
func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if is_on_floor():
		Jumps = 2
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_just_pressed("jump") and not Jumps == 0:
		target_velocity.y = 35
		Jumps = Jumps-1 

	if Input.is_action_just_pressed("dash"):
		pass
	
	
	$ball.global_rotate(Vector3.RIGHT,velocity.z*delta)
	$ball.global_rotate(Vector3.FORWARD,velocity.x*delta)
	
	
	


	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
