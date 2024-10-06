extends MeshInstance3D

func _on_area_3d_body_entered(body):
	body.score += 100
	$"../../Player".scoreMessage("Fence Bounce!")
