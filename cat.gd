extends RigidBody3D

#set up scoring variables
var score = 0
var multiplier = 1

#track whether we have been kicked or grabbed (or both)
var beenKicked = false
var beenGrabbed = false

#@onready var throw_meow = $ThrowMeow

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if we have been kicked and grabbed
	if beenGrabbed and beenKicked:
		#weve been dropkicked, awesome!
		multiplier+=1
		beenKicked = false
		beenGrabbed = false
		

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

#bounce sound plays if it bounces hard enough
func _on_body_entered(body):
	if (linear_velocity.length() > 10):
		$Bounce.play()
