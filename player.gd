extends CharacterBody3D

@onready var grabSprite = $CanvasLayer/HandBase/AnimatedSprite2D
@onready var myRayCast = $Face/RayCast3D
@onready var grabSound = $CatGrabSound

# mouse/movement stuff
const SPEED = 5.0
const MOUSE_SENS = .06
const JUMP_VELOCITY = 4.5

var can_grab = true
var holding = ""
var failed = false

var catPrefab = preload("res://cat.tscn")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # gimme dat
	grabSprite.animation_finished.connect(grab_animation_done)
	$CanvasLayer/FailScreen/Panel/Button.button_up.connect(restart)

func _input(event):
	if failed:
		return
	# left/right rotation rotates entire player, up/down only rotates its "face" node
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		$Face.rotation_degrees.x -= event.relative.y * MOUSE_SENS
		
		# we must clamp vertical rotation
		if ($Face.rotation_degrees.x < -90):
			$Face.rotation_degrees.x = -90
		if ($Face.rotation_degrees.x > 90):
			$Face.rotation_degrees.x = 90
	
func _process(delta):
	
	# exit, restart, and click inputs
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if failed:
		return
	if Input.is_action_just_pressed("click_action"):
		click_action()
	if Input.is_action_just_pressed("kick"):
		kick()

	

func _physics_process(delta: float) -> void:
	if failed:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# wasd input -> velocity
	var input_dir := Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# velocity -> actually move
	move_and_slide()
	
func restart():
	get_tree().reload_current_scene()

func click_action():
	if (holding == ""): # if hand is empty, attempt a grab
		grab()
	elif (holding == "cat"): # if hand is full (of cat), throw the cat
		# setup cat instance
		var catInst = catPrefab.instantiate()
		var spawn_position = $Face.global_transform.origin + -$Face.global_transform.basis.z * 1 # face location + (face's forward vector * some distance)
		catInst.global_transform.origin = spawn_position
		catInst.linear_velocity = -$Face.global_transform.basis.z * 10 + velocity * 2# set velocity to face's forward vector * throw speed
		add_sibling(catInst) # it appears...
		holding = "" # my hand is empty now ???!!

func grab():
	if !can_grab: # if grab animation is already playing, dont initiate another
		return
	can_grab = false
	grabSprite.play("grab")
	grabSound.play()
	# if line of sight with a grabbable object, run its grab function and set 'holding' to its type
	if myRayCast.is_colliding() and myRayCast.get_collider().has_method("grabbed"):
		holding = myRayCast.get_collider().type()
		myRayCast.get_collider().grabbed()

# when grab animation finishes, we are clear for another grab (this is connected to the animation signal in _ready)
func grab_animation_done():
	can_grab = true
	grabSprite.play("idle")
	
func kick():
	pass

# you fail
func fail():
	failed = true
	$CanvasLayer/FailScreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
