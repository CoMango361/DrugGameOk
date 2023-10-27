extends KinematicBody2D

const SPEED = 670
const ACCELERATION = 99999
const FRICTION = 99999
const JUMP_FORCE = 1200

enum {
	MOVE,
	DEAD,
	STILL
}

var state
var velocity = Vector2.ZERO
var is_jumping = false

func _ready():
	state = MOVE

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)

		DEAD:
			velocity = Vector2.ZERO

		STILL:
			velocity = Vector2.ZERO

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	# Check if the player presses the Space bar ("ui_up") and is on the floor
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -JUMP_FORCE  # Apply an upward velocity for the jump

	#velocity.y += 2000 * delta  # Apply vertical gravity for falling
	#velocity.x -= 4000  * delta  # Apply horizontal gravity to simulate falling leftward

	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(_area):
	self.position.x = 484
	self.position.y = 293
