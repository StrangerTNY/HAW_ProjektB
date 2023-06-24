extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	$Backgroundmusic.set_volume_db(-10)
	$Backgroundmusic.play()
	$SoundSettings.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$ConfirmSound.play()
	await get_tree().create_timer(0.35).timeout
	Global.backgroundmusic_position = $Backgroundmusic.get_playback_position()
	get_tree().change_scene_to_file("res://src/scenes/test_level_2.tscn")



func _on_quit_button_pressed():
	$QuitSound.play()
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()


func _on_sound_button_pressed():
	$ConfirmSound.play()
	await get_tree().create_timer(0.35).timeout
	$SoundSettings.show()
	


func _on_confirm_button_pressed():
	$ConfirmSound.play()
	await get_tree().create_timer(0.35).timeout
	$SoundSettings.hide()
