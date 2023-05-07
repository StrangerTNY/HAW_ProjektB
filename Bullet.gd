extends Area2D


var velocity = Vector2(1, 0)
@export var speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	position += velocity.normalized() * speed * delta







func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hurtbox_area_entered(area):
	queue_free()
