extends Node3D

#preload the cat
var catPrefab = preload("res://cat.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#makes sure we have the correct amount of cats
func spawn_cats(catAmount, goal):
	#if we have enough cats, dont do anything
	if goal.catAmount == catAmount:
		pass
	
	#if we dont, make a cat
	var catInst = catPrefab.instantiate()
	catInst.global_transform.origin = goal.get_child(0).position
	add_sibling(catInst)
	goal.get_overlapping_bodies()
	print(goal.catAmount)
	
	#and then run this function again
	#spawn_cats(catAmount, goal)
	
