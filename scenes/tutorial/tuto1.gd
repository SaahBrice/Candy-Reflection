extends Node2D

onready var tile = preload("res://scenes/tile.tscn")
 

onready var tween = $enable_disable
var selected_points= [0]

#matrix variables
var matrix_width=2
var matrix_height=2

var level=0

signal level_completed

#to verify the number of swaps to end the game
var Total_number_of_swaps = 1
var number_of_swaps = 0

onready var tile_positions = $main_matrix_position
#matrix containing items to disable on success
var disable_button = []

onready var sounds= [$"1",$"2",$"3",$"4",$"5",$"6",$"7",$"8",$"9",$"10",$"11",$"12"]

#the overall matrix
var test_matrix = []

#the segments after the mirror is placed
var segments
var segments_origin
#volor properties

onready var original_color = SceneController.original_color
onready var touched_color = SceneController.scene1colour

# Tiles properties
var tile_properties = {}

#mirror variables
var mirror_position_w
var mirror_position_h
var mirror_axis 
var mirror_size
var mirror_properties
		
#matrix_position
var hint_sets
var collected_sound = []

func _ready() -> void:
	randomize()
	tile_positions.modulate.a = 0
	print_out_original_grid()
	mirror_properties = Matrix.mirror_position(matrix_width,matrix_height)
	mirror_position_h=mirror_properties[0]
	mirror_position_w=mirror_properties[1]
	mirror_axis=mirror_properties[2]
	mirror_size=mirror_properties[3]
	print_out_mirror()
	get_segments(mirror_position_h,mirror_position_w,mirror_axis,mirror_size)
	hint_sets = Matrix.save_hint_and_numb_of_moves(segments[0], segments[1], mirror_properties[2], segments_origin)
	Matrix.number_of_moves = hint_sets.size()
	tween.interpolate_property($main_matrix_position, "modulate", Color8(255,255,255,0), Color8(255,255,255,255), SceneController.tile_appearing_speed, Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()
	help_pressed()



#this function prints the grid
func print_out_original_grid():
	$main_matrix_position.position = Matrix.return_position(matrix_height, matrix_width)
	var count=0
	var sound_count=0
	for x in range(matrix_height):
		Matrix.original_matrix.append([])
		test_matrix.append([])
		for y in range(matrix_width):
			var tiles = tile.instance()
			tiles.connect("tile_touched", self,'tiles_touched')
			tiles.position =  Vector2(y*90, x*90)
			if count in selected_points:
				tile_properties = {
					'position' : Vector2(x,y),
					'touched' : false,
					'value' : 1,
					'color' : touched_color,
					'changeable_color' : false,
					'sound' : sounds[sound_count],
					'tile' : tiles
					
				}
				tiles.modulate = touched_color
				test_matrix[x].append(1)	
				
			else:
				tile_properties = {
					'position' : Vector2(x,y),
					'touched' : false,
					'value' : 0,
					'color' : original_color,
					'changeable_color' : true,
					'sound' : sounds[sound_count],
					'tile' : tiles
					
				}
				tiles.modulate = original_color			
				test_matrix[x].append(0)
			Matrix.original_matrix[x].append(tile_properties)
			count += 1
			sound_count += 1
			if sound_count >= 12:
				sound_count = 0
			$main_matrix_position.call_deferred("add_child", tiles)


#this function prints the mirror
func print_out_mirror():
	if mirror_axis == 'y':
		var mirror = $mirror
		mirror.scale.y =0.1
		mirror.scale.x = mirror.scale.x*mirror_size*1.2
		mirror.position.x = $main_matrix_position.position.x + mirror_position_w*90 + 45
		if mirror_size%2==0:
			mirror.position.y = $main_matrix_position.position.y + (mirror_position_h-0.5+mirror_size/2)*(90)
		else:
			mirror.position.y = $main_matrix_position.position.y + (mirror_position_h+mirror_size/2)*(90)
	elif mirror_axis == 'x':
		var mirror = $mirror
		mirror.scale.x =0.1
		mirror.scale.y = mirror.scale.y*mirror_size*1.2
		mirror.position.y = $main_matrix_position.position.y + mirror_position_h*90 +45
		if mirror_size%2==0:
			mirror.position.x = $main_matrix_position.position.x + (mirror_position_w-0.5+mirror_size/2)*(90)
		else:
			mirror.position.x = $main_matrix_position.position.x + (mirror_position_w+mirror_size/2)*(90)

var stop = false


#tile touched
func tiles_touched(x,y):
	stop = true
	Input.vibrate_handheld(SceneController.tile_vibration)
	if Matrix.original_matrix[x][y].changeable_color:
		adjust_ones_n_zeros(x,y)
		check_validity(segments[0],segments[1])
	else:
		#play untouchable sound
		print('tile untouchable')
	


func get_segments(mirror_position_h,mirror_position_w,mirror_axis,mirror_size):
	if mirror_axis=='x':
		segments=Matrix.segmentation_x(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
		segments_origin=Matrix.segmentation_x(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
	elif mirror_axis == 'y':
		segments=Matrix.segmentation_y(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
		segments_origin=Matrix.segmentation_y(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
	else:
		pass
	if mirror_axis == 'y':
		if segments[1]==Matrix.matrix_x_reflection(segments[0]) and segments[0]==Matrix.matrix_x_reflection(segments[1]):
			reload_till_get_possibility_to_reflect()
	else:	
		if segments[1]==Matrix.matrix_y_reflection(segments[0]) and segments[0]==Matrix.matrix_y_reflection(segments[1]):
			reload_till_get_possibility_to_reflect()



func reload_till_get_possibility_to_reflect():
	var mirror = $mirror
	mirror.scale.y =1
	mirror.scale.x = 1
	mirror_position_h=0
	mirror_position_w=0
	mirror_axis='x'
	mirror_size=1
	mirror_properties = Matrix.mirror_position(matrix_width,matrix_height)
	mirror_position_h=mirror_properties[0]
	mirror_position_w=mirror_properties[1]
	mirror_axis=mirror_properties[2]
	mirror_size=mirror_properties[3]
	print_out_mirror()
	get_segments(mirror_position_h,mirror_position_w,mirror_axis,mirror_size)



func adjust_ones_n_zeros(x,y):
	if Matrix.original_matrix[x][y].value == 1:
		Matrix.original_matrix[x][y].tile.modulate= original_color
		Matrix.original_matrix[x][y].tile.get_node('cancel').emitting = true
		Matrix.original_matrix[x][y].value = 0
		Matrix.number_of_moves += 1	
		collected_sound.pop_back()
		$error.play()
		disable_button.pop_back()
		test_matrix[x][y] = 0
		var item= Matrix.get_position_in_2D_array(segments_origin[0],Matrix.original_matrix[x][y].position)
		var item1= Matrix.get_position_in_2D_array(segments_origin[1],Matrix.original_matrix[x][y].position)
		if item != Vector2(-1,-1):
			segments[0][item.x][item.y] = 0							
		elif item1!= Vector2(-1,-1):
			segments[1][item1.x][item1.y] = 0
		else:
			pass
		#hint_sets = Matrix.save_hint_and_numb_of_moves(segments[0], segments[1], mirror_properties[2], segments_origin)
		#Matrix.number_of_moves = hint_sets.size()
			
	else:
		if Matrix.number_of_moves>0:
			Matrix.original_matrix[x][y].tile.modulate = touched_color
			Matrix.original_matrix[x][y].value = 1
			Matrix.original_matrix[x][y].sound.play()
			Matrix.original_matrix[x][y].tile.get_node('win').emitting = true
			Matrix.number_of_moves -= 1
			if Matrix.number_of_moves <=0:
				Matrix.number_of_moves = 0
			collected_sound.append(Matrix.original_matrix[x][y].sound)
			disable_button.append(Matrix.original_matrix[x][y].tile)
			test_matrix[x][y] = 1
			var item= Matrix.get_position_in_2D_array(segments_origin[0],Matrix.original_matrix[x][y].position)
			var item1= Matrix.get_position_in_2D_array(segments_origin[1],Matrix.original_matrix[x][y].position)
			if item != Vector2(-1,-1):
				segments[0][item.x][item.y] = 1
			elif item1!= Vector2(-1,-1):
				segments[1][item1.x][item1.y] = 1				
			else:
				pass
			#hint_sets = Matrix.save_hint_and_numb_of_moves(segments[0], segments[1], mirror_properties[2], segments_origin)
			#Matrix.number_of_moves = hint_sets.size()

func check_validity(object, test):
	if mirror_axis == 'y':
		if test==Matrix.matrix_x_reflection(object) and object==Matrix.matrix_x_reflection(test):
			Matrix.disable_buttons(disable_button)
			number_of_swaps += 1
			if number_of_swaps < Total_number_of_swaps:
				reload_till_get_possibility_to_reflect()
				hint_sets = Matrix.save_hint_and_numb_of_moves(segments[0], segments[1], mirror_properties[2], segments_origin)
				Matrix.number_of_moves = hint_sets.size()
				Matrix.disable_buttons(disable_button)
			else:
				reset_all_variables()
		else:
			pass
	else:	
		if test==Matrix.matrix_y_reflection(object) and object==Matrix.matrix_y_reflection(test):
			number_of_swaps += 1
			if number_of_swaps < Total_number_of_swaps:
				Matrix.disable_buttons(disable_button)
				reload_till_get_possibility_to_reflect()
				hint_sets = Matrix.save_hint_and_numb_of_moves(segments[0], segments[1], mirror_properties[2], segments_origin)
				Matrix.number_of_moves = hint_sets.size()
			else:
				reset_all_variables()
		else:
			pass











func reset_all_variables():
	Matrix.reset_all_variables(disable_button, collected_sound)
	disable_mirrors()
	emit_signal("level_completed",level)
	
	
	
func disable_mirrors():
	$mirror.visible = false


#func help_pressed():
	#Matrix.save_hint_and_numb_of_moves(segments[0], segments[1], mirror_properties[2], segments_origin)


func enable():
	tween.interpolate_property($main_matrix_position, "modulate", Color8(255,255,255,0), Color8(255,255,255,255), 1, Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()

func disable():
	tween.interpolate_property($main_matrix_position, "modulate", Color8(255,255,255,255), Color8(255,255,255,0), 1, Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()

func help_pressed():
	if !hint_sets:
		print('nothing to show')
	else:
		blink(hint_sets[0].tile, touched_color, original_color)

func blink(tile, touched_color, original_color):
	tile.modulate = touched_color
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = touched_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = touched_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = touched_color	
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	tile.modulate = touched_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = touched_color	
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = touched_color	
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = touched_color	
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = touched_color	
	if stop:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	tile.modulate = original_color
	return

