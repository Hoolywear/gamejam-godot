# Character that moves and jumps.
class_name Player
extends KinematicBody2D

# Horizontal speed in pixels per second.
export var speed := 500.0
# Vertical acceleration in pixel per second squared.
export var gravity := 3500.0
# Vertical speed applied when jumping.
export var jump_impulse := 1200.0

var velocity

onready var fsm := $StateMachine
onready var label := $Label
onready var sprite := $AnimatedSprite


func _process(_delta: float) -> void:
	label.text = fsm.state.name + " " + str(velocity.y)

func get_direction():
	var direction: float = (
		Input.get_action_strength("right")
		- Input.get_action_strength("left")
	)
	
	if (Input.is_action_pressed("left")):
		sprite.flip_h = true
	elif (Input.is_action_pressed("right")):
		sprite.flip_h = false
	
	return direction
