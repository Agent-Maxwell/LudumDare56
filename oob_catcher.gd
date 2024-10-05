extends Area3D

func _on_body_exited(body):
		$"..".score_points(-100, 1)
