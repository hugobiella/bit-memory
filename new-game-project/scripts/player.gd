extends CharacterBody2D

const ACCELERATION = 10000
const MAX_SPEED = 800

func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		apply_movement(input_vector * ACCELERATION * delta)
	move_and_slide()

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)
