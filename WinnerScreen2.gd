extends CanvasLayer

signal pass_pressed
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var tween = $BackgroundGameG/anim
onready var texture = $TextureButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_node("TextureButton").disabled = false


func move_down():
	texture.disabled = false
	#Sounds.sound_collection.move_down.play()
	tween.interpolate_property(self, "offset", Vector2(0, -2000), Vector2(0,-450),1, tween.TRANS_CUBIC, tween.EASE_OUT )
	tween.start()
	yield(get_tree().create_timer(1),"timeout")

		

func move_up():
	texture.disabled = true
	#Sounds.sound_collection.move_up.play()
	tween.interpolate_property(self, "offset", Vector2(0, -450), Vector2(0,-2000),2, tween.TRANS_BACK, tween.EASE_IN )
	tween.start()


#func _unhandled_input(event: InputEvent) -> void:
#	SceneController.pass_it = true


func _on_TextureButton_pressed() -> void:
	Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.button_vibration)
	emit_signal("pass_pressed")
