extends Area2D

onready var anim = $AnimatedSprite
export var speed = 600


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("fireball")


func _physics_process(delta):
	move_and_collide(Vector2(0, speed) * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
