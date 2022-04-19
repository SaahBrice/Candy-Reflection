extends CanvasLayer


onready var tween = $Tween 

var sound_check = true
var music_check = true
var sfx_check = true
var haptic_check = true

var is_displaying = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().set_quit_on_go_back(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass



func _on_sound_check_pressed() -> void:
	if sound_check:
		sound_check = false
		#AudioServer.set_bus_mute(3,sound_check)
		AudioServer.set_bus_volume_db(3,-80)
	else:
		sound_check = true
		#AudioServer.set_bus_mute(3,sound_check)
		AudioServer.set_bus_volume_db(3,0)
	
func _on_haptic_check_pressed() -> void:
	if haptic_check:
		haptic_check = false
		SceneController.button_vibration = 0
		SceneController.tile_vibration = 0
		SceneController.winning_vibration = 0
	else:
		haptic_check = true
		SceneController.button_vibration = 100
		SceneController.tile_vibration = 70
		SceneController.winning_vibration = 200

func _on_music_check_pressed() -> void:
	if music_check:
		music_check = false
		#AudioServer.set_bus_mute(4,music_check)
		AudioServer.set_bus_volume_db(4,-80)
		AudioServer.set_bus_volume_db(1,-80)
		print(AudioServer.get_bus_volume_db(4))
		print(AudioServer.get_bus_volume_db(1))
	else:
		music_check = true
		#AudioServer.set_bus_mute(4,music_check)
		AudioServer.set_bus_volume_db(4,0)
		AudioServer.set_bus_volume_db(1,0)
		print(AudioServer.get_bus_volume_db(4))
		print(AudioServer.get_bus_volume_db(1))

func _on_sfx_check_pressed() -> void:
	if sfx_check:
		sfx_check = false
		#AudioServer.set_bus_mute(2,sfx_check)
		AudioServer.set_bus_volume_db(2,-80)
		print(AudioServer.get_bus_volume_db(2))
	else:
		sfx_check = true
		#AudioServer.set_bus_mute(2,sfx_check)
		AudioServer.set_bus_volume_db(2,0)
		print(AudioServer.get_bus_volume_db(2))








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
	if is_displaying:
		is_displaying = false
		hide_it()
	else:
		is_displaying = true
		show_it()



func show_it():
	Sounds.sound_collection.move_down.play()
	tween.interpolate_property(self, "offset", Vector2(750, 0), Vector2(0,0),1, tween.TRANS_BACK, tween.EASE_OUT )
	tween.start()
	#yield(get_tree().create_timer(1),"timeout")

		

func hide_it():
	#Sounds.sound_collection.move_up.play()
	tween.interpolate_property(self, "offset", Vector2(0, 0), Vector2(750,0),1, tween.TRANS_BACK, tween.EASE_OUT )
	tween.start()


func _on_close_pressed() -> void:
	Sounds.sound_collection.button_pressed.play()
	backpressed()


func _on_shop_pressed() -> void:
	show_shop()


func show_shop():
	tween.interpolate_property(self, "offset", Vector2(0, 0), Vector2(0,120),1, tween.TRANS_BACK, tween.EASE_OUT )
	tween.start()
	yield(get_tree().create_timer(1), "timeout")
	tween.interpolate_property(self, "offset", Vector2(0, 120), Vector2(0,0),1, tween.TRANS_BACK, tween.EASE_OUT )


func _on_menu_pressed() -> void:
	backpressed()
	yield(get_tree().create_timer(1),"timeout")
	SceneController.new_scene = 'res://scenes/MainMenu.tscn'
	Sounds.sound_collection.nature_sound.stop()
	Sounds.sound_collection.piano_level_music.stop()
	Sounds.sound_collection.very_relaxing_piano.stop()
	Sounds.sound_collection.rain_thunder.stop()
	get_tree().change_scene("res://scenes/Message_scene.tscn")
