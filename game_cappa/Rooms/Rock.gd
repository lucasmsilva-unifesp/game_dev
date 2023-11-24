extends StaticBody2D

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func close() -> void:
	animation_player.play("Down")

func open() -> void:
	animation_player.play("Destroyed")
