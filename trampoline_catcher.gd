extends MeshInstance3D

func _on_area_3d_body_entered(body):
	body.multiplier += 1
	$"../../Player".scoreMessage("Redirected! (*1)")
