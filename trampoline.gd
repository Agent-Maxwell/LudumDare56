extends MeshInstance3D

func _on_area_3d_body_entered(body):
	$"../..".score_points(-100, 1, "Trampoline!")
	body.linear_velocity = Vector3(-20,10,0)
