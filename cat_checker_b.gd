extends Area3D

var catAmount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


#returns the amount of cats
func cat_amount():
	return catAmount

#if a cat enters, increment tehe cat count by 1
func _on_body_entered(body):
	catAmount +=1
	print(catAmount)

#if a cat exits, decrement the cat count by 1
func _on_body_exited(body):
	catAmount -=1
