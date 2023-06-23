extends CharacterBody2D
signal hit

@export var move_speed : float = 130
var bullet_path = preload("res://src/game_objects/bullet.tscn")
var is_dead

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
	if Input.is_action_just_pressed("attack"):
		shoot()
	
	velocity = input_direction * move_speed
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * move_speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.play()
		

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_v = false
	# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "run"
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

func _on_hurtbox_area_entered(area):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().name.contains("Mob")):
			$CollisionShape2D.set_deferred(&"disabled", true)
			is_dead = true
			hit.emit()
			await get_tree().create_timer(0.7).timeout
			queue_free() 
