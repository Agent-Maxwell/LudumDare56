extends Area3D

var catAmount = 0

#returns the amount of cats
func cat_amount():
	return catAmount

#if a cat enters, increment tehe cat count by 1
func _on_body_entered(body):
	catAmount +=1

#if a cat exits, decrement the cat count by 1
func _on_body_exited(body):
	catAmount -=1
