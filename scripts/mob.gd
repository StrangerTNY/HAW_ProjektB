extends RigidBody2D

var hit_wall
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hurtbox_area_entered(hitbox):
	queue_free() 


#func _on_body_entered(body):
#	if(body.name == "map_2"):
#		hit_wall = true
#	hit_wall = false
