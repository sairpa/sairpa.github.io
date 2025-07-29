extends CharacterBody3D

@export var gravity: float = -300.0
@export var rotation_speed: float = 20.0
@export var run_speed:float = 30
@export var jump_velocity:float = 7
#@onready var animp = $tintu/AnimationPlayer

var jumping:bool = false
var running:bool = false
#var walking:bool = true

func _physics_process(delta: float) -> void:
	var move_direction = Vector3.ZERO
	if Input.is_action_pressed("gleft"):
		rotate_y(rotation_speed * delta)
	if Input.is_action_pressed("gright"):
		rotate_y(-rotation_speed * delta)
	if Input.is_action_pressed("accl"):
		move_direction = transform.basis.z
		running = true
	else:
		running = false
	if Input.is_action_pressed("brake"):
		move_direction = -transform.basis.z
		running = false
	if Input.is_action_pressed("jump"):
		move_direction.y = jump_velocity
		jumping = true
	else:
		jumping = false
	#Actual locomotion logic
	if move_direction != Vector3.ZERO:
		velocity.x = move_direction.x*run_speed
		velocity.z = move_direction.z*run_speed
		velocity.y = move_direction.y
	else:
		velocity = Vector3.ZERO
	
	velocity.y += gravity * delta
			
	move_and_slide()
		
