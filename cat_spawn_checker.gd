extends Area3D

var colliding = false

func _on_body_entered(body):
	colliding = true

func isColliding(instPosition):
	
	position = Vector3(0,100,0)
	
	colliding = false
	
	position = instPosition
	
	return colliding
