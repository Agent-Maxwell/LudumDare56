extends Node3D

#the side we are on, and the side we are throwing the cats to
var currentSide = "A"
var goalSide = "B"

#initialize the cat checkers
var current = null
var goal = null

#amount of cats to get to other side
var catAmount = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	level_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if the amount of cats in the goal yard is equal to the amount of cats, we can move to the next level
	if goal.catAmount == catAmount:
		pass
	
#sets up the variables for the new level
func level_start():
	#grab the cat checkers
	current = find_child("CatChecker" + currentSide) 
	goal = find_child("CatChecker" + goalSide)
	
	#spawn all the cats we need
	$CatSpawner.spawn_cats(catAmount, goal)
	
	#the amount of cats on each side is automatically updated by the catchecker script (even at game start)
