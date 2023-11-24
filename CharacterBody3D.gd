extends CharacterBody3D

const SPEED = 10.0
const ACCEL = 0.5
const LERP_VAL = 0.15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var armature = $Armature
@onready var animtree = $AnimationTree

func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _physics_process(delta):
	# Add the gravity...may not need
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# to add rotation to proper direction
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCEL)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, ACCEL)
		# set look direction
		var look_dir = Vector2(direction.z, direction.x)
		armature.rotation.y = lerp(armature.rotation.y, look_dir.angle(), 0.25)
		#armature.rotation.y = look_dir.angle()
	else:
		velocity.x = move_toward(velocity.x, 0, ACCEL)
		velocity.z = move_toward(velocity.z, 0, ACCEL)
	
	animtree.set("parameters/BlendSpace1D/blend_position", velocity.length() / SPEED)
	
	move_and_slide()
