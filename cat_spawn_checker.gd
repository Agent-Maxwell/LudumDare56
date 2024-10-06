extends RigidBody3D

var colliding = false

func _on_body_entered(body):
	colliding = true
