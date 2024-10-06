extends CanvasLayer

signal start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Options.hide()
	$Menu.show()

func _on_start_pressed() -> void:
	$Menu.hide()
	emit_signal("start")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	$Menu.hide()
	$Options.show()


func _on_apply_pressed() -> void:
	$Options.hide()
	$Menu.show()
