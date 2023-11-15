extends PlayerState

func enter(msg := {}) -> void:
	player.sprite.animation = "punch"
	yield(player.sprite,"animation_finished")
	state_machine.transition_to(msg.get("prev_state"))
