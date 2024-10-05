extends CharacterBody3D


@onready var grabSprite = $CanvasLayer/HandBase/AnimatedSprite2D
@onready var rayCast = $RayCast3D
@onready var grabSound = $CatGrabSound


const SPEED = 5.0
const MOUSE_SENS = .02
const JUMP_VELOCITY = 4.5

var can_grab = true
var failed = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	grabSprite.animation_finished.connect(grab_animation_done)
	$CanvasLayer/FailScreen/Panel/Button.button_up.connect(restart)

func _input(event):
	if failed:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		rotation_degrees.x -= event.relative.y * MOUSE_SENS
	
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if failed:
		return
	if Input.is_action_just_pressed("grab"):
		grab()

	

func _physics_process(delta: float) -> void:
	if failed:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func restart():
	get_tree().reload_current_scene()
		
func grab():
	if !can_grab:
		return
	can_grab = false
	grabSprite.play("grab")
	grabSound.play()
	#if rayCast.isColliding() and rayCast.getCollider().has_method("grabbed"):
	#	rayCast.getCollider().grab()

func grab_animation_done():
	can_grab = true
	grabSprite.play("idle")
	
func fail():
	failed = true
	$CanvasLayer/FailScreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
