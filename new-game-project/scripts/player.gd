extends CharacterBody2D

var pickup_offset  # package position
var carrying_object = null

const ACCELERATION = 10000
const MAX_SPEED = 500

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	move(delta)
	
	if carrying_object:
		carrying_object.position = global_position + pickup_offset

func move(delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector == Vector2.ZERO:
		velocity = Vector2.ZERO
		sprite.play("idle")
		pickup_offset = Vector2(0, -100)
	else:
		apply_movement(input_vector * ACCELERATION * delta)
		move_and_slide()
		if abs(input_vector.x) > abs(input_vector.y):
			if input_vector.x > 0:
				sprite.play("run_right")
				pickup_offset = Vector2(100, 0)
			else:
				sprite.play("run_left")
				pickup_offset = Vector2(-100, 0)
		else:
			if input_vector.y > 0:
				sprite.play("run_down")
				pickup_offset = Vector2(0, 100)
			else:
				sprite.play("run_up")
				pickup_offset = Vector2(0, -100)

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func pickup_object(object: RigidBody2D):
	carrying_object = object
	object.get_parent().remove_child(object)
	get_parent().add_child(object)
	carrying_object.position = global_position + pickup_offset

func drop_object():
	if carrying_object:
		carrying_object.get_parent().remove_child(carrying_object)
		get_parent().add_child(carrying_object)
		#carrying_object.position = global_position + pickup_offset
		carrying_object = null
