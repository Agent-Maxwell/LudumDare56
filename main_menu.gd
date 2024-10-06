extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Options.hide()
	$Menu.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE	

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	$Menu.hide()
	$Options.show()


func _on_apply_pressed() -> void:
	$Options.hide()
	$Menu.show()
