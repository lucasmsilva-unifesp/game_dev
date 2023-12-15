extends Enemy
class_name FlyingCreature, "res://Assets/enemies/flying creature/fly_anim_f0.png"

onready var hitbox: Area2D = get_node("Hitbox")

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
