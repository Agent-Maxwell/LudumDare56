extends MeshInstance3D

func _on_area_3d_body_entered(body):
	body.score += 300
	body.play_pos_points()
	$"../../Player".scoreMessage("Grill! (300)")
