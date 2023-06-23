extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$ConfirmSound.play()
	await get_tree().create_timer(0.35).timeout
	get_tree().change_scene_to_file("res://src/scenes/test_level_2.tscn")



func _on_quit_button_pressed():
	$QuitSound.play()
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()

