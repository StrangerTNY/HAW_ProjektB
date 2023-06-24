extends Node

@export var mob_scene: PackedScene
@export var mob2_scene: PackedScene
var mobTimer = 2
var slime_max_speed = 300.0
var slime_min_speed = 100.0
var slime2_max_speed = 300.0
var slime2_min_speed = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$Backgroundmusic.play(Global.backgroundmusic_position)

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
	$IncreaseSpawn.start()
	$HUD.show_startscreen("Dodge and defeat the slimes to earn a high score!")	
	get_tree().call_group("mobs", "queue_free")
	await get_tree().create_timer(20).timeout
	$Mob2Timer.start()
	$IncreaseSpawn.start()
	$IncreaseDifficulty.start()

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
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(slime_min_speed, slime_max_speed), 0.0)
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

 # Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)


	if(Global.score > 120 && $Player):
		direction = ($Player.global_position - mob.position).normalized()
		mob.linear_velocity = velocity.rotated(direction.angle())
	else:
		mob.linear_velocity = velocity.rotated(direction)
	
	
	add_child(mob)
	


func _on_increase_spawn_timeout():
	if($MobTimer.wait_time >= 0.1):
		$MobTimer.wait_time -= 0.4


func _on_mob_2_timer_timeout():
	var mob2 = mob2_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to a random location.
	mob2.position = mob_spawn_location.position
	# Set the mob's direction perpendicular to the path direction.
	var dir = mob_spawn_location.rotation + PI / 2
	var velocity = Vector2(randf_range(slime2_min_speed, slime2_max_speed), 0.0)
	if($Player):
		dir = ($Player.global_position - mob2.position).normalized()
		mob2.linear_velocity = velocity.rotated(dir.angle())
	else:
		mob2.linear_velocity = velocity.rotated(dir)
	
	add_child(mob2)


func _on_increase_difficulty_timeout():
	slime_max_speed += 50
	slime_min_speed += 10
	slime2_max_speed += 20
	slime2_min_speed += 5
