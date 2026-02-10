extends CharacterBody2D

enum State{
	IDLE,
	RUN,
	JUMP,
	WIN
}


@export_category("Stats")
@export var speed:int=400

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]

var state = State.IDLE
var move_direction:Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	movement_loop()


func movement_loop() -> void:
	move_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	var motion:Vector2 = move_direction.normalized() * speed
	set_velocity(motion)
	move_and_slide()
	
	if state == State.IDLE or State.RUN or State.JUMP or State.WIN:
		if move_direction.x < 0:
			$Sprite2D.flip_h =true
		elif move_direction.x > 0:
			$Sprite2D.flip_h = false
	
	if motion != Vector2.ZERO and state == State.IDLE:
		state = State.RUN
		update_animation()
	elif motion == Vector2.ZERO and state == State.RUN:
		state = State.IDLE
		update_animation()
	
	#if Input.is_action_pressed("jump"):
		#state = State.JUMP
		#update_animation()
	#else:
		#state = State.IDLE
		#update_animation()

func update_animation() -> void:
	match state:
		State.IDLE:
			animation_playback.travel("idle")
		State.RUN:
			animation_playback.travel("run")
		State.JUMP:
			animation_playback.travel("jump")
		State.WIN:
			animation_playback.travel("win")
		

		
