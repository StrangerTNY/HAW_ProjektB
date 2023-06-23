extends Node

@export var mob_scene: PackedScene
var score
var mobTimer = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Pause")):
		$PauseSound.play()
		await get_tree().create_timer(0.3).timeout
		get_tree().paused = true
		$HUD.showPausescreen()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()
	
func new_game():
	$Player.start($StartPosition2.position)
	$StartTimer.start()
	$HUD.show_message("Dodge and defeat the slimes to earn a high score!")	
	get_tree().call_group("mobs", "queue_free")

func _on_score_timer_timeout():
	Global.score += 1
	$HUD.update_score(Global.score)

func _on_start_timer_timeout():
	$MobTimer.set_wait_time(mobTimer)
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_mob_timer_timeout():
# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

 # Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)


	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(200.0, 600.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


