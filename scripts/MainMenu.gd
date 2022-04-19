extends Node2D

var animation_speed = 50
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var cloud_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sounds.sound_collection.very_relaxing_piano.play()
	SceneController.new_scene = 'main_menu'
	cloud_position = $background/Background/Cloud1.position
	if not GameSaver.load_game():
		print('failed to load game')
		pass
	else:
		print('game_loaded')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_start_pressed() -> void:
	
	if SceneController.tutorial_completed:
		
		Input.vibrate_handheld(SceneController.button_vibration)
		Sounds.sound_collection.button_pressed.play()
		SceneController.new_scene = "res://scenes/Level1_Scene.tscn"
		get_tree().change_scene("res://scenes/Message_scene.tscn")	
	else:
		Sounds.sound_collection.button_pressed.play()
		Input.vibrate_handheld(SceneController.button_vibration)
		SceneController.new_scene = "res://scenes/piano/Piano_manager.tscn"
		get_tree().change_scene("res://scenes/Message_scene.tscn")	


func _process(delta: float) -> void:
	$background/Background/Cloud1.position.x = $background/Background/Cloud1.position.x + animation_speed * delta





func _on_VisibilityNotifier2D_screen_exited() -> void:
	$background/Background/Cloud1.position = cloud_position
