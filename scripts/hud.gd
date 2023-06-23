extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$Endcard.hide()
	$Pausescreen.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_score(score):
	$ScoreLabel.text = str(score)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	$ScoreLabel.hide()
	$Endcard/FinalScore.text = "Score: \n" + $ScoreLabel.text
	$Message.hide()
	$Endcard.show()
	
	
func _on_message_timer_timeout():
	$Message.hide()


func _on_restart_button_pressed():
	$ConfirmSound.play()
	await get_tree().create_timer(0.35).timeout
	get_tree().change_scene_to_file("res://src/scenes/test_level_2.tscn")


func _on_quit_button_pressed():
	$QuitSound.play()
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()


func _on_resume_button_pressed():
	$ResumeSound.play()
	await get_tree().create_timer(0.35).timeout
	$Pausescreen.hide()
	get_tree().paused = false

func showPausescreen():
	$Pausescreen.show()


func _on_back_to_menu_pressed():
	$ConfirmSound.play()
	await get_tree().create_timer(0.35).timeout
	$Pausescreen.hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/scenes/menu.tscn")
