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
func spawn_cats(catAmount, current):
	#if we have enough cats, dont do anything
	if current.catAmount == catAmount:
		pass
	
	#if we dont, make enough cats
	for i in catAmount - current.catAmount+1:
		var catInst = catPrefab.instantiate()
		catInst.global_transform.origin = current.get_child(0).position
		add_sibling(catInst)
	
