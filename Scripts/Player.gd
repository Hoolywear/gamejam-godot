extends KinematicBody2D

export var speed := 100
var velocity: Vector2

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):

	get_input()
	
	if not is_on_floor():
		velocity.y = 100
	
	move_and_slide(velocity)
