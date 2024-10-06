extends Node3D

signal start_cutscene(cutsceneID)

#the side we are on, and the side we are throwing the cats to
var currentSide = "B"
var goalSide = "A"

#initialize the cat checkers
var current = null
var goal = null

#initialize scoring variables
var score = 0
var canScore = true

#initialize the level tracker
var level = -1

#amount of cats to get to other side
var catAmount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Cutscene.hide()
	$Cutscene/DialogueBox.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$MainMenu.show()
	$MainMenu/Menu.show()
	get_tree().paused = true
	
func start():
	$MainMenu.hide()
	$MainMenu/Menu.hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	next_level()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if the amount of cats in the goal yard is equal to the amount of cats, we can move to the next level
	if goal.catAmount == catAmount: 
		#going to need like a ten second timer here  that checks at the end if this condition is still true, and if so then goes to next level
		next_level()


#sets up the variables for the new level
func level_start():
	#grab the cat checkers
	current = find_child("CatChecker" + currentSide)
	goal = find_child("CatChecker" + goalSide)
	
	#spawn all the cats we need
	$CatSpawner.spawn_cats(catAmount, current)
	
	#the amount of cats on each side is automatically updated by the catchecker script (even at game start)
	
func score_points(value, multiplier, text):
	score += value * multiplier
	
	$Player.updateScore(score)
	$Player.scoreMessage(text)
	
# update all variables and take us to the next level
func next_level():
	#increment the level counter
	level +=1
	
	#update the amount of cats
	catAmount = $levelData.catAmount[level]
	
	#swap the cuurrent and goal sides
	var temp = currentSide
	currentSide = goalSide
	goalSide = temp
	find_child("CatChecker" + goalSide).goal = true
	find_child("CatChecker" + currentSide).goal = false
	
	#move the players position
	$Player.position = find_child("PlayerSpawnerSide" + currentSide).position
	
	#unhide obstacles/hazards
	for i in $levelData.unhideObstacles[level].size():
		find_child($levelData.unhideObstacles[level][i]).show()
		find_child($levelData.unhideObstacles[level][i]).get_child(0).get_child(0).disabled = false
	
	#activate obstacles/hazards
	for i in $levelData.activateObstacles[level].size():
		find_child($levelData.activateObstacles[level][i]).get_child(1).get_child(0).disabled = false
		
	#deactivate previous obstacles/hazards
	if level-1 != -1:
		for i in $levelData.activateObstacles[level-1].size():
			find_child($levelData.activateObstacles[level][i]).get_child(1).get_child(0).disabled = false
	
	#play level specific dialogue
	get_tree().paused = true
	$Cutscene.show()
	$Cutscene/DialogueBox.show()
	emit_signal("start_cutscene", level)
	
func end_cutscene():
	$Cutscene.hide()
	$Cutscene/DialogueBox.hide()
	get_tree().paused = false
	#start next level
	level_start()
