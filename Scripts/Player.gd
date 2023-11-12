extends KinematicBody2D

export var speed := 100
export var fall_speed = 100
var velocity: Vector2
var input_direction

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):

	get_input()
	
	if not is_on_floor():
		velocity.y = fall_speed
	
	move_and_slide(velocity)
	
	set_animation()


#gestione animazioni
func set_animation() -> void:
	if input_direction.length() > 0 :
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = input_direction.x < 0
	else:
		$AnimatedSprite.animation = "idle"
