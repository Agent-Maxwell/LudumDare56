extends RigidBody3D

#set up scoring variables
var score = 0
var multiplier = 1

@onready var groundRay = $GroundRayCast
var state
var prevVelocity # to detect bounce collision speed, need to compare current vel with prev vel

#track whether we have been kicked or grabbed (or both)
var beenKicked = false
var beenGrabbed = false

#@onready var throw_meow = $ThrowMeow

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state("airborne")
	prevVelocity = linear_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if we have been kicked and grabbed
	if beenGrabbed and beenKicked:
		#weve been dropkicked, awesome!
		multiplier+=1
		beenKicked = false
		beenGrabbed = false
		

func _physics_process(delta):
	# Bounce logic
	var deltaV = (linear_velocity - prevVelocity).length() # deltaV = change in velocity since last physics step
	if state == "airborne": #if airborne:
		if deltaV > 1: #if there was a collision,
			if deltaV > 20: #if it was fast, play bounce sound;
				$Bounce.play()
			else: #if it was slow, play soft impact sound,
				$SoftImpact.play()
				if groundRay.is_colliding(): #and if it was slow AND on the ground, land
					set_state("grounded")
	prevVelocity = linear_velocity
	
	if state == "grounded": # destroy upwards vertical velocity while grounded
		linear_velocity.y = min(linear_velocity.y, 0)
	
	print(state)

# player be like "what am i holding now"
func type():
	return "cat"

# player be like "ok thx ur done"
func grabbed():
	queue_free()
	
func resetScore():
	score = 0
	multiplier = 1

#meow when kicked or thrown
func launch_meow():
	$ThrowMeow.play()

#func _on_body_entered(body):
	#pass

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
