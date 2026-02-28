@tool
extends EditorPlugin

#var custom_icon

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type(
		"Joystick", # Name shown in the node list
		"Control", # Base type (matches your root node)
		preload("res://addons/joystick_plugin/joystick_script.gd"),
		preload("res://addons/joystick_plugin/Untitled28_20251005211814.png")
	)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("Joystick")
