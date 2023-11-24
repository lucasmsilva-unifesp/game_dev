extends Character

onready var sword: Node2D = get_node("Sword")
onready var sword_hitbox: Area2D = get_node("Sword/Node2D/Sprite/Hitbox")
onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer")
onready var dash_timer: Timer = get_node("DashTimer")

### Dash
var dashing = false
var dash_direction: Vector2 = Vector2.ZERO
const DASH_SPEED = 400
const DASH_TIME = 0.2


func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		
	sword.rotation = mouse_direction.angle()
	sword_hitbox.knockback_direction = mouse_direction
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1
		
	if dashing:
		position += mov_direction * DASH_SPEED * _delta
	else:
		get_input()
		if dashing and Input.is_action_just_pressed("ui_dash"):
			start_dash()


func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
		
	if Input.is_action_just_pressed("ui_attack") and not sword_animation_player.is_playing():
		sword_animation_player.play("attack")
		
	if Input.is_action_just_pressed("ui_dash") and not dashing:
		start_dash()
		

func start_dash() -> void:
	if mov_direction != Vector2.ZERO:
		dash_direction = mov_direction.normalized()
		dashing = true
		dash_timer.start(DASH_TIME)


func _on_DashTimer_timeout() -> void:
	dashing = false
	dash_timer.stop()  # Certifique-se de que o timer é interrompido ao finalizar o dash
	mov_direction = Vector2.ZERO


func is_dashing() -> bool:
	return dashing
