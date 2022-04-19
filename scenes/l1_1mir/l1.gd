extends Node2D

onready var tile = preload("res://scenes/tile.tscn")
var sounds

#PIANO
onready var C_1 = [$piano/C/C3,$piano/C/C4,$piano/C/C5,$piano/C/C6]
onready var Cs_1 = [$piano/Cs/Cs3,$piano/Cs/Cs4,$piano/Cs/Cs5]
onready var D_1 = [$piano/D/D3,$piano/D/D4,$piano/D/D5]
onready var Ds_1 = [$piano/Ds/Ds3,$piano/Ds/Ds4,$piano/Ds/Ds5]
onready var E_1 = [$piano/E/E3,$piano/E/E4,$piano/E/E5]
onready var F_1 = [$piano/F/F3,$piano/F/F4,$piano/F/F5]
onready var Fs_1 = [$piano/Fs/Fs3,$piano/Fs/Fs4,$piano/Fs/Fs5]
onready var G_1 = [$piano/G/G3,$piano/G/G4,$piano/G/G5]
onready var Gs_1 = [$piano/Gs/Gs3,$piano/Gs/Gs4,$piano/Gs/Gs5]
onready var A_1 = [$piano/A/A3,$piano/A/A4,$piano/A/A5]
onready var As_1 = [$piano/As/As3,$piano/As/As4,$piano/As/As5]
onready var B_1 = [$piano/B/B3,$piano/B/B4,$piano/B/B5]


#var notes_selection_1 = [
#	C_1[0],Cs_1[0],D_1[0],Ds_1[0],E_1[0],F_1[0],Fs_1[0],G_1[0],Gs_1[0],A_1[0],As_1[0],B_1[0],
#	C_1[1],Cs_1[1],D_1[1],Ds_1[1],E_1[1],F_1[1],Fs_1[1],G_1[1],Gs_1[1],A_1[1],As_1[1],B_1[1],
#	C_1[2]
#]
onready var all_notes_1 = [
	C_1[0],Cs_1[0],D_1[0],Ds_1[0],E_1[0],F_1[0],Fs_1[0],G_1[0],Gs_1[0],A_1[0],As_1[0],B_1[0],
	C_1[1],Cs_1[1],D_1[1],Ds_1[1],E_1[1],F_1[1],Fs_1[1],G_1[1],Gs_1[1],A_1[1],As_1[1],B_1[1],
	C_1[2],Cs_1[2],D_1[2],Ds_1[2],E_1[2],F_1[2],Fs_1[2],G_1[2],Gs_1[2],A_1[2],As_1[2],B_1[2],
	C_1[3]
]

var note_types = [
	'C','Cs','D','Ds','E','F','Fs','G','Gs','A','As','B'
]

var note_scale
var note_scale_values = ['major', 'minor']
var new_collected_sound 



onready var tween = $enable_disable

var collected_sound = []

var selected_points=[2]

var solution

#matrix variables
var matrix_width=4
var matrix_height=4
var level=1

#to verify the number of swaps to end the game
var Total_number_of_swaps = 1
var number_of_swaps = 0




signal level_completed


#matrix containing items to disable on success
var disable_button = []



#the overall matrix
var test_matrix = []


#color properties

var original_color = Color8(192,204,214,200)
var touched_color = Color8(0,140,255,255)

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
	note_scale = note_scale_values[randi() % 2]
	if note_scale == 'major':
		var x = randi()% 25
		sounds = [
			all_notes_1[x],all_notes_1[x+2],all_notes_1[x+4],
			all_notes_1[x+5],all_notes_1[x+7],all_notes_1[x+9],
			all_notes_1[x+11],all_notes_1[x+12],all_notes_1[x],all_notes_1[x+2],all_notes_1[x+4],
			all_notes_1[x+5]
			]
	elif note_scale == 'minor':
		var x = randi()% 25
		sounds = [
			all_notes_1[x],all_notes_1[x+2],all_notes_1[x+3],
			all_notes_1[x+5],all_notes_1[x+7],all_notes_1[x+8],
			all_notes_1[x+10],all_notes_1[x+12],all_notes_1[x],all_notes_1[x+2],all_notes_1[x+3],
			all_notes_1[x+5]
			]
	else:
		print("Neither minor nor major")
		
		
	print_out_original_grid()
	mirror_properties = Matrix.mirror_position(matrix_width,matrix_height)
	#mirror_position_h=mirror_properties[0]
	#mirror_position_w=mirror_properties[1]
	#mirror_axis=mirror_properties[2]
	#mirror_size=mirror_properties[3]
	print_out_mirror(mirror_properties[0],mirror_properties[1],mirror_properties[2],mirror_properties[3], 0)
	get_segments(mirror_properties[0],mirror_properties[1],mirror_properties[2],mirror_properties[3], 0)
	count_1_hints()
	tween.interpolate_property($main_matrix_position, "modulate", Color8(255,255,255,0), Color8(255,255,255,255), SceneController.all_tile_appearing_speed, Tween.TRANS_QUAD,Tween.EASE_IN)
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
			print(Matrix.original_matrix[x][y].sound)
			collected_sound.push_back(Matrix.original_matrix[x][y].sound)
			Matrix.original_matrix[x][y].tile.get_node('win').emitting = true
		else:
			Sounds.sound_collection.no_touches_left.play()

func check_validity():
	if test_matrix == solution[0]:
		number_of_swaps += 1
		if number_of_swaps<Total_number_of_swaps:
			reload_till_get_possibility_to_reflect(mirror_properties[0],mirror_properties[1],mirror_properties[2],mirror_properties[3], 0)
			count_1_hints()
			Matrix.tiles_to_cancel = []
		else:
			Matrix.tiles_to_cancel = []
			reset_all_variables()

func reset_all_variables():
	disable_mirrors()
	var position_of_sound = all_notes_1.find(collected_sound[-1])
	if position_of_sound > 11:
		position_of_sound -= 12
		if position_of_sound > 11:
			position_of_sound -= 12
	print(position_of_sound)
	print(note_scale)
	if note_scale == 'minor':
		var number_of_notes = [3,4,5]
		var point = number_of_notes[randi() % 3]
		if point == 3:
			if note_types[position_of_sound] =='C':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], G_1[randi()%3]]
			elif note_types[position_of_sound] =='Cs':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='D':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], A_1[randi()%3]]
			elif note_types[position_of_sound] =='Ds':
				new_collected_sound = [collected_sound[-1], G_1[randi()%3], As_1[randi()%3]]
			elif note_types[position_of_sound] =='E':
				new_collected_sound = [collected_sound[-1], B_1[randi()%3], Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='F':
				new_collected_sound = [collected_sound[-1], A_1[randi()%3], C_1[randi()%4]]
			elif note_types[position_of_sound] =='Fs':
				new_collected_sound = [collected_sound[-1], Cs_1[randi()%3], As_1[randi()%3]]
			elif note_types[position_of_sound] =='G':
				new_collected_sound = [collected_sound[-1], D_1[randi()%3], B_1[randi()%3]]
			elif note_types[position_of_sound] =='Gs':
				new_collected_sound = [collected_sound[-1], C_1[randi()%4], Ds_1[randi()%3]]
			elif note_types[position_of_sound] =='A':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], Cs_1[randi()%3]]
			elif note_types[position_of_sound] =='As':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], D_1[randi()%3]]
			elif note_types[position_of_sound] =='B':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], Ds_1[randi()%3]]
		elif point == 4:
			if note_types[position_of_sound] =='C':
				new_collected_sound = [collected_sound[-1], C_1[randi()%4], E_1[randi()%3], G_1[randi()%3]]
			elif note_types[position_of_sound] =='Cs':
				new_collected_sound = [collected_sound[-1], C_1[randi()%4], F_1[randi()%3], Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='D':
				new_collected_sound = [collected_sound[-1],D_1[randi()%3], Fs_1[randi()%3], A_1[randi()%3]]
			elif note_types[position_of_sound] =='Ds':
				new_collected_sound = [collected_sound[-1],Ds_1[randi()%3], G_1[randi()%3], As_1[randi()%3]]
			elif note_types[position_of_sound] =='E':
				new_collected_sound = [collected_sound[-1], B_1[randi()%3], Gs_1[randi()%3],E_1[randi()%3]]
			elif note_types[position_of_sound] =='F':
				new_collected_sound = [collected_sound[-1], A_1[randi()%3], C_1[randi()%4],F_1[randi()%3]]
			elif note_types[position_of_sound] =='Fs':
				new_collected_sound = [collected_sound[-1], Cs_1[randi()%3], As_1[randi()%3],Fs_1[randi()%3]]
			elif note_types[position_of_sound] =='G':
				new_collected_sound = [collected_sound[-1], D_1[randi()%3], B_1[randi()%3],G_1[randi()%3]]
			elif note_types[position_of_sound] =='Gs':
				new_collected_sound = [collected_sound[-1], C_1[randi()%4], Ds_1[randi()%3],Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='A':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], Cs_1[randi()%3],A_1[randi()%3]]
			elif note_types[position_of_sound] =='As':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], D_1[randi()%3],As_1[randi()%3]]
			elif note_types[position_of_sound] =='B':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], Ds_1[randi()%3],B_1[randi()%3]]
		elif point == 5:
			if note_types[position_of_sound] =='C':
				new_collected_sound = [collected_sound[-1], C_1[randi()%4], E_1[randi()%3], G_1[randi()%3],E_1[randi()%3]]
			elif note_types[position_of_sound] =='Cs':
				new_collected_sound = [collected_sound[-1], C_1[randi()%4], F_1[randi()%3], Gs_1[randi()%3],F_1[randi()%3]]
			elif note_types[position_of_sound] =='D':
				new_collected_sound = [collected_sound[-1],D_1[randi()%3], Fs_1[randi()%3], A_1[randi()%3],Fs_1[randi()%3]]
			elif note_types[position_of_sound] =='Ds':
				new_collected_sound = [collected_sound[-1],Ds_1[randi()%3], G_1[randi()%3], As_1[randi()%3],G_1[randi()%3]]
			elif note_types[position_of_sound] =='E':
				new_collected_sound = [collected_sound[-1], B_1[randi()%3], Gs_1[randi()%3],E_1[randi()%3],Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='F':
				new_collected_sound = [collected_sound[-1], A_1[randi()%3], C_1[randi()%4],F_1[randi()%3],C_1[randi()%4]]
			elif note_types[position_of_sound] =='Fs':
				new_collected_sound = [collected_sound[-1], Cs_1[randi()%3], As_1[randi()%3],Fs_1[randi()%3],As_1[randi()%3]]
			elif note_types[position_of_sound] =='G':
				new_collected_sound = [collected_sound[-1], D_1[randi()%3], B_1[randi()%3],G_1[randi()%3],B_1[randi()%3]]
			elif note_types[position_of_sound] =='Gs':
				new_collected_sound = [collected_sound[-1], C_1[randi()%4], Ds_1[randi()%3],Gs_1[randi()%3],Ds_1[randi()%3]]
			elif note_types[position_of_sound] =='A':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], Cs_1[randi()%3],A_1[randi()%3],Cs_1[randi()%3]]
			elif note_types[position_of_sound] =='As':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], D_1[randi()%3],As_1[randi()%3],D_1[randi()%3]]
			elif note_types[position_of_sound] =='B':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], Ds_1[randi()%3],B_1[randi()%3],Ds_1[randi()%3]]
	elif note_scale == 'major':
		var number_of_notes = [3,4,5]
		var point = number_of_notes[randi() % 3]
		if point == 3:
			if note_types[position_of_sound] =='C':
				new_collected_sound = [collected_sound[-1], Ds_1[randi()%3], G_1[randi()%3]]
			elif note_types[position_of_sound] =='Cs':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='D':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], A_1[randi()%3]]
			elif note_types[position_of_sound] =='Ds':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], As_1[randi()%3]]
			elif note_types[position_of_sound] =='E':
				new_collected_sound = [collected_sound[-1], G_1[randi()%3], B_1[randi()%3]]
			elif note_types[position_of_sound] =='F':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='Fs':
				new_collected_sound = [collected_sound[-1], Cs_1[randi()%3], A_1[randi()%3]]
			elif note_types[position_of_sound] =='G':
				new_collected_sound = [collected_sound[-1], D_1[randi()%3], As_1[randi()%3]]
			elif note_types[position_of_sound] =='Gs':
				new_collected_sound = [collected_sound[-1], B_1[randi()%3], Ds_1[randi()%3]]
			elif note_types[position_of_sound] =='A':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], C_1[randi()%3]]
			elif note_types[position_of_sound] =='As':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Cs_1[randi()%3]]
			elif note_types[position_of_sound] =='B':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], D_1[randi()%3]]
		elif point == 4:
			if note_types[position_of_sound] =='C':
				new_collected_sound = [collected_sound[-1], Ds_1[randi()%3], G_1[randi()%3],C_1[randi()%3]]
			elif note_types[position_of_sound] =='Cs':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], Gs_1[randi()%3],Cs_1[randi()%3]]
			elif note_types[position_of_sound] =='D':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], A_1[randi()%3],D_1[randi()%3]]
			elif note_types[position_of_sound] =='Ds':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], As_1[randi()%3],Ds_1[randi()%3]]
			elif note_types[position_of_sound] =='E':
				new_collected_sound = [collected_sound[-1], G_1[randi()%3], B_1[randi()%3],E_1[randi()%3]]
			elif note_types[position_of_sound] =='F':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Gs_1[randi()%4],F_1[randi()%3]]
			elif note_types[position_of_sound] =='Fs':
				new_collected_sound = [collected_sound[-1], Cs_1[randi()%3], A_1[randi()%3],Fs_1[randi()%3]]
			elif note_types[position_of_sound] =='G':
				new_collected_sound = [collected_sound[-1], D_1[randi()%3], As_1[randi()%3],G_1[randi()%3]]
			elif note_types[position_of_sound] =='Gs':
				new_collected_sound = [collected_sound[-1], B_1[randi()%3], Ds_1[randi()%3],Gs_1[randi()%3]]
			elif note_types[position_of_sound] =='A':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], C_1[randi()%3],A_1[randi()%3]]
			elif note_types[position_of_sound] =='As':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Cs_1[randi()%3],As_1[randi()%3]]
			elif note_types[position_of_sound] =='B':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], D_1[randi()%3],B_1[randi()%3]]
		elif point == 5:
			if note_types[position_of_sound] =='C':
				new_collected_sound = [collected_sound[-1], Ds_1[randi()%3], G_1[randi()%3],C_1[randi()%3],Ds_1[randi()%3]]
			elif note_types[position_of_sound] =='Cs':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], Gs_1[randi()%3],Cs_1[randi()%3],E_1[randi()%3]]
			elif note_types[position_of_sound] =='D':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], A_1[randi()%3],D_1[randi()%3],F_1[randi()%3]]
			elif note_types[position_of_sound] =='Ds':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], As_1[randi()%3],Ds_1[randi()%3],Fs_1[randi()%3]]
			elif note_types[position_of_sound] =='E':
				new_collected_sound = [collected_sound[-1], G_1[randi()%3], B_1[randi()%3],E_1[randi()%3],G_1[randi()%3]]
			elif note_types[position_of_sound] =='F':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Gs_1[randi()%4],F_1[randi()%3],F_1[randi()%3]]
			elif note_types[position_of_sound] =='Fs':
				new_collected_sound = [collected_sound[-1], Cs_1[randi()%3], A_1[randi()%3],Fs_1[randi()%3],Cs_1[randi()%3]]
			elif note_types[position_of_sound] =='G':
				new_collected_sound = [collected_sound[-1], D_1[randi()%3], As_1[randi()%3],G_1[randi()%3],D_1[randi()%3]]
			elif note_types[position_of_sound] =='Gs':
				new_collected_sound = [collected_sound[-1], B_1[randi()%3], Ds_1[randi()%3],Gs_1[randi()%3],B_1[randi()%3]]
			elif note_types[position_of_sound] =='A':
				new_collected_sound = [collected_sound[-1], E_1[randi()%3], C_1[randi()%3],A_1[randi()%3],E_1[randi()%3]]
			elif note_types[position_of_sound] =='As':
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Cs_1[randi()%3],As_1[randi()%3],F_1[randi()%3]]
			elif note_types[position_of_sound] =='B':
				new_collected_sound = [collected_sound[-1], Fs_1[randi()%3], D_1[randi()%3],B_1[randi()%3],Fs_1[randi()%3]]
	else:
		print('invalid note scale')


	print(new_collected_sound.size())
	Matrix.reset_all_variables(disable_button, new_collected_sound)

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
