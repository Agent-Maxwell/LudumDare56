extends MeshInstance3D

func _on_area_3d_body_entered(body):
	$"../..".score_points(-50, 1, "Leaf blower!")
	body.linear_velocity = body.linear_velocity + Vector3(-10,5,0)
