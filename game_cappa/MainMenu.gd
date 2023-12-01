extends Node2D

export var mainGameScene : PackedScene
export var madeByScene : PackedScene


func _on_New_Game_button_up():
	get_tree().change_scene(mainGameScene.resource_path)


func _on_Made_By_pressed():
	get_tree().change_scene(madeByScene.resource_path)
