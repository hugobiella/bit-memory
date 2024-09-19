extends CharacterBody2D

const ACCELERATION = 10000
const MAX_SPEED = 500

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector == Vector2.ZERO:
		velocity = Vector2.ZERO
		sprite.play("idle")
	else:
		apply_movement(input_vector * ACCELERATION * delta)
		move_and_slide()
		if abs(input_vector.x) > abs(input_vector.y):
			if input_vector.x > 0:
				sprite.play("run_right")
			else:
				sprite.play("run_left")
		else:
			if input_vector.y > 0:
				sprite.play("run_down")
			else:
				sprite.play("run_up")

func apply_movement(amount) -> void:
	#print(velocity)
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)
