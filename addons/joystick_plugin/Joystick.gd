@tool

extends Control

@export var move_back_speed = 10 ## The speed of the knob returning to the center.
@export var joystick_target: Node ## What the joystick controls.
@export var target_speed = 10 ## The speed of the target.
@export var secondary_range = false ## Joystick outer range for visuals.
@export var secondary_color: Color = Color(1, 1, 1, 0.3) ## Color of the ring.

@onready var joystick_scene := preload("res://addons/joystick_plugin/joystick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	var source := preload("res://addons/joystick_plugin/Joystick.tscn").instantiate()
	duplicate_children(source, self)
	queue_redraw()

func _draw() -> void:
	if secondary_range:
		draw_circle(Vector2(0, 0), 135, secondary_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func duplicate_children(source_node: Node, target_node: Node) -> void:
	for child in source_node.get_children():
		var copy = child.duplicate()
		target_node.add_child(copy)
