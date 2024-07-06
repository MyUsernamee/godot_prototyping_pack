extends CharacterBody2D

@export var speed: float = 200 # Speed in pixels per second
@export var aim_at_mouse: bool = false
@export var aim_in_moving_direction: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):

	var target_velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed

	if aim_at_mouse:
		var mouse_pos = get_global_mouse_position()
		var direction = (mouse_pos - global_position).normalized()
		rotation = direction.angle()
	elif aim_in_moving_direction:
		if target_velocity.length() > 0:
			rotation = target_velocity.angle()
	else:
		rotation = 0

	velocity = target_velocity

	if velocity.length() > 0:
		sprite.play("run")
	else:
		sprite.play("idle")

	move_and_slide()

	
