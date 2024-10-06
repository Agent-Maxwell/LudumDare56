extends CanvasLayer

var pageNum = 1
var bbqLetter = "res://character sprites/BBQ_Dad_Actual_Letter.PNG"
var businessMail = "res://character sprites/Business_Dad_Email.png"

signal first_note_finished
signal second_note_finished

func _ready() -> void:
	$Image.texture = ResourceLoader.load(bbqLetter)

func _on_button_pressed():
	if(pageNum == 1):
		emit_signal("first_note_finished")
		$Image.texture = ResourceLoader.load(businessMail)
		pageNum+= 1
	else:
		emit_signal("second_note_finished")
