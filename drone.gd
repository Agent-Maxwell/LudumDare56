extends MeshInstance3D

func _on_area_3d_body_entered(body):
	$"../..".score_points(-50, 1, "Drone SuS! (-50)")
	body.linear_velocity = Vector3(5.5,35,0)
