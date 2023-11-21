extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse
		animation_player.seek(0.1)
	animation_player.play("Air")


func physics_update(delta: float) -> void:
	var input_direction_x: float = player.get_direction()
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if Input.is_action_just_pressed("punch"):
		state_machine.transition_to("Punch", {prev_state = "Air"})

	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")

func reset_anim():
	if player.velocity.y <= 0:
		animation_player.stop()
		animation_player.play("Air")
