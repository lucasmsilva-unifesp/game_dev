extends Node2D

const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Characters/Enemies/SpawnExplosion.tscn")

const DOWN_ROCKS: PackedScene = preload("res://Rooms/Rock.tscn")

const ENEMY_SCENES: Dictionary = {
	"FLYING_CREATURE": preload("res://Characters/Enemies/Flying Creature/FlyingCreature.tscn"),
	#"MAGE_ESQUELETON": preload("res://Characters/Enemies/EsqueletoMaguinho/EsqueletoMaguinho.tscn")
}

var num_enemies: int

onready var tilemap: TileMap = get_node("Navigation2D/TileMapBack")
onready var entrance: Node2D = get_node("Entrance")
onready var rock_container: Node2D = get_node("Rocks")
onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
onready var player_detector: Area2D = get_node("PlayerDetector")


func _ready() -> void:
	num_enemies = enemy_positions_container.get_child_count()

	
func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_rocks()
	
	
func _open_rocks() -> void:
	for rock in rock_container.get_children():
		rock.open()


func _close_entrace() -> void:
	var rock_down: StaticBody2D = DOWN_ROCKS.instance()
	rock_down.close()


func _spawn_enemies() -> void:
	for enemy_position in enemy_positions_container.get_children():
		var enemy = ENEMY_SCENES.FLYING_CREATURE.instance()
			
		var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
		enemy.position = enemy_position.position
		call_deferred("add_child", enemy)
		
		var spawn_explosion: AnimatedSprite = SPAWN_EXPLOSION_SCENE.instance()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)


func _on_Area2D_body_entered(_body: KinematicBody2D) -> void:
	player_detector.queue_free()
	#_close_entrace()
	var tempo = 10
	_spawn_enemies()
	#while(true):
	#	_spawn_enemies()
	#	yield(get_tree().create_timer(tempo), "timeout")
	#	if tempo > 2:
	#		tempo = tempo - 1


func _on_Timer_timeout():
	_spawn_enemies()


func _on_PlayerDetectorExit_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if (area.get_name() == "Area2DPlayer"):
		get_tree().change_scene("res://Arena/Arena2.tscn")
