extends MeshInstance3D

func _on_area_3d_body_entered(body):
	$"../..".score_points(-300, 1, "Wet Cat!!!!!!")
	body.linear_velocity = Vector3(randf_range(-5, 5),randf_range(4, 20),randf_range(-5, 5))
