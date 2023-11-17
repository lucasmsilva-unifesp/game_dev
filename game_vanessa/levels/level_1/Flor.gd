extends Area2D

var clicked = false
var change = true

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position.x = 170
	global_position.y = 350


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if clicked:
		global_position = get_global_mouse_position()
	if change:
		global_position.x = 170
		global_position.y = 350


func _on_Button_pressed():
	if change:
		clicked = true
		change = false
	else:
		clicked = false
		change = true
	
