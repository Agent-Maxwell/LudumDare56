extends Area3D

#if something has touched this bounding box, it is definitley a cat, and it is now out of bounds
func _on_body_entered(body):
	#so we deccrement the score
	$"..".score_points(-100, 1, "Out of Bounds! (-100)")
	#and there is now one less meowmeow
	$"..".catAmount-=1
