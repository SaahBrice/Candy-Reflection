extends Node2D


var animation_speed = 50
#var animation_speed = 0.01
var activate_exiting_transition = false
var activate_entering_transition = false




var words = ['Excellent', "Amazing!", "Good!", "Outstanding!", "Fantastic!", "Mervelous!", 'Great!', 'Super!', 'Exhilarating!']
onready var game_buttons_scene = preload("res://scenes/game_buttons.tscn").instance()
onready var winner = $WinnerScreen
onready var text1 = $WinnerScreen/BackgroundGameG/message1
onready var text2 = $WinnerScreen/BackgroundGameG/message2
onready var scene_in_background=$BackgroundGameG3
onready var scene_out_background=$BackgroundGameG2
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var tutorial_levels = ScenesContainer.tutorial_levels
var pass_touched= false
var texta
var textb
var textc
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	play_music()
	scene_in_background.modulate.a = 1
	scene_out_background.modulate.a=0
	activate_entering_transition = true
	yield(get_tree().create_timer(1),"timeout")
	call_deferred('add_child', game_buttons_scene)
	load_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
var passed_levels = []
func load_scene():
	if !SceneController.tutorial_completed:
		winner.move_down()
		yield(get_node("WinnerScreen"), "pass_pressed")
		var sc = tutorial_levels[0].instance()
		sc.connect('level_completed', self, 'levelCompleted')
		passed_levels.append(sc)
		take_away_winner()
		call_deferred("add_child", sc)
		#move_child($BackgroundGameG2, -1)
		
	else:
		switch_level(SceneController.touched_scene)

func switch_level(level):
	SceneController.current_level = level-3
	remove_child(get_child(get_child_count()-1))
	var new_level = tutorial_levels[int(level)+1].instance()
	passed_levels.append(new_level)
	var previous_level = passed_levels[0]
	new_level.connect("level_completed",self, 'levelCompleted')
	game_buttons_scene.disconnect("help_pressed", previous_level, 'help_pressed')
	game_buttons_scene.disconnect("total_cancel_pressed", previous_level, 'total_cancel_pressed')
	passed_levels.remove(0)
	game_buttons_scene.connect("help_pressed", new_level, 'help_pressed')
	game_buttons_scene.connect("total_cancel_pressed", new_level, 'total_cancel_pressed')
	#new_level.enable()
	call_deferred('add_child', new_level)
	#move_child($BackgroundGameG2, get_child_count()-1)

	
	
	
func bring_winner(text1, text2, text3):
	$WinnerScreen/BackgroundGameG/message2.text = text1
	$WinnerScreen/BackgroundGameG/message1.text = text2
	$WinnerScreen/BackgroundGameG/message3.text = text3
	winner.move_down()
	$WinnerScreen/winner.emitting = true
		

func take_away_winner():
	winner.move_up()
	$snowParticles.emitting = true



func levelCompleted(level):
	if level == 0:
		texta = str('The mirror can change its position.')
		textb = words[randi()%words.size()]
		textc = ''
		bring_winner(texta, textb, textc)
		yield(get_node("WinnerScreen"), "pass_pressed")
		take_away_winner()
		switch_level(level)
		#$text_message.text = str('"That was brilliant. Let us reflect once more. \n\n\n\n\n\n\n\n\n The mirror can change it\'s position."')
	elif level == 1:
		texta = str('You are ready to reflect.')
		textb = words[randi()%words.size()]
		textc = ''
		bring_winner(texta, textb, textc)
		yield(get_node("WinnerScreen"), "pass_pressed")
		take_away_winner()
		switch_level(level)
	else:
		texta = ''
		textb = ''
		textc= words[randi()%words.size()]
		bring_winner(texta, textb, textc)
		yield(get_node("WinnerScreen"), "pass_pressed")
		take_away_winner()
		SceneController.tutorial_completed = true
		return_to_levels_scene()
		#switch_level(level)		


func return_to_levels_scene():
	SceneController.new_scene = "res://scenes/Level1_Scene.tscn"
	exiting_transition()
	yield(get_tree().create_timer(SceneController.dark_screen_speed),"timeout")
	activate_exiting_transition = false
	stop_music()
	get_tree().change_scene(SceneController.new_scene)



func exiting_transition():
	SceneController.off_menu_buttons = true
	activate_exiting_transition = true
	









func _process(delta: float) -> void:
	if activate_entering_transition:
		scene_in_background.modulate.a -= SceneController.transition_speed*delta
	if scene_in_background.modulate.a <=0:
		activate_entering_transition = false
	if activate_exiting_transition:
		scene_out_background.modulate.a += SceneController.transition_speed*delta
	$bird2.position.x = $bird2.position.x + animation_speed * delta
	$bird2.scale.x = $bird2.scale.x + 0.01*delta
	$bird2.scale.y = $bird2.scale.y + 0.01*delta
	$Node2D.position.x = $Node2D.position.x + animation_speed * delta
	

func _on_VisibilityNotifier2D_screen_exited() -> void:
	$Node2D.position = $instantiatebird1.position
	$Node2D.scale.y = 1
	$Node2D.scale.x = 1


func _on_bird2visibility_screen_exited() -> void:
	$bird2.position = $instantiatebird2.position
	$bird2.scale.y = 1
	$bird2.scale.x = 1


func play_music():
	Sounds.sound_collection.very_relaxing_piano.stop()
	Sounds.sound_collection.nature_sound.play()

func stop_music():
	Sounds.sound_collection.nature_sound.stop()
