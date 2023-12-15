extends Hitbox

var enemy_exited: bool = false

var direction: Vector2 = Vector2.ZERO
var fireball_speed: int = 0

func launch(inicial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = inicial_position
	direction = dir
	knockback_direction = dir
	fireball_speed = speed
	
	rotation += dir.angle() + PI/4
	

func _physics_process(delta: float) -> void:
	position += direction * fireball_speed * delta



func _on_FireBall_body_exited(body: KinematicBody) -> void:
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)
		

func _collide(body: KinematicBody2D) -> void:
	if enemy_exited:
		if body != null:
			body.take_damage(damage, knockback_direction, knockback_force)
		queue_free()
