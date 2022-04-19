# Saves and loads savegame files
# Each node is responsible for finding itself in the save_game
# dict so saves don't rely on the nodes' path or their source file
extends Node


onready var game_saver_class = preload("res://save/SaveGame.gd")

var save_var = ['new_scene','number_of_cancles','hint_number','previous_level','present_level','current_level_three_value','level3_completed','level3_completed_levels','current_level_two_value',
					'level2_completed','level2_completed_levels','current_level_one_value','level1_completed','level1_completed_levels',
					'tutorial_completed']



func save_game():
	var new_save = game_saver_class.new()
	new_save.new_scene = SceneController.new_scene
	new_save.tutorial_completed = SceneController.tutorial_completed
	
	new_save.level1_completed_levels = SceneController.level1_completed_levels
	new_save.level1_completed = SceneController.level1_completed
	new_save.current_level_one_value = SceneController.current_level_one_value
	
	new_save.level2_completed_levels = SceneController.level2_completed_levels
	new_save.level2_completed = SceneController.level2_completed
	new_save.current_level_two_value = SceneController.current_level_two_value
	
	new_save.level3_completed_levels = SceneController.level3_completed_levels
	new_save.level3_completed = SceneController.level3_completed
	new_save.current_level_three_value = SceneController.current_level_three_value
	
	new_save.present_level = SceneController.present_level
	new_save.previous_level = SceneController.previous_level
	new_save.hint_number = Matrix.hint_number
	new_save.number_of_cancles = Matrix.number_of_cancles
	
	var dir = Directory.new()
	if not dir.dir_exists('res://screenshots/'):
		dir.make_dir_recursive('res://screenshots/')
	ResourceSaver.save('res://screenshots/save_01.tres', new_save)

func load_game():
	var dir = Directory.new()
	if not dir.file_exists('res://screenshots/save_01.tres'):
		return false
	var saved_game = load('res://screenshots/save_01.tres')
	if not verify_save(saved_game):
		return false
	SceneController.new_scene = saved_game.new_scene
	SceneController.tutorial_completed = saved_game.tutorial_completed
	
	SceneController.level1_completed_levels = saved_game.level1_completed_levels
	SceneController.level1_completed = saved_game.level1_completed
	SceneController.current_level_one_value = saved_game.current_level_one_value
	
	SceneController.level2_completed_levels = saved_game.level2_completed_levels
	SceneController.level2_completed = saved_game.level2_completed
	SceneController.current_level_two_value = saved_game.current_level_two_value
	
	SceneController.level3_completed_levels = saved_game.level3_completed_levels
	SceneController.level3_completed = saved_game.level3_completed
	SceneController.current_level_three_value = saved_game.current_level_three_value
	
	SceneController.present_level = saved_game.present_level
	SceneController.previous_level = saved_game.previous_level
	Matrix.hint_number = saved_game.hint_number
	Matrix.number_of_cancles = saved_game.number_of_cancles
	return true
	
func verify_save(saved_game):
	for v in save_var:
		if saved_game.get(v) == null:
			return false
	return true

