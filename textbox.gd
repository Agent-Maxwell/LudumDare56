extends CanvasLayer

@onready var dialogue = $MarginContainer/MarginContainer/HSplitContainer/HBoxContainer/Dialogue

func set_dialogue(dialogueText):
	dialogue.text = dialogueText
