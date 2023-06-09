extends CharacterBody2D
signal hit

@export var move_speed : float = 130
var bullet_path = preload("res://src/game_objects/bullet.tscn")
var is_dead
var is_moving

func start(pos):
	position = pos
	Global.score = 0
	show()
	$CollisionShape2D.disabled = false
	$Sprite2D.look_at(get_global_mouse_position())
	
func _physics_process(delta):
	var is_attacking = false
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	if Input.is_action_just_pressed("attack") and $ShootCooldown.is_stopped() or Input.is_action_pressed("attack") and $ShootCooldown.is_stopped():
		$ShootSound.play()
		shoot()
	
	velocity = input_direction * move_speed
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * move_speed
		is_moving = true
	else:
		is_moving = false
		
	if(is_moving):
		$AnimatedSprite2D.play("run")
		
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
	# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif is_dead:
		$AnimatedSprite2D.animation = "death"
	else:
		$AnimatedSprite2D.animation = "idle"
	
	
	position += velocity * delta
	move_and_slide()
#	
	$Sprite2D.look_at(get_global_mouse_position())
	
	$Node2D.look_at(get_global_mouse_position())
func shoot():
	var bullet = bullet_path.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	bullet.velocity = get_global_mouse_position() - bullet.position 
	$ShootCooldown.start()

func _on_hurtbox_area_entered(area):
	if(area.name == "Hitbox"):
		$CollisionShape2D.set_deferred(&"disabled", true)
		is_dead = true
		hit.emit()
		await get_tree().create_timer(0.8).timeout
		queue_free() 
