extends CanvasLayer

var currCutsceneID = 0
var currPageNum = 0

@onready var dialogueBox = $DialogueBox
var grill = "res://character sprites/BBQ_Dad.PNG"
#Replace these temp sprite images
var office = "res://character sprites/BBQ_Dad.PNG"
var player = "res://character sprites/BBQ_Dad.PNG"

signal end_cutscene

#When user clicks, presses spacebar, or presses enter, advances cutscene
func _process(delta):
	if Input.is_action_just_pressed("cutscene_forward"):
		cutscene_forward()

#All dialogue. Triple array. First tracks individual cutscenes,
#second tracks individual pages, third tracks page content
var dialogue = [
	#level 0
	[
		[grill, "left", "I am Grill Dad. Feaster of souls. Hi~"],
		[player, "right", "Cats fuckin suck. I want to kick them"],
		[grill, "left", "Well do *I* have news for you"]
	],

	#level 1
	[
		[office, "left", "Sup fuckers. I'm rich"],
		[player, 'right', 'pay me money'],
		[office, 'left', 'only if you kick some cats for me']
	]
]


#Loads the first page of a cutscene, and marks it as the current cutscene
func start_cutscene(cutsceneID):
	currCutsceneID = cutsceneID
	if(dialogue.size() <= cutsceneID):
		currCutsceneID = 0
	currPageNum = 0
	var currCutscene = dialogue[currCutsceneID]
	var currPage = currCutscene[currPageNum]
	set_dialogue(currPage[0], currPage[1], currPage[2])

func set_dialogue(image, side, text):
	if(side == "left"):
		$LeftImage.show()
		$LeftImage.texture = ResourceLoader.load(image)
		$RightImage.hide()
	else:
		$RightImage.show()
		$RightImage.texture = ResourceLoader.load(image)
		$LeftImage.hide()
	dialogueBox.set_dialogue(text)

#Advances to the next page of the current cutscene. If no more pages are left, hides the cutscene
func cutscene_forward():
	print("Moved forward")
	var currCutscene = dialogue[currCutsceneID]
	if(currPageNum + 1 < currCutscene.size()):
		currPageNum += 1
		var currPage = currCutscene[currPageNum]
		set_dialogue(currPage[0], currPage[1], currPage[2])
	else:
		emit_signal("end_cutscene")
