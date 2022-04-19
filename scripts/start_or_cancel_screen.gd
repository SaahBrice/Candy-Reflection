extends CanvasLayer

signal pass_pressed
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func show_it():
	Sounds.sound_collection.move_down.play()
	tween.interpolate_property(self, "offset", Vector2(0,0), Vector2(-720,0),1, tween.TRANS_BACK, tween.EASE_OUT )
	tween.start()
	yield(get_tree().create_timer(1),"timeout")

		

func hide_it():
	#Sounds.sound_collection.move_up.play()
	tween.interpolate_property(self, "offset", Vector2(-720,0), Vector2(0,0),1, tween.TRANS_BACK, tween.EASE_OUT )
	tween.start()


func _on_ok_pressed() -> void:
	Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.button_vibration)
	emit_signal("pass_pressed", "ok")


func _on_cancel_pressed() -> void:
	Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.button_vibration)
	emit_signal("pass_pressed", "cancel")



func _notification(what) -> void:
	if what== MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		#for windows
		backpressed()
		print('pc')
		pass
	if what==MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		#for android
		if SceneController.new_scene == 'main_menu':
			pass
		else:
			backpressed()
			print('android')
			pass

func backpressed():
	hide_it()
