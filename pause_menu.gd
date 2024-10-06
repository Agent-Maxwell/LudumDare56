extends SubViewportContainer

signal open_options
signal unpause

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	emit_signal("open_options")

func _on_resume_game_pressed() -> void:
	emit_signal("unpause")
