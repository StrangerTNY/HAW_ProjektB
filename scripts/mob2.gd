extends RigidBody2D

var got_shot = false
var hp
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()
	hp = 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(got_shot):
		$AnimatedSprite2D.animation = "death"
		$AnimatedSprite2D.play()

func _on_hurtbox_area_entered(hitbox):
	if(hitbox.name.contains("Bullet")):
		if(hp <= 1):
			Global.score += 5
			$CollisionShape2D.set_deferred(&"disabled", true)
			got_shot = true
			$DeathSound.play()
			await get_tree().create_timer(0.5).timeout
			queue_free()
	hp -= 1
		

