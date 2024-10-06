extends CanvasLayer

var currCutsceneID = 0
var currPageNum = 0

@onready var dialogueBox = $DialogueBox
var grill = "res://character sprites/BBQ_Dad.PNG"
var office = "res://character sprites/BBQ_Dad.PNG"
var player = "res://character sprites/BBQ_Dad.PNG"

signal end_cutscene

func _process(delta):
	if Input.is_action_just_pressed("cutscene_forward"):
		cutscene_forward()

var dialogue = [
	#level 0
	[
		[grill, "left", "I am Grill Dad. Feaster of souls."],
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
	currPageNum = 0
	var currCutscene = dialogue[currCutsceneID]
	var currPage = currCutscene[currPageNum]
	set_dialogue(currPage[0], currPage[1], currPage[2])

func set_dialogue(image, side, text):
	if(side == "left"):
		$CanvasLayer/LeftImage.texture = ResourceLoader.load(image)
		$CanvasLayer/RightImage.hide()
	else:
		$CanvasLayer/RightImage.texture = ResourceLoader.load(image)
		$CanvasLayer/LeftImage.hide()
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
