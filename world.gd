extends Node3D

signal start_cutscene(cutsceneID)
signal start_letter_animation

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
	$Options.hide()
	$Cutscene/DialogueBox.hide()
	$NoteReader.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$PauseMenu.hide()
	$MainMenu.show()
	$MainMenu/Menu.show()
	get_tree().paused = true
	$PauseSoundtrack.play()
	
#Occurs after someone hits "start" on the main menu. Activates note reader
func start():
	$NoteReader.show()
	emit_signal("start_letter_animation")

	
func _on_note_reader_first_note_finished() -> void:
	$NoteReader.hide()
	$MainSoundtrack.play($PauseSoundtrack.get_playback_position())
	$MainMenu.hide()
	$MainMenu/Menu.hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	next_level()

func _on_note_reader_second_note_finished() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Cutscene.show()
	$Cutscene/DialogueBox.show()
	$NoteReader.hide()
	emit_signal("start_cutscene", level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		$PauseMenu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
		$PauseSoundtrack.play($MainSoundtrack.get_playback_position())
	#if the amount of cats in the goal yard is equal to the amount of cats, we can move to the next level
	if goal.catAmount == catAmount: 
		#wait a bit to actually end the level
		catAmount +=1
		$Player.scoreMessage("Level Complete!!")
		await get_tree().create_timer(5.0).timeout
		
		#Checks for ending cutscene
		if(level == 8):
			$Cutscene.show()
			$Cutscene/DialogueBox.show()
			$PauseSoundtrack.play($MainSoundtrack.get_playback_position())
			get_tree().paused = true
			emit_signal("start_cutscene", 9)
		else:
			next_level()


func _on_pause_menu_unpause() -> void:
	$MainSoundtrack.play($PauseSoundtrack.get_playback_position())
	$PauseMenu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false

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
	if value > 0:
		$CatScoredSound.play()
	else:
		$NegativePointsSound.play()
	
	$Player.updateScore(score)
	$Player.scoreMessage(text)
	
# update all variables and take us to the next level
func next_level():
	
	#deactivate/hide previous obstacles/hazards
	if (level) != -1:
		for i in $levelData.activateObstacles[level].size():
			find_child($levelData.activateObstacles[level][i]).get_child(1).get_child(0).disabled = true
		for i in $levelData.unhideObstacles[level].size():
			find_child($levelData.unhideObstacles[level][i]).hide()
			if(!$levelData.unhideObstacles[level][i].ends_with("Fence")):
				find_child($levelData.unhideObstacles[level][i]).get_child(0).get_child(0).disabled = true
	
	#increment the level counter
	level +=1
	print(level)
	
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
		print($levelData.unhideObstacles[level][i])
		find_child($levelData.unhideObstacles[level][i]).show()
		if(!$levelData.unhideObstacles[level][i].ends_with("Fence")):
			find_child($levelData.unhideObstacles[level][i]).get_child(0).get_child(0).disabled = false
	
	#activate obstacles/hazards
	for i in $levelData.activateObstacles[level].size():
		find_child($levelData.activateObstacles[level][i]).get_child(1).get_child(0).disabled = false
		
	
	
	#play level specific dialogue
	get_tree().paused = true
	$PauseSoundtrack.play($MainSoundtrack.get_playback_position())
	
	#Plays second note
	if(level == 1):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$NoteReader.show()
	else:
		$Cutscene.show()
		$Cutscene/DialogueBox.show()
		emit_signal("start_cutscene", level)
	
func end_cutscene():
	$MainSoundtrack.play($PauseSoundtrack.get_playback_position())
	$Cutscene.hide()
	$Cutscene/DialogueBox.hide()
	get_tree().paused = false
	#start next level
	level_start()

func _on_main_menu_open_options() -> void:
	$Options.show()
	
func _on_pause_menu_open_options() -> void:
	$Options.show()

func _on_options_apply_options() -> void:
	$Options.hide()
