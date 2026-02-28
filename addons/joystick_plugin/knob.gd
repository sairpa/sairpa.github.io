extends MeshInstance2D

var dragging = false

var out_of_bounds = false

var direction

var velocity

@onready var position_var = $"../joystick_range".global_position

@onready var parent = get_parent()

var finger_index: int = -1

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var circle = mesh as SphereMesh
			if circle:
				if global_position.distance_to(event.position) <= 125:
					dragging = true
					finger_index = event.index
		else:
			if dragging and event.index == finger_index:
				dragging = false
				out_of_bounds = false
				finger_index = -1
	elif event is InputEventScreenDrag and dragging:
		if position_var.distance_to(event.position) <= 125:
			global_position = event.position
			out_of_bounds = false
			#print("false")
		else:
			out_of_bounds = true
			#print("true")

func _process(delta):
	if !dragging:
		global_position = lerp(global_position, position_var, parent.move_back_speed * delta)
	if out_of_bounds:
		var angle = $"../joystick_range".global_position.angle_to_point(get_global_mouse_position())
		global_position.x = $"../joystick_range".global_position.x + cos(angle) * 125
		global_position.y = $"../joystick_range".global_position.y + sin(angle) * 125
	if dragging:
		if parent.joystick_target == null:
			push_error("Assign a target for the joystick to control")
			assert(false, "Assign a target for the joystick to control")
		elif parent.joystick_target is Node3D:
			push_error("The current target is 3D. Tweak the code in here")
			assert(false, "The current target is 3D. Tweak the code in here")
		direction = (global_position - position_var).normalized()
		velocity = direction * parent.target_speed
		parent.joystick_target.global_position += velocity * delta * 30
