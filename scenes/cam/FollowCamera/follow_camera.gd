extends Camera3D


@export var target: Node3D
@export var radius: float = 4.0
@export var height_offset: float = 3.0
@export var tilt_offset: float = 2.0


func _ready() -> void:
	set_process(target != null)


func _process(_delta: float) -> void:
	if target:
		position = target.position - target.transform.basis.z * radius + Vector3(0, height_offset, 0)
		look_at(target.position + Vector3(0, tilt_offset, 0))
