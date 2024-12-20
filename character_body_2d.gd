extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D
var jump_count=0
var max_jumps= 10000000000000000
func _process(_delta):
	if Input.is_action_pressed("ui_left"):
		_animated_sprite.play("jump_1")
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("jump_1")
		$AnimatedSprite2D.flip_h = false
	else:
		_animated_sprite.stop()

const SPEED = 400.0
const JUMP_VELOCITY = -3000.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor():
		jump_count = 0


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
