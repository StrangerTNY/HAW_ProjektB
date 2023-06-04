extends RigidBody2D
signal hit_wall
signal slime_shot

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()
	$DespawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_hurtbox_area_entered(hitbox):
	if(hitbox.name.contains("Bullet")):
		slime_shot.emit()
	queue_free() 

func _on_despawn_timer_timeout():
	queue_free()
