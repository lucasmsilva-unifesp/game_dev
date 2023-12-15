extends KinematicBody2D
export (PackedScene) var Bullet

onready var anim = $Sprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("walk")


func shoot():
	var bullet = Bullet.instance()
	bullet.global_position = self.global_position
	get_parent().add_child(bullet)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
