extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var game_over = preload("res://scenes/game_over.tscn")
onready var game_buttons_scene = preload("res://scenes/game_buttons.tscn").instance()
onready var timer = $Timer
onready var timer_bar = $time
onready var winner = $WinnerScreen2
onready var particles = $WinnerScreen2/winner
var home_screen = "res://scenes/Level1_Scene.tscn"
var words = ['Excellent','Neat!', 'Classy!','Brilliant!','Remarkable!','Like a,b,c','Honorable','Exceptional', "Amazing!", "Good!", "Outstanding!", "Fantastic!", "Mervelous!", 'Great!', 'Super!', 'Uplifting!','Exhilarating!']

var animation_speed = 50


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over = game_over.instance()
	game_over.connect("cancel_pressed",self,'cancel_pressed')
	game_over.connect("ad_completed",self,'ad_completed')
	$BackgroundGame2.modulate = Color8(124,7,100,255)
	Sounds.sound_collection.rain_thunder.play()
	Sounds.sound_collection.very_relaxing_piano.stop()
	if SceneController.level3_completed:
		print('level_completed')
		load_scenes_in_level()
	else:
		call_deferred('add_child', game_buttons_scene)
		load_scenes_in_level()


func load_scenes_in_level():
	var new_scene = ScenesContainer.scenes_level3[SceneController.level3_completed_levels].instance()
	new_scene.connect("level_completed",self, 'levelCompleted')
	game_buttons_scene.connect("help_pressed", new_scene, 'help_pressed')
	game_buttons_scene.connect("total_cancel_pressed", new_scene, 'total_cancel_pressed')
	
	call_deferred('add_child', new_scene)
	call_deferred('add_child', game_over)
	start_timer()
	



func levelCompleted(level):
	var text1 = ''
	var text2 = ''
	var text3 = words[randi()%words.size()]
	$WinnerScreen2/BackgroundGameG/message2.text = text1
	$WinnerScreen2/BackgroundGameG/message1.text = text2
	$WinnerScreen2/message3.text = text3
	timer.paused = true
	winner.move_down()
	yield(get_tree().create_timer(1),"timeout")
	particles.emitting = true
	yield(get_node("WinnerScreen2"), "pass_pressed")
	winner.move_up()
	yield(get_tree().create_timer(0.5),"timeout")
	if level % 5 == 0:
		SceneController.new_scene = home_screen
		yield(get_tree().create_timer(1),"timeout")
		Sounds.sound_collection.rain_thunder.stop()
		get_tree().change_scene("res://scenes/Message_scene.tscn")
	if level == 34:
		SceneController.present_level = 3
		SceneController.level3_completed = true
		SceneController.new_scene = home_screen
		yield(get_tree().create_timer(1),"timeout")
		Sounds.sound_collection.rain_thunder.stop()
		get_tree().change_scene("res://scenes/Message_scene.tscn")
	SceneController.level3_completed_levels = level
	get_child(get_child_count()-1).disconnect("level_completed",self, 'levelCompleted')
	game_buttons_scene.disconnect("help_pressed", get_child(get_child_count()-1), 'help_pressed')
	game_buttons_scene.disconnect("total_cancel_pressed", get_child(get_child_count()-1), 'total_cancel_pressed')
	var new_scene = ScenesContainer.scenes_level3[SceneController.level3_completed_levels].instance()
	new_scene.connect("level_completed",self, 'levelCompleted')
	game_buttons_scene.connect("help_pressed", new_scene, 'help_pressed')
	game_buttons_scene.connect("total_cancel_pressed", new_scene, 'total_cancel_pressed')
	remove_child(get_child(get_child_count()-2))
	remove_child(get_child(get_child_count()-1))
	timer.start(SceneController.clock_time)
	timer.paused = false
	
	call_deferred('add_child', new_scene)
	call_deferred('add_child', game_over)
	



func _process(delta: float) -> void:
	$bird2.position.x = $bird2.position.x + animation_speed * delta
	$bird2.scale.x = $bird2.scale.x + 0.01*delta
	$bird2.scale.y = $bird2.scale.y + 0.01*delta
	$Node2D.position.x = $Node2D.position.x + animation_speed * delta
	timer_bar.value = timer.time_left

func _on_VisibilityNotifier2D_screen_exited() -> void:
	$Node2D.position = $instantiatebird1.position
	$Node2D.scale.y = 1
	$Node2D.scale.x = 1


func _on_bird2visibility_screen_exited() -> void:
	$bird2.position = $instantiatebird2.position
	$bird2.scale.y = 1
	$bird2.scale.x = 1


func start_timer():
	timer.paused = false
	timer.start(SceneController.clock_time)



func _on_Timer_timeout() -> void:
	timer.paused=true
	game_over.show_it()
	print('done') # Replace with function body.


func cancel_pressed():
	SceneController.new_scene ="res://scenes/Level1_Scene.tscn"
	print('Cancel pressed')
	yield(get_tree().create_timer(1),"timeout")
	Sounds.sound_collection.rain_thunder.stop()
	get_tree().change_scene("res://scenes/Message_scene.tscn")


func ad_completed():
	timer.paused=false
	timer.start(20)
	print('advert completed')
