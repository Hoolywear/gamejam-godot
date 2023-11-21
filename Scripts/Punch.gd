extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimationPlayer = get_node(_animation_player)

var prev_state

func enter(msg := {}) -> void:
	animation_player.play("Punch")
	prev_state = msg.get("prev_state")

func physics_update(delta: float) -> void:
	if prev_state != "Air" or player.is_on_floor():
		player.velocity.x = 0
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func exit_punch():
	state_machine.transition_to(prev_state)
