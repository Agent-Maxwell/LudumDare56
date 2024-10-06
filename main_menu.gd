extends CanvasLayer

signal start
signal open_options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.show()

func _on_start_pressed() -> void:
	$Menu.hide()
	emit_signal("start")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	emit_signal("open_options")
