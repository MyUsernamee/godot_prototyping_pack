
extends CharacterBody2D

@export var speed: float = 200 # This is the speed of the player character in px/s
@export var jump_force: float = 400 # This is the force of the jump
@export var max_fall_speed: float = 1000 # This is the maximum fall speed of the player character

@export var gravity: float = 10 # This is the gravity of the player character in px/s^2

@export var air_control: float = 0.5 # This controls how much the player can move in the air (0.0 - 1.0)

@export var flip_h: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _process(_delta):
    if Engine.is_editor_hint():
        return
    do_animation()

func do_animation():
    if is_on_floor():

        if velocity.x != 0:
            animated_sprite.play("run")
        else:
            animated_sprite.play("idle")

    else:
        animated_sprite.play("fall")

    if velocity.x < 0:
        animated_sprite.flip_h = not flip_h # This flips the sprite horizontally if the player is moving left

func _physics_process(_delta):

    if Engine.is_editor_hint():
        return

    var target_velocity: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    target_velocity = target_velocity.normalized() * speed

    if is_on_floor():

        velocity.x = target_velocity.x

        if Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_up"):

            velocity.y = -jump_force

    else:

        velocity.x = lerp(velocity.x, target_velocity.x, air_control)

    velocity.y += gravity

    if velocity.y > max_fall_speed:

        velocity.y = max_fall_speed

    move_and_slide()
