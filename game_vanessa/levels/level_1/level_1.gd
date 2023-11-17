extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_sombra_1_area_entered(area):
	print('Relou')


func _on_sombra_3_area_entered(area):
	print('Perdeu otário')


func _on_sombra_2_area_entered(area):
	print('Perdeu otário')


func _on_sombra_4_area_entered(area):
	print('Perdeu otário')
