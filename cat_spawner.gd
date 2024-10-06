extends Node3D

#preload the cat
var catPrefab = preload("res://cat.tscn")

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
		catInst.position.x += randf_range(current.get_child(0).shape.size[0]/2 -1, -current.get_child(0).shape.size[0]/2 +1)
		catInst.position.z += randf_range(current.get_child(0).shape.size[2]/2 -1, -current.get_child(0).shape.size[2]/2 +1)
		
		#check if the cat would collide with anything
		if $CatSpawnChecker.isColliding(catInst.position):
			i+=1
		else:
			add_sibling(catInst)
	
