extends Camera3D


@export var target: Node3D 
@export var orbit_speed: float = 2.0 
@export var zoom_speed: float = 5.0   
@export var min_radius: float = 2.0  
@export var max_radius: float = 15.0  
@export var radius: float = 5.0      
@export var height_offset: float = 2.5  


var orbit_angle: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_camera_position() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		orbit_angle += orbit_speed * delta
	if Input.is_action_pressed("ui_right"):
		orbit_angle -= orbit_speed * delta
	if Input.is_action_pressed("ui_up"):
		radius = max(radius - zoom_speed * delta, min_radius)
	if Input.is_action_pressed("ui_down"):
		radius = min(radius + zoom_speed * delta, max_radius)
	update_camera_position() 


func update_camera_position() -> void:
	if target:
		position = target.position + Vector3(
			radius * cos(orbit_angle),
			height_offset,
			radius * sin(orbit_angle)
		)
		look_at(target.position + Vector3(0, height_offset / 2, 0))
