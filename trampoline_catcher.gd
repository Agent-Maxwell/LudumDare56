extends MeshInstance3D

func _on_area_3d_body_entered(body):
	body.multiplier += 1
	body.play_pos_points()
	$"../../Player".scoreMessage("Redirected! (+1 mult)")
