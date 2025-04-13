extends Camera3D

@export var look_target: Node3D
@export var offset = Vector3(0,0,0)

func _process(delta: float) -> void:
	global_position = look_target.global_position + offset
	global_rotation = look_target.transform.basis * Vector3(look_target.position.x,0,look_target.position.y).normalized()
	print("Car rotation: ", look_target.rotation)
	print("Camera rotation: ", rotation)
	look_at(look_target.global_position, Vector3.UP)
