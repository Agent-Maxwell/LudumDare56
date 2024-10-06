extends Area3D

#if something has touched this buunding box, it is definitley a cat, and it is now ut of bounds
func _on_body_entered(body):
	#so we deccrement the score
	$"..".score_points(-100, 1, "Out of Bounds!")
	#and there is now oone less meowmeow
	$"..".catAmount-=1
