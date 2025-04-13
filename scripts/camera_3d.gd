extends Camera3D

@export var look_target: Node3D
@export var offset = Vector3(0,0,0)

func _process(delta: float) -> void:
	global_position = look_target.global_position + offset

	print("Car rotation: ", look_target.rotation)
	print("Camera rotation: ", rotation)
	look_at(look_target.global_position)
