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
	for i in catAmount - current.catAmount:
		var catInst = catPrefab.instantiate()
		#set the base positon to the middle of the yard
		catInst.global_transform.origin = current.get_child(0).position
		#increase the height a tad
		catInst.position.y += 2
		#place it randomly along the x and y axis
		catInst.position.x += randi_range(current.get_child(0).shape.size[0]/2 -1, -current.get_child(0).shape.size[0]/2 +1)
		catInst.position.z += randi_range(current.get_child(0).shape.size[2]/2 -1, -current.get_child(0).shape.size[2]/2 +1)
		#if the cat is colliding with anything, delete it and run this again
		#if catInst:
		#	catInst.queue_free()
		#	i+=1
		add_sibling(catInst)
	
