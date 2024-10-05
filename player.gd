extends CharacterBody3D

@onready var anim_player = $CanvasLayer/HUD/AnimationPlayer
@onready var myRayCast = $Face/RayCast3D
@onready var kickHitbox = $ShapeCast3D
@onready var grabSound = $CatGrabSound

# mouse/movement stuff
const SPEED = 5.0
const SPEED_WHILE_CHARGING = 3.0
const MOUSE_SENS = .06
const JUMP_VELOCITY = 4.5
const KICK_ANGLE = 45
const KICK_VELOCITY = 10

var can_grab = true
var holding = ""
var charging = false
var charge_time = 0.0
var failed = false

var catPrefab = preload("res://cat.tscn")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # gimme dat
	#anim_player.on_animation_player_animation_finished("pickup").connect(grab_animation_done)
	#anim_player.on_animation_player_animation_finished("pickup_whiff").connect(grab_animation_done)
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
	if Input.is_action_just_released("click_action"):
		click_release_action()
	if Input.is_action_just_pressed("kick"):
		kick()
	
	# if charging, tick up charge time (to max of 2 sec)
	if charging == true:
		charge_time = move_toward(charge_time, 2, delta)


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
	
	var current_speed
	if (charging):
		current_speed = SPEED_WHILE_CHARGING
	else:
		current_speed = SPEED
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	# velocity -> actually move
	move_and_slide()
	
func restart():
	get_tree().reload_current_scene()

func click_action():
	if (holding == ""): # if hand is empty, attempt a grab
		grab()
	elif (holding == "cat"): # if hand is full (of cat), throw the cat
		can_grab = false
		charging = true
		anim_player.play("charge_throw")
		

# called when click action is released; for throwing after charge up
func click_release_action():
	if charging == true:
		charging = false
		# setup cat instance
		var catInst = catPrefab.instantiate()
		var spawn_position = $Face.global_transform.origin + -$Face.global_transform.basis.z * 1 # face location + (face's forward vector * some distance)
		catInst.global_transform.origin = spawn_position
		print(charge_time * 5)
		#print(velocity.length())
		catInst.linear_velocity = -$Face.global_transform.basis.z * charge_time * 6 + velocity # set velocity to face's forward vector * throw speed
		charge_time = 0 #reset charge time for next charge
		add_sibling(catInst) # it appears...
		holding = "" # my hand is empty now ???!!
		anim_player.play("throw")
	
	

func grab():
	if !can_grab: # if pickup/throw animation is already playing, dont initiate another
		return
	can_grab = false
	grabSound.play()
	# if line of sight with a grabbable object, run its grab function and set 'holding' to its type
	if myRayCast.is_colliding() and myRayCast.get_collider().has_method("grabbed"):
		holding = myRayCast.get_collider().type()
		myRayCast.get_collider().grabbed()
		anim_player.play("pickup")
	else:
		anim_player.play("pickup_whiff")

# when grab animation finishes, we are clear for another grab (this is connected to the animation signal in _ready)
#func grab_animation_done():
	#print("animation done signal receieved")
	#can_grab = true
	#if (holding == ""):
		#anim_player.play("idle")
	#elif (holding == "cat"):
		#anim_player.play("idle_cat")
	
func kick():
	if kickHitbox.is_colliding():
		for i in kickHitbox.get_collision_count():
			var start_speed = kickHitbox.get_collider(i).linear_velocity.length()
			print(start_speed)
			kickHitbox.get_collider(i).linear_velocity = -global_transform.basis.z.rotated(global_transform.basis.x, KICK_ANGLE) * (KICK_VELOCITY + start_speed)
			#(-global_transform.basis.z + Vector3(0, 1, 0)) * 10

# you fail
func fail():
	failed = true
	$CanvasLayer/FailScreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "pickup" || anim_name == "pickup_whiff" || anim_name == "throw":
		can_grab = true
		if (holding == ""):
			anim_player.play("idle_empty")
		elif (holding == "cat"):
			anim_player.play("idle_cat")
	
	# want to wait on the last frame of charge until the throw happens
	if anim_name == "charge_throw":
		pass
