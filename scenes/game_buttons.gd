extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

signal help_pressed
signal total_cancel_pressed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneController.off_menu_buttons = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_help_pressed() -> void:
	Input.vibrate_handheld(SceneController.button_vibration)
	if Matrix.hint_number <=0:
		Sounds.sound_collection.no_hints_left.play()
		pass
	else:
		#Sounds.sound_collection.button_pressed.play()
		emit_signal("help_pressed")
		
		
func _process(delta: float) -> void:
	$HBoxContainer/touch/touches_text.text = str(Matrix.number_of_moves)
	$HBoxContainer/cancel/cancels_text.text = str(Matrix.number_of_cancles)
	$HBoxContainer/help/hint.text = str(Matrix.hint_number)
	
	if SceneController.tutorial_completed and  !SceneController.off_menu_buttons:
		$HBoxContainer/cancel.visible = true
		$HBoxContainer/help.visible = true
		$HBoxContainer/touch.visible = true
		$HBoxContainer2/parameter.visible = true
	else:
		$HBoxContainer/cancel.visible = false
		$HBoxContainer/help.visible = false
		$HBoxContainer/touch.visible = false
		$HBoxContainer2/parameter.visible = false		
	



func _on_parameter_pressed() -> void:
	Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.tile_vibration)
	SettingsWindows.backpressed()


func _on_cancel_pressed() -> void:
	#Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.tile_vibration)
	emit_signal("total_cancel_pressed")


func _on_Level_pressed() -> void:
	Input.vibrate_handheld(SceneController.tile_vibration)
	Sounds.sound_collection.button_pressed.play()
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png('res://screenshots/screenshot.png')
	$HBoxContainer2/Level/saved.visible = true
	yield(get_tree().create_timer(0.5),"timeout")
	$HBoxContainer2/Level/saved.visible = false
