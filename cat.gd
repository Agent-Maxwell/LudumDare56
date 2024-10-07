extends RigidBody3D

#set up scoring variables
var score = 0
var multiplier = 1

@onready var player = $"../Player"

@onready var groundRay = $GroundRayCast

@onready var positivePoints = $PositivePoints

var state
var prevVelocity # to detect bounce collision speed, need to compare current vel with prev vel

#track whether we have been kicked or grabbed (or both)
var beenKicked = false
var ignoreThat = false
var beenGrabbed = false

#@onready var throw_meow = $ThrowMeow

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state("airborne")
	prevVelocity = linear_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _physics_process(delta):
	# Bounce logic
	if !ignoreThat:
		var deltaV = (linear_velocity - prevVelocity).length() # deltaV = change in velocity since last physics step
		if state == "airborne": #if airborne:
			if deltaV > 1: #if there was a collision,
				if deltaV > 20: #if it was fast, bounce;
					player.scoreMessage("Bounce! (100)")
					score += 100
					positivePoints.play()
					$Bounce.play()
				elif deltaV > 10: #if it was medium, play soft impact sound,
					$SoftImpact.play()
					player.scoreMessage("Bonk! (50)")
					score += 50
					positivePoints.play()
					if groundRay.is_colliding(): #and if it was medium AND on the ground, land
						set_state("grounded")
				else:
					$SoftImpact.play()
					if groundRay.is_colliding(): #and if it was slow AND on the ground, land
						set_state("grounded")
	else:
		ignoreThat = false
	
	prevVelocity = linear_velocity
	
	if state == "grounded": # destroy upwards vertical velocity while grounded
		linear_velocity.y = min(linear_velocity.y, 0)

# player be like "what am i holding now"
func type():
	return "cat"

# player be like "ok thx ur done"
func grabbed():
	queue_free()
	
func resetScore():
	score = 0
	multiplier = 1

##meow when kicked or thrown
func launch_meow():
	$ThrowMeow.play()

#func _on_body_entered(body):
	#pass

func getKicked(kickDir, kickVel):
	linear_velocity = kickDir * (kickVel + linear_velocity.length()) #set velocity to correct direction, kick magnitute + current speed
	beenKicked = true
	ignoreThat = true
	set_state("airborne")
	launch_meow()
	#scoring
	if beenKicked and beenGrabbed:
		player.scoreMessage("Dropkick! (50)")
		score += 50
		positivePoints.play()

# manager for setting airborne/grounded state
func set_state(newState):
	state = newState
	if state == "grounded":
		linear_damp = 5
		physics_material_override.bounce = 0
		#if linear_velocity.length() < 2:
			#linear_velocity *= Vector3(0, 1, 0) #destroy all horizontal velocity
	elif state == "airborne":
		linear_damp = 0
		physics_material_override.bounce = 0.7
	else:
		print("error wtf is my state rn (-the cat)")
		
func play_pos_points():
	positivePoints.play()
