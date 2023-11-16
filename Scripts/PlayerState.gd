extends KinematicBody2D

export var speed := 100
export var fall_speed = 100
var velocity: Vector2
var input_direction

var is_punching: bool = false

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):

	get_input()
	
	if not is_on_floor():
		velocity.y = fall_speed
	
	if not is_punching:
		move_and_slide(velocity)
	
	if Input.is_action_pressed("punch"):
		is_punching = true
	
	set_animation()


#gestione animazioni
func set_animation() -> void:
	if input_direction.length() > 0 and not is_punching:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = input_direction.x < 0
	elif is_punching:
		$AnimatedSprite.animation = "punch"
		yield($AnimatedSprite,"animation_finished")
		is_punching = false
	else:
		$AnimatedSprite.animation = "idle"
