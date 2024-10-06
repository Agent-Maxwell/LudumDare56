extends CanvasLayer

signal apply_options

func _on_apply_pressed() -> void:
	emit_signal("apply_options")
