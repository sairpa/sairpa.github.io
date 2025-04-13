extends RigidBody3D

@onready var spring: SpringArm3D = %spring
@onready var pivot: Node3D = %pivot

var sphere_offset = Vector3.DOWN
var acceleration = 50.0
var steering = 35
var turn_speed = 5
var turn_stop_limit = 2
var body_tilt = 75

var speed_input = 0
var turn_input = 0

@onready var car_mesh = $carmesh
@onready var body_mesh = $carmesh/body
@onready var ground_ray = $carmesh/RayCast3D
@onready var right_wheel = $"carmesh/wheel-front-right"
@onready var left_wheel = $"carmesh/wheel-front-left"

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * 0.005)
		spring.rotate_x(-event.relative.y * 0.005)
		spring.rotation.x = clamp(spring.rotation.x, -PI/2, PI/2)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	car_mesh.position = position + sphere_offset
	if ground_ray.is_colliding():
		apply_central_force(-car_mesh.global_transform.basis.z * speed_input)
	
func _process(delta):
	if not ground_ray.is_colliding():
		return
	
	if Input.is_key_pressed(KEY_SHIFT):
		speed_input = Input.get_axis("accl", "brake") * acceleration * 1.35
	else:
		speed_input = Input.get_axis("accl", "brake") * acceleration
	turn_input = Input.get_axis("gright", "gleft") * deg_to_rad(steering)
	right_wheel.rotation.y = turn_input
	left_wheel.rotation.y = turn_input
	if linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, turn_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
		var t = -turn_input * linear_velocity.length() / body_tilt
		body_mesh.rotation.z = lerp(body_mesh.rotation.z, t, 5.0 * delta)
		if ground_ray.is_colliding():
			var n = ground_ray.get_collision_normal()
			var xform = align_with_y(car_mesh.global_transform, n)
			car_mesh.global_transform = car_mesh.global_transform.interpolate_with(xform, 10.0 * delta)


func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform.orthonormalized()
