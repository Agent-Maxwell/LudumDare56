extends Area3D

func _on_body_entered(body):
	$"..".score_points(-100, 1, "Out of Bounds!")
	$"..".catAmount-=1
