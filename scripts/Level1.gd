extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Piano_pressed() -> void:
	#lay_sound
	Input.vibrate_handheld(SceneController.button_vibration)
	SceneController.new_scene = "res://scenes/piano/Piano_manager.tscn"
	get_tree().change_scene("res://scenes/Message_scene.tscn")


func _on_infinity_mode_pressed() -> void:
	Input.vibrate_handheld(SceneController.button_vibration)
	print("pressed")
