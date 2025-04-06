extends Camera3D

@export var lerp_speed = 0.25
@export var offset = Vector3.ZERO
@export var follow_target: Node3D
@export var look_target: Node3D


func _physics_process(delta):
	if !look_target && !follow_target:
		return
	var target_pos = follow_target.global_transform.translated_local(offset)
	global_transform = global_transform.interpolate_with(target_pos, lerp_speed * delta)
	look_at(look_target.global_position)
	#global_position = follow_target.global_position + offset
	#look_at(look_target.global_position)
