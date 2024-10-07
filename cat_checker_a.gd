extends Area3D

var catAmount = 0
var goal = false

#returns the amount of cats
func cat_amount():
	return catAmount

#if a cat enters, increment tehe cat count by 1
func _on_body_entered(body):
	catAmount +=1
	
	#if this is the goal
	if goal:
		#give the catt some score
		body.score +=100
		#score it
		$"..".score_points(body.score, body.multiplier, "Cat Scored! Total " + str(body.score))
		#then stop it
		body.set_state("grounded")
		#body.linear_velocity = Vector3(0,0,0)

#if a cat exits, decrement the cat count by 1
func _on_body_exited(body):
	catAmount -=1
