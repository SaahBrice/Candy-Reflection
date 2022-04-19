extends CanvasLayer

onready var tween = $Tween
onready var level_holder = $LEVELS
onready var background = $BACKGROUND



var level1_scene = "res://scenes/level1_manager.tscn"
var level1color = Color8(52,79,103,255)


var level2_scene = "res://scenes/level2_manager.tscn"
var level2color = Color8(0,67,65,255)


var level3_scene = "res://scenes/level3_manager.tscn"
var level3color = Color8(124,7,100,255)

var background_colours = [level1color,level2color,level3color]
var levels = [level1_scene,level2_scene,level3_scene]

onready var current_level = SceneController.present_level



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Sounds.sound_collection.very_relaxing_piano.play()
	$LEVELS/l1.value = 25-SceneController.current_level_one_value
	$LEVELS/l2.value = 30-SceneController.current_level_two_value
	$LEVELS/l3.value = SceneController.current_level_three_value
	
	if SceneController.present_level !=SceneController.previous_level:
		
		tween.interpolate_property($LEVELS, "position", SceneController.levels_position[SceneController.previous_level], SceneController.levels_position[SceneController.present_level],2,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		SceneController.previous_level = SceneController.present_level
		tween.interpolate_property(background,'modulate', background.modulate, background_colours[current_level],2,Tween.TRANS_BACK,Tween.EASE_OUT)
		tween.start()
		yield(tween, 'tween_completed')
		
	else:
		$LEVELS.position = SceneController.levels_position[SceneController.previous_level]
		background.modulate = background_colours[SceneController.previous_level]
		
		
	if SceneController.level1_completed:
		$LEVELS/l1.value = 0
	else:
		$LEVELS/l1.value = 25-SceneController.current_level_one_value 
		tween.interpolate_property($LEVELS/l1, "value", $LEVELS/l1.value , 25-SceneController.level1_completed_levels,2,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		SceneController.current_level_one_value = SceneController.level1_completed_levels
	if SceneController.level2_completed:
		$LEVELS/l2.value = 0
	else:
		$LEVELS/l2.value = 30-SceneController.current_level_two_value 
		tween.interpolate_property($LEVELS/l2, "value", $LEVELS/l2.value , 30-SceneController.level2_completed_levels,2,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		SceneController.current_level_two_value = SceneController.level2_completed_levels
	GameSaver.save_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass



func _on_move_left_pressed() -> void:
	move_level('left')
	pass # Replace with function body.


func _on_move_right_pressed() -> void:
	move_level('right')
	pass # Replace with function body.


func move_level(state):
	Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.button_vibration)
	if state == 'left':
		if current_level <= 0:
			pass
		else:
			current_level -=1
			var new_position = SceneController.levels_position[current_level]
			movement(new_position)
	else:
		if current_level >= SceneController.levels_position.size()-1:
			pass
		else:
			current_level +=1
			var new_position = SceneController.levels_position[current_level]
			movement(new_position)

func movement(new_position):
	tween.interpolate_property(level_holder,'position',level_holder.position,new_position,1,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	yield(tween,'tween_completed')
	tween.interpolate_property(background,'modulate', background.modulate, background_colours[current_level],1,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()


func _on_play_pressed() -> void:
	Sounds.sound_collection.button_pressed.play()
	Input.vibrate_handheld(SceneController.button_vibration)
	print(current_level)
	if current_level == 0:
		if SceneController.level1_completed:
			SceneController.level1_completed_levels=20
			tween.interpolate_property($overlay,'modulate',$overlay.modulate, Color8(0,0,0,255),1,Tween.TRANS_BACK,Tween.EASE_IN)
			tween.start()
			yield($Tween,"tween_completed")
			get_tree().change_scene(levels[current_level])
		else:
			tween.interpolate_property($overlay,'modulate',$overlay.modulate, Color8(0,0,0,255),1,Tween.TRANS_BACK,Tween.EASE_IN)
			tween.start()
			yield($Tween,"tween_completed")
			get_tree().change_scene(levels[current_level])
	elif current_level == 1:
		if SceneController.level2_completed:
			SceneController.level2_completed_levels=20
			tween.interpolate_property($overlay,'modulate',$overlay.modulate, Color8(0,0,0,255),1,Tween.TRANS_BACK,Tween.EASE_IN)
			tween.start()
			yield($Tween,"tween_completed")
			get_tree().change_scene(levels[current_level])
		elif SceneController.level1_completed:
			tween.interpolate_property($overlay,'modulate',$overlay.modulate, Color8(0,0,0,255),1,Tween.TRANS_BACK,Tween.EASE_IN)
			tween.start()
			yield($Tween,"tween_completed")
			get_tree().change_scene(levels[current_level])
		else:
			Sounds.sound_collection.no_touches_left.play()
	elif current_level == 2:
		if SceneController.level3_completed:
			SceneController.level3_completed_levels=20
			tween.interpolate_property($overlay,'modulate',$overlay.modulate, Color8(0,0,0,255),1,Tween.TRANS_BACK,Tween.EASE_IN)
			tween.start()
			yield($Tween,"tween_completed")
			get_tree().change_scene(levels[current_level])
		elif SceneController.level2_completed:
			tween.interpolate_property($overlay,'modulate',$overlay.modulate, Color8(0,0,0,255),1,Tween.TRANS_BACK,Tween.EASE_IN)
			tween.start()
			yield($Tween,"tween_completed")
			get_tree().change_scene(levels[current_level])
		else:
			Sounds.sound_collection.no_touches_left.play()


















