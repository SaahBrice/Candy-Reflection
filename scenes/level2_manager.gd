extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var game_buttons_scene = preload("res://scenes/game_buttons.tscn").instance()

onready var winner = $WinnerScreen2
onready var particles = $WinnerScreen2/winner
var home_screen = "res://scenes/Level1_Scene.tscn"
var words = ['Excellent','Neat!', 'Classy!','Brilliant!','Remarkable!','Like a,b,c','Honorable','Exceptional', "Amazing!", "Good!", "Outstanding!", "Fantastic!", "Mervelous!", 'Great!', 'Super!', 'Uplifting!','Exhilarating!']

var animation_speed = 50


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BackgroundGame2.modulate = Color8(0,67,65,255)
	Sounds.sound_collection.rain_thunder.play()
	Sounds.sound_collection.very_relaxing_piano.stop()
	if SceneController.level2_completed:
		print('level_completed')
		load_scenes_in_level()
	else:
		call_deferred('add_child', game_buttons_scene)
		load_scenes_in_level()


func load_scenes_in_level():
	var new_scene = ScenesContainer.scenes_level2[SceneController.level2_completed_levels].instance()
	new_scene.connect("level_completed",self, 'levelCompleted')
	game_buttons_scene.connect("help_pressed", new_scene, 'help_pressed')
	game_buttons_scene.connect("total_cancel_pressed", new_scene, 'total_cancel_pressed')
	call_deferred('add_child', new_scene)



func levelCompleted(level):
	var text1 = ''
	var text2 = ''
	var text3 = words[randi()%words.size()]
	$WinnerScreen2/BackgroundGameG/message2.text = text1
	$WinnerScreen2/BackgroundGameG/message1.text = text2
	$WinnerScreen2/message3.text = text3
	winner.move_down()
	yield(get_tree().create_timer(1),"timeout")
	particles.emitting = true
	yield(get_node("WinnerScreen2"), "pass_pressed")
	winner.move_up()
	yield(get_tree().create_timer(0.5),"timeout")
	if level % 6 == 0:
		SceneController.new_scene = home_screen
		yield(get_tree().create_timer(1),"timeout")
		Sounds.sound_collection.rain_thunder.stop()
		get_tree().change_scene("res://scenes/Message_scene.tscn")
	if level == 29:
		SceneController.present_level = 2
		SceneController.level2_completed = true
		SceneController.new_scene = home_screen
		yield(get_tree().create_timer(1),"timeout")
		Sounds.sound_collection.rain_thunder.stop()
		get_tree().change_scene("res://scenes/Message_scene.tscn")
	SceneController.level2_completed_levels = level
	get_child(get_child_count()-1).disconnect("level_completed",self, 'levelCompleted')
	game_buttons_scene.disconnect("help_pressed", get_child(get_child_count()-1), 'help_pressed')
	game_buttons_scene.disconnect("total_cancel_pressed", get_child(get_child_count()-1), 'total_cancel_pressed')
	var new_scene = ScenesContainer.scenes_level2[SceneController.level2_completed_levels].instance()
	new_scene.connect("level_completed",self, 'levelCompleted')
	game_buttons_scene.connect("help_pressed", new_scene, 'help_pressed')
	game_buttons_scene.connect("total_cancel_pressed", new_scene, 'total_cancel_pressed')
	remove_child(get_child(get_child_count()-1))
	call_deferred('add_child', new_scene)



func _process(delta: float) -> void:
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
