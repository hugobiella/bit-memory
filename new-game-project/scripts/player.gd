extends CharacterBody2D

var pickup_offset  # package position
var carrying_object = null
const ACCELERATION = 10000

@onready var sprite = $AnimatedSprite2D
@onready var particles = $Walking
@onready var camera = $Camera2D  # Referência ao Camera2D

func _physics_process(delta):
	move(delta)
	update_camera_position(delta)  # Atualiza a posição da câmera
	if carrying_object && Globals.package_exploded == false:
		update_carried_object_position()

func move(delta):
	if Globals.lock_player == false:
		var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input_vector == Vector2.ZERO:
			velocity = Vector2.ZERO
			sprite.play("idle")
			particles.stop_particles()
		else:
			apply_movement(input_vector * ACCELERATION * delta)
			move_and_slide()
			particles.start_particles()
			update_sprite_animation(input_vector)

func update_sprite_animation(input_vector: Vector2):
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

func update_carried_object_position():
	var mouse_position = get_global_mouse_position()
	carrying_object.position = global_position + (mouse_position - global_position).normalized() * 90
	carrying_object.look_at(mouse_position)

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(Globals.MAX_SPEED)

func pickup_object(object: RigidBody2D):
	Globals.package_exploded = false
	carrying_object = object
	object.get_parent().remove_child(object)
	get_parent().add_child(object)

func drop_object():
	if carrying_object:
		carrying_object.get_parent().remove_child(carrying_object)
		get_parent().add_child(carrying_object)
		carrying_object = null

func update_camera_position(delta):
	if Globals.lock_player:
		return
	var mouse_position = get_global_mouse_position()
	var target_position = global_position.lerp(mouse_position, 0.3)
	camera.position = camera.position.lerp(target_position - global_position, 0.1)
