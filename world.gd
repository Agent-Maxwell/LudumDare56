extends Node3D

#the side we are on, and the side we are throwing the cats to
var currentSide = "B"
var goalSide = "A"

#initialize the cat checkers
var current = null
var goal = null

#initialize the level tracker
var level = -1

#amount of cats to get to other side
var catAmount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE	
	var main_menu = get_node("Main_Menu")
	$Main_Menu.show()
	main_menu.start_game.connect(start_game)
	next_level()

#Called when someone presses the start button on the main menu
func start_game():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Main_Menu.hide()


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
	
	#move the players position
	$Player.position = find_child("PlayerSpawnerSide" + currentSide).position
	
	#unhide obstacles/hazards
	for i in $levelData.obstacles[level].size():
		find_child($levelData.obstacles[level][i]).show()
		find_child($levelData.obstacles[level][i]).get_child(0).get_child(0).disabled = false
	
	#play level specific dialogue
	
	
	#start the level
	level_start()
