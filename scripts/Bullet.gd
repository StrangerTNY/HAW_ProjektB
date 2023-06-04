extends Area2D

var velocity = Vector2(1,0)
var speed = 700

func _physics_process(delta):
	position += velocity.normalized() * delta *speed
