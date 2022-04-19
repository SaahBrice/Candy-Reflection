extends Node2D

onready var tile = preload("res://scenes/tile1.tscn")
#onready var sounds= [$"1",$"2",$"3",$"4",$"5",$"6",$"7",$"8",$"9",$"10",$"11",$"12"]
onready var sounds = Sounds.level2_sounds
#color properties

onready var original_color = SceneController.l2_orgn
onready var touched_color = SceneController.l2_touched

onready var tween = $enable_disable

var collected_sound = []



var solution

#matrix variables
var matrix_width=7
var matrix_height=4

var selected_points=[4,11,1]

var level=10

#to verify the number of swaps to end the game
var Total_number_of_swaps = 4
var number_of_swaps = 0




signal level_completed


#matrix containing items to disable on success
var disable_button = []



#the overall matrix
var test_matrix = []


#color properties


# Tiles properties
var tile_properties = {}

#mirror variables
#var mirror_position_w
#var mirror_position_h
#var mirror_axis
#var mirror_size
var mirror_properties




var mirror
#matrix_position


func _ready() -> void:
	randomize()
	print_out_original_grid()
	mirror_properties = Matrix.mirror_position(matrix_width,matrix_height)
	#mirror_position_h=mirror_properties[0]
	#mirror_position_w=mirror_properties[1]
	#mirror_axis=mirror_properties[2]
	#mirror_size=mirror_properties[3]
	print_out_mirror(mirror_properties[0],mirror_properties[1],mirror_properties[2],mirror_properties[3], 0)
	get_segments(mirror_properties[0],mirror_properties[1],mirror_properties[2],mirror_properties[3], 0)
	count_1_hints()
	tween.interpolate_property($main_matrix_position, "modulate", Color8(255,255,255,0), Color8(255,255,255,255), 0.5, Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()



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
			#original_matrix[x].append(Vector2(x, y))
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
func print_out_mirror(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number):
	mirror = $mirror
	if mirror_axis == 'y':
		mirror.scale.y =0.1
		mirror.scale.x = mirror.scale.x*mirror_size*1.1
		mirror.position.x = $main_matrix_position.position.x + mirror_position_w*90 + 45
		if mirror_size%2==0:
			mirror.position.y = $main_matrix_position.position.y + (mirror_position_h-0.5+mirror_size/2)*(90)
		else:
			mirror.position.y = $main_matrix_position.position.y + (mirror_position_h+mirror_size/2)*(90)
	elif mirror_axis == 'x':
		mirror.scale.x =0.1
		mirror.scale.y = mirror.scale.y*mirror_size*1.1
		mirror.position.y = $main_matrix_position.position.y + mirror_position_h*90 +45
		if mirror_size%2==0:
			mirror.position.x = $main_matrix_position.position.x + (mirror_position_w-0.5+mirror_size/2)*(90)
		else:
			mirror.position.x = $main_matrix_position.position.x + (mirror_position_w+mirror_size/2)*(90)




#tile touched
func tiles_touched(x,y):
	Input.vibrate_handheld(SceneController.tile_vibration)
	if !Matrix.original_matrix:
		print("not allowed")
	elif Matrix.original_matrix[x][y].changeable_color:
		adjust_ones_n_zeros(x,y)
		check_validity()
	else:
		#play untouchable sound
		print('tile untouchable')


func reload_till_get_possibility_to_reflect(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number):
	if mirror_number==0:
		mirror = $mirror
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
		print_out_mirror(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number)
		get_segments(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, 0)





func get_segments(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number):
	if mirror_number==0:
		if mirror_axis=='x':
			var segments=Matrix.segmentation_x(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
			var segments_origin=Matrix.segmentation_x(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
			if segments[1]==Matrix.matrix_y_reflection(segments[0]) and segments[0]==Matrix.matrix_y_reflection(segments[1]):
				reload_till_get_possibility_to_reflect(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number)

		elif mirror_axis == 'y':
			var segments=Matrix.segmentation_y(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
			var segments_origin=Matrix.segmentation_y(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
			if segments[1]==Matrix.matrix_x_reflection(segments[0]) and segments[0]==Matrix.matrix_x_reflection(segments[1]):
				reload_till_get_possibility_to_reflect(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number)


func adjust_ones_n_zeros(x,y):
	if Matrix.original_matrix[x][y].value == 1:
		Matrix.original_matrix[x][y].tile.modulate= original_color
		Matrix.original_matrix[x][y].value = 0
		Matrix.original_matrix[x][y].tile.get_node('cancel').emitting = true
		test_matrix[x][y] = 0
		Matrix.tiles_to_cancel.erase(Vector2(x,y))
		collected_sound.pop_back()
		Matrix.number_of_moves += 1
		Matrix.number_of_cancles -=1
		if Matrix.number_of_cancles < 0:
			Matrix.number_of_cancles = 0
			AdvertManager.load_cancels_adv()
		Sounds.sound_collection.cancel_tile.play()
		disable_button.pop_at( disable_button.find(Matrix.original_matrix[x][y].tile))
	else:
		if Matrix.number_of_moves>0:
			Matrix.original_matrix[x][y].tile.modulate = touched_color
			for hint in solution[1]:
				if Matrix.original_matrix[x][y].position == hint.position:
					solution[1].erase(hint)
					#Matrix.number_of_moves = solution[1].size()
			Matrix.original_matrix[x][y].value = 1
			test_matrix[x][y] = 1
			Matrix.tiles_to_cancel.append(Vector2(x,y))
			Matrix.number_of_moves -= 1

			if Matrix.number_of_moves <=0:
				Matrix.number_of_moves = 0
			disable_button.append(Matrix.original_matrix[x][y].tile)
			Matrix.original_matrix[x][y].sound.play()
			collected_sound.push_back(Matrix.original_matrix[x][y].sound)
			Matrix.original_matrix[x][y].tile.get_node('win').emitting = true
		else:
			Sounds.sound_collection.no_touches_left.play()

func check_validity():
	if test_matrix == solution[0]:
		number_of_swaps += 1
		if number_of_swaps<Total_number_of_swaps:
			Matrix.disable_buttons(disable_button)
			reload_till_get_possibility_to_reflect(mirror_properties[0],mirror_properties[1],mirror_properties[2],mirror_properties[3], 0)
			count_1_hints()
			Matrix.tiles_to_cancel = []
		else:
			Matrix.tiles_to_cancel = []
			reset_all_variables()

func reset_all_variables():
	Matrix.reset_all_variables1(disable_button,2, collected_sound)
	disable_mirrors()
	emit_signal("level_completed",level)


func disable_mirrors():
	$mirror.visible = false



func help_pressed():
	if Matrix.hint_number <=0:
		AdvertManager.play_hint_adv()
	else:
		if solution[1]:
			Matrix.blink(solution[1][0].tile, touched_color, original_color)
			Matrix.hint_number -=1
			return
		else:
			print('nothing to show')

func count_1_hints():
	var one_zero = test_matrix.duplicate(true)
	var origine = Matrix.original_matrix.duplicate(true)
	solution = Matrix.game_player_1_mirrors(one_zero, origine, mirror_properties)
	Matrix.number_of_moves = solution[1].size()


func _process(delta: float) -> void:
	#$Label.text = str(Matrix.number_of_moves)
	pass


func total_cancel_pressed():
	for t in (Matrix.tiles_to_cancel.size()):
		for i in Matrix.tiles_to_cancel:
			adjust_ones_n_zeros(i.x,i.y)
			yield(get_tree().create_timer(0.25),"timeout")
