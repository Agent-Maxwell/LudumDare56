extends CanvasLayer

var currCutsceneID = -1
var currPageNum = 0

@onready var dialogueBox = $DialogueBox
var grill = "res://character sprites/BBQ_Dad.PNG"
var business = "res://character sprites/Business_Dad.PNG"
var grill_angry = "res://character sprites/Fed_Up_BBQ_Dad.PNG"
var business_angry = "res://character sprites/Fed_Up_Business_Dad.PNG"

signal end_cutscene

#When user clicks, presses spacebar, or presses enter, advances cutscene
func _process(delta):
	if Input.is_action_just_pressed("cutscene_forward") && currCutsceneID != -1:
		cutscene_forward()

#All dialogue. Triple array. First tracks individual cutscenes,
#second tracks individual pages, third tracks page content
var dialogue = [
	#level 0
	[
		[grill, "right", "Bout damn time you arrive! I can’t practice my world-class grill special with these beasts here and I need to get to work soon!"],
		[grill, "right", "Just throw ‘em over that fence over there. Hurry it up!"]
	],

	#level 1
	[
		[business, "left", "Finally! You’re here. These creatures are disturbing my peace and causing a nuisance in my yard!"],
		[business, 'left', 'I need them out of here immediately. Toss them over that fence. Quickly!']
	],
	
	#level 2
	[
		[grill, "right", "Those damn cats came right back! Thrown over the fence! I spent most of the day replacing that rusty thing."],
		[grill, "right", "Also set up a trampoline so that if that snob decides to chuck ‘em back over, they’ll bounce right back into his yard, hahaha!"],
		[grill, "right", "Just throw those things back over and we’ll be done with this."]
	],
	
	#level 3
	[
		[business, "left", "That lout thinks he can just bounce those pests back over here?! Hah, well I’ll show him what the Aerial Object Redirector can do."],
		[business, "left", "Just throw those creatures back and once my AOR is active, this business will be finished."]
	],
	
	#level 4
	[
		[grill, "left", "Hmph. That pompous ass thinks his fancy tech can stop these rats?! Well I’ll show him!"],
		[grill, "left", "Get rid of the cats again and then I’ll activate my leaf blower that’s set up on the fence. Love to see him get the cats over that!"]
	],
	
	#level 5
	[
		[business, "right", "BAH! Such primitive tools that man is using over there. Once my drone is active, there'll be no more loathsome pests in my yard!"],
		[business, "right", "Get rid of them and they should be gone for good!"]
	],
	#level 6
	[
		[grill_angry, "left", "Alright, that’s it! He wants to keep tossing those damn things over here! Well, good luck getting them over that metal fence now! Haha!"],
		[grill_angry, "left", "Aaand, once I finish setting up my pool, those beasts will never want to be anywhere near the yard!"]
	],
	#level 7
	[
		[business_angry, "right", "I have had enough! There is no way on Earth he will be able to get those pests over here now!"],
		[business_angry, "right", "Thanks to cutting edge technology and my well-placed connections, I now have a hardlight deflector!"],
		[business_angry, "right", "A perfect place to test its efficiency and finally get. Rid. Of. Those. CATS!"]
	],
	#level 8
	[
		[grill_angry, "left", "YOU’VE GOT TO BE KIDDING ME! That rich snob thinks he can outsmart me with his fancy tech?!"],
		[grill_angry, "left", "Well do I got something planned for him…"]
	],
	
	#Ending
	[
		[business_angry, "left", "ENOUGH! I tire of these games! You will cease your retaliation this instance!"],
		[grill_angry, "right", "Me?! YOU’RE the one who’s been throwing those things back into my yard!"],
		[business_angry, "left", "Preposterous! I would never lay my hands on such creatures. That’s why I hired this person to do such a task!"],
		[grill_angry, "right", "YOU hired them?! But I hired them first!"],
		[business_angry, "left", "Wait, you mean to tell me the same person has been playing both sides?!"],
		[grill_angry, "right", "I can’t believe this."],
		[business_angry, "both", "YOU’RE FIRED!"]
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
	elif(side == "right"):
		$RightImage.show()
		$RightImage.texture = ResourceLoader.load(image)
		$LeftImage.hide()
	else:
		$LeftImage.show()
		$LeftImage.texture = ResourceLoader.load(business_angry)
		$RightImage.show()
		$RightImage.texture = ResourceLoader.load(grill_angry)
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
		if(currCutsceneID == 9):
			get_tree().quit()
		else:
			currCutsceneID = -1
			emit_signal("end_cutscene")
