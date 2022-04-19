extends Node2D

onready var tween = $Tween
onready var pointer = preload("res://scenes/pointer.tscn").instance()
onready var current_level = SceneController.current_level


var animation_speed = 50
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sounds.sound_collection.very_relaxing_piano.play()
	SceneController.current_level_one_value 
	
	SceneController.current_line_value 
	SceneController.future_line_value 
	
	tween.interpolate_property($line_progress, "value", SceneController.current_line_value, SceneController.future_line_value ,2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.interpolate_property($L1/level1_progress, "value", SceneController.current_level_one_value , SceneController.level1_completed_levels,2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	SceneController.current_line_value = SceneController.future_line_value
	SceneController.current_level_one_value = SceneController.level1_completed_levels
	
	
func _on_L3_pressed() -> void:
	get_tree().change_scene("res://scenes/level1_manager.tscn")
	print('l3')


func _on_L2_pressed() -> void:
	print('l2')


func _on_L1_pressed() -> void:
	Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.button_vibration)
	get_tree().change_scene("res://scenes/level1_manager.tscn")

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
#	Sounds.sound_collection.piano_level_music.play()
#	#print($levels/level1.get_child_count())
#	if SceneController.scenes_tests:
#		for i in range($levels/level1.get_child_count()):
#			get_node(str("levels/level1/" + str(i+1))).disabled = false
#	$start_or_cancel_screen.connect("pass_pressed", self, "start_ok_submenu")
#	for i in range(SceneController.completed_levels.size()+1):
#		get_node(str("levels/level1/" + str(i+1))).disabled = false
#	var new_position = SceneController.current_level + 4
#	if new_position in SceneController.completed_levels and new_position!=SceneController.completed_levels[-1]:
#		pointer.position =  SceneController.old_level_scene2
#		$level_unlocked.position = SceneController.old_level_scene
#		call_deferred('add_child', pointer)
#		tween.interpolate_property(pointer, "position", SceneController.old_level_scene,SceneController.old_level_scene, SceneController.pointer_speed, Tween.TRANS_QUAD,Tween.EASE_IN)
#		tween.start()
#	else:
#		SceneController.completed_levels.append(new_position)
#		var target= new_position
#		new_position = "levels/level1/" + str(new_position)
#		SceneController.old_level_scene = "levels/level1/" + str(SceneController.old_level)
#		SceneController.old_level_scene2 = "levels/level1/" + str(SceneController.old_level+1)
#		if target % 2 ==0:
#			$TouchCamera.target = get_node(str(new_position))
#			SceneController.camera_position = get_node(str(new_position)).rect_position
#		new_position = get_node(str(new_position)).rect_position + Vector2(15,-30)
#		SceneController.old_level_scene = get_node(str(SceneController.old_level_scene)).rect_position + Vector2(15,-30)
#		SceneController.old_level_scene2 = get_node(str(SceneController.old_level_scene2)).rect_position + Vector2(15,-30)
#		pointer.position =  SceneController.old_level_scene
#		$level_unlocked.position = SceneController.old_level_scene
#		call_deferred('add_child', pointer)
#
#		tween.interpolate_property(pointer, "position", SceneController.old_level_scene,new_position, SceneController.pointer_speed, Tween.TRANS_QUAD,Tween.EASE_IN)
#		tween.start()
#		SceneController.old_level = SceneController.current_level + 4
#		$level_unlocked.position = new_position + Vector2(0,80)
#		yield(get_tree().create_timer(1),"timeout")
#		$level_unlocked/CPUParticles2D.emitting = true
#		get_node(str("levels/level1/" + str(SceneController.current_level+4))).disabled = false
#		yield(get_tree().create_timer(1),"timeout")
#		$start_or_cancel_screen.show_it()
		
	
	
	
#	if SceneController.current_level != SceneController.old_level:
#		tween.interpolate_property(pointer, "position", SceneController.old_level_scene,new_position, SceneController.pointer_speed, Tween.TRANS_QUAD,Tween.EASE_IN)
#		tween.start()
#		SceneController.old_level = SceneController.current_level + 4
#		$level_unlocked.position = new_position + Vector2(0,80)
#		yield(get_tree().create_timer(1),"timeout")
#		$level_unlocked/CPUParticles2D.emitting = true
#		get_node(str("levels/level1/" + str(SceneController.current_level+4))).disabled = false
#		yield(get_tree().create_timer(1),"timeout")
#		$start_or_cancel_screen.show_it()

#
#func _input(event: InputEvent) -> void:
#	if event == InputEventScreenDrag:
#		pass
#		#print(event.position)
#
#func _process(delta: float) -> void:
#	if SceneController.enter_scene_transition:
#		$TouchCamera/BackgroundGameG.modulate.a -= SceneController.transition_speed * delta 
#	if $TouchCamera/BackgroundGameG.modulate.a <=0:
#		SceneController.enter_scene_transition = false
#	if SceneController.exit_scene_transition:
#		$TouchCamera/BackgroundGameG.modulate.a += SceneController.transition_speed*delta
#	if $TouchCamera/BackgroundGameG.modulate.a >=1:
#		SceneController.exit_scene_transition = false
#		to_new_scene()
#	$bird2.position.x = $bird2.position.x + animation_speed * delta
#func _on_CanvasLayer_tree_exiting() -> void:
#	#$TouchCamera.position = SceneController.camera_position
#	SceneController.enter_scene_transition = true

#func start_ok_submenu(state):
#	if state == "ok":
#		if SceneController.current_level != SceneController.old_level:
#			SceneController.touched_scene = SceneController.current_level + 4
#			print(SceneController.touched_scene)
#			activate_other_functions()
#		else:
#			SceneController.touched_scene = SceneController.old_level
#			print(SceneController.touched_scene)
#			activate_other_functions()		
#		$start_or_cancel_screen.hide_it()
#	else:
#		Input.vibrate_handheld(SceneController.button_vibration)
#		$start_or_cancel_screen.hide_it()

#func to_new_scene():
#	SceneController.new_scene = "res://scenes/piano/Piano_manager.tscn"
#	#yield(get_tree().create_timer(1),"timeout")
#
#	get_tree().change_scene("res://scenes/Message_scene.tscn")
#
#
#func activate_other_functions():
#	if $start_or_cancel_screen.offset.x == -720:
#		$start_or_cancel_screen.hide_it()
#	Input.vibrate_handheld(SceneController.button_vibration)
#	Sounds.sound_collection.button_pressed.play()
#	SceneController.exit_scene_transition = true
	
#func _on_1_pressed() -> void:
#	SceneController.touched_scene = 1
#	activate_other_functions()
#func _on_2_pressed() -> void:
#	SceneController.touched_scene = 2
#	activate_other_functions()
#func _on_3_pressed() -> void:
#	SceneController.touched_scene = 3
#	activate_other_functions()
#func _on_4_pressed() -> void:
#	SceneController.touched_scene = 4
#	activate_other_functions()
#func _on_5_pressed() -> void:
#	SceneController.touched_scene = 5
#	activate_other_functions()
#func _on_6_pressed() -> void:
#	SceneController.touched_scene = 6
#	activate_other_functions()
#func _on_7_pressed() -> void:
#	SceneController.touched_scene = 7
#	activate_other_functions()
#func _on_8_pressed() -> void:
#	SceneController.touched_scene = 8
#	activate_other_functions()
#func _on_9_pressed() -> void:
#	SceneController.touched_scene = 9
#	activate_other_functions()
#func _on_10_pressed() -> void:
#	SceneController.touched_scene = 10
#	activate_other_functions()


#func _on_TouchCamera_tree_entered() -> void:
#	$TouchCamera.position = SceneController.camera_position
#
#
#func _on_VisibilityNotifier2D_screen_exited() -> void:
#	$bird2.position = Vector2(-350,-1100)
#
#
#func _on_11_pressed() -> void:
#	SceneController.touched_scene = 11
#	activate_other_functions()
#
#
#func _on_12_pressed() -> void:
#	SceneController.touched_scene = 12
#	activate_other_functions()
#
#
#func _on_13_pressed() -> void:
#	SceneController.touched_scene = 13
#	activate_other_functions()
#
#
#func _on_14_pressed() -> void:
#	SceneController.touched_scene = 14
#	activate_other_functions()
#
#
#func _on_15_pressed() -> void:
#	SceneController.touched_scene = 15
#	activate_other_functions()
#
#
#func _on_16_pressed() -> void:
#	SceneController.touched_scene = 16
#	activate_other_functions()
#
#
#func _on_17_pressed() -> void:
#	SceneController.touched_scene = 17
#	activate_other_functions()
#
#
#func _on_18_pressed() -> void:
#	SceneController.touched_scene = 18
#	activate_other_functions()
#
#
#func _on_19_pressed() -> void:
#	SceneController.touched_scene = 19
#	activate_other_functions()
#
#
#func _on_20_pressed() -> void:
#	SceneController.touched_scene = 20
#	activate_other_functions()


