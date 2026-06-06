@tool
extends EditorPlugin

const NAME = "PDF"
func _enable_plugin() -> void:
	add_autoload_singleton(NAME, "res://addons/GodotPDForm/PDF.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton(NAME)
