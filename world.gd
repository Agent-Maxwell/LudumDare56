extends Node3D

#the side we are on, and the side we are throwing the cats to
var currentSide = "A"
var goalSide = "B"

#amount of cats to get to other side
var catAmount = 10




# Called when the node enters the scene tree for the first time.
func _ready():
	level_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#sets up the variables for the new level
func level_start():
	#grab the cat checkers
	var current = find_child("CatChecker" + currentSide) 
	var goal = find_child("CatChecker" + goalSide) 
	
	#the amount of cats on each side is automatically updated by the catchecker script (even at game start)
