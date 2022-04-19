extends Node

var original_matrix = []
var number_of_moves = 0
var hint_number = 3
var number_of_cancles = 5

var hint_tiles = []
var tiles_to_cancel = []


var play_sequence = [0,1,2]

#var matrix_size_screen_multiplier = 3.273
var matrix_size_screen_multiplier = 1
var square_size_n_seperation = 90
var screen_size = Vector2(720,1548)


func _ready() -> void:
	randomize()




#
#func return_position(height, width):
#	print(get_viewport().size)
#	var y
#	var x
#	if height%2 ==0:
#		y = (0.5*(get_viewport().size.y*matrix_size_screen_multiplier)+40) - ((height/2) * 90)
#	else:
#		y = (0.5*(get_viewport().size.y*matrix_size_screen_multiplier)-5) - ((height/2) * 90)		
#	if width%2 ==0:
#		x =(0.5*int(get_viewport().size.x*matrix_size_screen_multiplier)+35) - ((width/2) * 90)
#	else:
#		x =(0.5*int(get_viewport().size.x*matrix_size_screen_multiplier)-5) - ((width/2) * 90)
#	print(Vector2(x,y))
#	return Vector2(x,y)

func reset_touched_tiles():
	pass







func return_position(height, width):
	#screen_size=OS.get_window_size()
	var y
	var x
	if height%2 ==0:
		y = (0.5*screen_size.y+40) - ((height/2) * square_size_n_seperation)
	else:
		y = (0.5*screen_size.y) - ((height/2) * square_size_n_seperation)		
	if width%2 ==0:
		x =(0.5*screen_size.x+40) - ((width/2) * square_size_n_seperation)
	else:
		x =(0.5*screen_size.x) - ((width/2) * square_size_n_seperation)
	return Vector2(x,y)

func print_matrix(matrix):
	if len(matrix)==0:
		return
	for x in range(len(matrix)):
		print(matrix[x])


######EVERYCALL FUNCTION
func matrix_y_reflection(matrix):
	var reflected_matrix = []
	for x in range(matrix.size()):
		reflected_matrix.append(matrix[matrix.size()-1-x])
	return reflected_matrix

func matrix_x_reflection(matrix):
	var reflected_matrix = []
	for x in range(matrix.size()):
		reflected_matrix.append([])
		reflected_matrix[x]=[]
		for y in range(matrix[x].size()):
			reflected_matrix[x].append([])
			reflected_matrix[x][y] = matrix[x][matrix[x].size()-1-y]
	return reflected_matrix



func segmentation_x(mirror_axis, mirror_size, original_mat, mirror_position_h,mirror_position_w):
	var total_height=original_mat.size()-1
	var total_length = original_mat[0].size()
	if mirror_size <= total_length-mirror_position_w:
		if mirror_axis =='x':
			var segment1=[]
			var segment2=[]
			if mirror_position_h < total_height:
				if mirror_position_h+1 <= 0.5*total_height:
					var x_size = mirror_size 
					var y_size = mirror_position_h + 1
					var length = mirror_position_w
					for y in range(y_size):
						segment1.append([])
						segment2.append([])
						for x in range(x_size):
							segment1[y].append(original_mat[y][length+x])
							segment2[y].append(original_mat[mirror_position_h+1+y][length+x])
					return [segment1, segment2]
				elif mirror_position_h+1 > 0.5*total_height:
					var x_size = mirror_size 
					var y_size = total_height-mirror_position_h
					var length = mirror_position_w
					for y in range(y_size):
						segment1.append([])
						segment2.append([])
						for x in range(x_size):
							segment1[y].append(original_mat[mirror_position_h-(total_height-mirror_position_h-1-y)][length+x])
							segment2[y].append(original_mat[mirror_position_h+1+y][length+x])
					return [segment1, segment2]
			else:
				print("mirror on last element")
		else:
			print('error, not x passed')
	else:
		print('invalid mirror size at position')


func segmentation_y(mirror_axis, mirror_size, original_mat, mirror_position_h,mirror_position_w):
	var total_height=original_mat.size()
	var total_length = original_mat[0].size()-1
	if mirror_size <= total_height-mirror_position_h:
		if mirror_axis =='y':
			var segment1=[]
			var segment2=[]
			if mirror_position_w < total_length:
				if mirror_position_w+1 <= int(0.5*total_length):
					var x_size = mirror_size 
					var y_size = mirror_position_w+1 
					var height = mirror_position_h
					for y in range(x_size):
						segment1.append([])
						segment2.append([])
						for x in range(y_size):
							segment1[y].append(original_mat[height+y][x])
							segment2[y].append(original_mat[height+y][mirror_position_w+1+x])
					return [segment1, segment2]
				elif mirror_position_w+1 > int(0.5*total_length):
					var x_size = mirror_size 
					var y_size = total_length-mirror_position_w
					var height = mirror_position_h
					for y in range(x_size):
						segment1.append([])
						segment2.append([])
						for x in range(y_size):
							segment1[y].append(original_mat[height+y][mirror_position_w-(total_length-mirror_position_w-1-x)])
							segment2[y].append(original_mat[height+y][mirror_position_w+1+x])
					return [segment1, segment2]
			else:
				print("mirror position on last element")
		else:
			print('error, not y passed')
	else:
		print('invalid mirror size at position')

func mirror_position(matrix_width, matrix_height):
	var axis=randi()%2
	#use 0 for x axis
	if axis == 0:
		if matrix_height <= 1 and matrix_width > 1:
			var mirror_position_w = randi() % matrix_width
			var mirror_position_h = 1
			var mirror_axis = 'x'
			var mirror_size = 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]
		elif matrix_height > 1 and matrix_width <= 1:
			var mirror_position_w = 1
			var mirror_position_h = randi() % (matrix_height-1)
			var mirror_axis = 'x'
			var mirror_size = 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]
		elif matrix_height == 1 and matrix_width == 1:
			var mirror_position_w = 1
			var mirror_position_h = 1
			var mirror_axis = 'x'
			var mirror_size = 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]
		elif matrix_height > 1 and matrix_width > 1:
			var mirror_position_w = randi() % matrix_width
			var mirror_position_h = randi() % (matrix_height-1)
			var mirror_axis = 'x'
			var mirror_size = randi()% (matrix_width-mirror_position_w) + 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]
	elif axis == 1:
		if matrix_height <= 1 and matrix_width > 1:
			var mirror_position_w = randi() % (matrix_width-1)
			var mirror_position_h = 1
			var mirror_axis = 'y'
			var mirror_size = 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]
		elif matrix_height > 1 and matrix_width <= 1:
			var mirror_position_w = 1
			var mirror_position_h = randi() % matrix_height
			var mirror_axis = 'y'
			var mirror_size = 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]
		elif matrix_height == 1 and matrix_width == 1:
			var mirror_position_w = 1
			var mirror_position_h = 1
			var mirror_axis = 'y'
			var mirror_size = 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]
		elif matrix_height > 1 and matrix_width > 1:
			var mirror_position_w = randi() % (matrix_width-1)
			var mirror_position_h = randi() % matrix_height
			var mirror_axis = 'y'
			var mirror_size = randi()% (matrix_height-mirror_position_h) + 1
			return [mirror_position_h, mirror_position_w, mirror_axis, mirror_size]




func get_position_in_2D_array(matrix,element):
	var failed = Vector2(-1,-1)
	for x in range(matrix.size()):
		for y in range(matrix[x].size()):
			if matrix[x][y].position == element:
				return Vector2(x,y)
	return failed


func disable_buttons(button):
	for buttons in button:
		buttons.get_node('TextureButton').disabled=true
func enable_buttons(button):
	for buttons in button:
		buttons.get_node('TextureButton').disabled=false
		

#this funtion will return a list of possible mirrored points which
#could be use for hint and number of moves
func save_hint_and_numb_of_moves(segmenta, segmentb, direction, origine):
	var height = segmenta.size()
	var width = segmenta[0].size()
	var segment_set = []
	if direction == 'y':
		for x in range(height):
			if width == 1:
				if segmenta[x][0] == 1 and segmentb[x][0] !=1:
					segment_set.append(origine[1][x][0])
				elif segmentb[x][0]==1 and segmenta[x][0]!=1:
					segment_set.append(origine[0][x][0])
			else:
				for y in range(width):
					if segmenta[x][y] == 1 and segmentb[x][width-y-1] !=1:
						segment_set.append(origine[1][x][width-y-1])
					elif segmentb[x][y]==1 and segmenta[x][width-y-1]!=1:
						segment_set.append(origine[0][x][width-y-1])
	elif direction == 'x':
		if height == 1:
			for x in range(height):
				for y in range(width):
					if segmenta[x][y] == 1 and segmentb[x][y] !=1:
						segment_set.append(origine[1][x][y])
					elif segmentb[x][y]==1 and segmenta[x][y]!=1:
						segment_set.append(origine[0][x][y])
		else:
			for x in range(height):
				for y in range(width):	
					if segmenta[x][y] == 1 and segmentb[height-x-1][y] !=1:
						segment_set.append(origine[1][height-x-1][y])
					elif segmentb[x][y]==1 and segmenta[height-x-1][y]!=1:
						segment_set.append(origine[0][height-x-1][y])
	return segment_set



func compare_hint_sets(hint1,hint2):
	var compared = []
	for hint in hint2:
		if hint in hint1:
			hint1.erase(hint)
	compared.append(hint1)
	compared.append(hint2)
	return compared

func blink(tile, touched_color, original_color):
	tile.get_node('win').emitting = true
	Sounds.sound_collection.cancel_tile.play()
	yield(get_tree().create_timer(0.5),"timeout")
	tile.get_node('win').emitting = false



func reset_all_variables(disable_button,collected_sound):
	enable_buttons(disable_button)
	original_matrix = []
	#Sounds.get_sound(level,collected_sound)
	
	for sounds in collected_sound:
		if collected_sound.count(sounds)>1:
			collected_sound.erase(sounds)
			print('Erased')
	for sounds in collected_sound:
		sounds.play()
		yield(get_tree().create_timer(0.1), "timeout")
	Input.vibrate_handheld(SceneController.winning_vibration)


func reset_all_variables1(disable_button,level,collected_sound):
	var pointer = play_sequence[randi()%3]
	print('value')
	print(pointer)
	enable_buttons(disable_button)
	original_matrix = []
	collected_sound = Sounds.get_sound(level,collected_sound)
	for sounds in collected_sound:
		if collected_sound.count(sounds)>1:
			collected_sound.erase(sounds)
			print('Erased')
	if pointer == 0:
		for sounds in collected_sound:
			sounds.play()
			yield(get_tree().create_timer(0.3), "timeout")
		yield(get_tree().create_timer(0.5), "timeout")
		for sounds in collected_sound:
			sounds.play()
			yield(get_tree().create_timer(0.1), "timeout")
	elif pointer == 1:
		for sounds in collected_sound:
			sounds.play()
			yield(get_tree().create_timer(0.1), "timeout")
	elif pointer == 2:
		for sounds in collected_sound:
			sounds.play()
			yield(get_tree().create_timer(0.3), "timeout")
	Input.vibrate_handheld(SceneController.winning_vibration)


func game_player_1_mirrors(binary_matrix, tile_matrix, mirror1):
	var terminated = true
	var one_zero_matrix = binary_matrix
	var main_matirx = tile_matrix
	var segmentsA = resegment_player_matrix(one_zero_matrix, main_matirx, mirror1)
	var partA_one_zero = segmentsA[0]
	var partA_tile = segmentsA[1]
	var pA_1 =partA_one_zero[0]
	var pA_2 = partA_one_zero[1]
	var h1 = pA_1.size()
	var w1 = pA_1[0].size()
	if mirror1[2] == 'y':
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if terminated:
		return [one_zero_matrix,hint_tiles]
	else:
		return game_player_1_mirrors(one_zero_matrix, main_matirx, mirror1)







func game_player_2_mirrors(binary_matrix, tile_matrix, mirror1, mirror2):
	var terminated = true
	var one_zero_matrix = binary_matrix
	var main_matirx = tile_matrix
	var segmentsA = resegment_player_matrix(one_zero_matrix, main_matirx, mirror1)
	var segmentsB = resegment_player_matrix(one_zero_matrix, main_matirx, mirror2)
	var partA_one_zero = segmentsA[0]
	var partA_tile = segmentsA[1]
	var partB_one_zero = segmentsB[0]
	var partB_tile = segmentsB[1]
	var pA_1 =partA_one_zero[0]
	var pA_2 = partA_one_zero[1]
	var pB_1 =partB_one_zero[0]
	var pB_2 = partB_one_zero[1]
	var h1 = pA_1.size()
	var w1 = pA_1[0].size()
	var h2 = pB_1.size()
	var w2 = pB_1[0].size()
	if mirror1[2] == 'y':
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if mirror2[2] == 'y':
		for x in range(h2):
			for y in range(w2):
				if pB_1[x][y] == 1 and pB_2[x][w2-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[1][x][w2-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pB_2[x][y] ==1 and pB_1[x][w2-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[0][x][w2-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h2):
			for y in range(w2):
				if pB_1[x][y] == 1 and pB_2[h2-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[1][h2-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pB_2[x][y] ==1 and pB_1[h2-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[0][h2-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if terminated:
		return [one_zero_matrix,hint_tiles]
	else:
		return game_player_2_mirrors(one_zero_matrix, main_matirx, mirror1, mirror2)

	

func game_player_3_mirrors(binary_matrix, tile_matrix, mirror1, mirror2, mirror3):
	var terminated = true
	var one_zero_matrix = binary_matrix
	var main_matirx = tile_matrix
	var segmentsA = resegment_player_matrix(one_zero_matrix, main_matirx, mirror1)
	var segmentsB = resegment_player_matrix(one_zero_matrix, main_matirx, mirror2)
	var segmentsC = resegment_player_matrix(one_zero_matrix, main_matirx, mirror3)
	var partA_one_zero = segmentsA[0]
	var partA_tile = segmentsA[1]
	var partB_one_zero = segmentsB[0]
	var partB_tile = segmentsB[1]
	var partC_one_zero = segmentsC[0]
	var partC_tile = segmentsC[1]
	var pA_1 =partA_one_zero[0]
	var pA_2 = partA_one_zero[1]
	var pB_1 =partB_one_zero[0]
	var pB_2 = partB_one_zero[1]
	var pC_1 =partC_one_zero[0]
	var pC_2 = partC_one_zero[1]
	var h1 = pA_1.size()
	var w1 = pA_1[0].size()
	var h2 = pB_1.size()
	var w2 = pB_1[0].size()
	var h3 = pC_1.size()
	var w3 = pC_1[0].size()
	if mirror1[2] == 'y':
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if mirror2[2] == 'y':
		for x in range(h2):
			for y in range(w2):
				if pB_1[x][y] == 1 and pB_2[x][w2-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[1][x][w2-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pB_2[x][y] ==1 and pB_1[x][w2-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[0][x][w2-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h2):
			for y in range(w2):
				if pB_1[x][y] == 1 and pB_2[h2-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[1][h2-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pB_2[x][y] ==1 and pB_1[h2-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[0][h2-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if mirror3[2] == 'y':
		for x in range(h3):
			for y in range(w3):
				if pC_1[x][y] == 1 and pC_2[x][w3-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[1][x][w3-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pC_2[x][y] ==1 and pC_1[x][w3-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[0][x][w3-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h3):
			for y in range(w3):
				if pC_1[x][y] == 1 and pC_2[h3-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[1][h3-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pC_2[x][y] ==1 and pC_1[h3-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[0][h3-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if terminated:
		return [one_zero_matrix,hint_tiles]
	else:
		return game_player_3_mirrors(one_zero_matrix, main_matirx, mirror1, mirror2, mirror3)



func game_player_4_mirrors(binary_matrix, tile_matrix, mirror1, mirror2, mirror3, mirror4):
	var terminated = true
	var one_zero_matrix = binary_matrix
	var main_matirx = tile_matrix
	var segmentsA = resegment_player_matrix(one_zero_matrix, main_matirx, mirror1)
	var segmentsB = resegment_player_matrix(one_zero_matrix, main_matirx, mirror2)
	var segmentsC = resegment_player_matrix(one_zero_matrix, main_matirx, mirror3)
	var segmentsD = resegment_player_matrix(one_zero_matrix, main_matirx, mirror4)
	var partA_one_zero = segmentsA[0]
	var partA_tile = segmentsA[1]
	var partB_one_zero = segmentsB[0]
	var partB_tile = segmentsB[1]
	var partC_one_zero = segmentsC[0]
	var partC_tile = segmentsC[1]
	var partD_one_zero = segmentsD[0]
	var partD_tile = segmentsD[1]
	var pA_1 =partA_one_zero[0]
	var pA_2 = partA_one_zero[1]
	var pB_1 =partB_one_zero[0]
	var pB_2 = partB_one_zero[1]
	var pC_1 =partC_one_zero[0]
	var pC_2 = partC_one_zero[1]
	var pD_1 =partD_one_zero[0]
	var pD_2 = partD_one_zero[1]
	var h1 = pA_1.size()
	var w1 = pA_1[0].size()
	var h2 = pB_1.size()
	var w2 = pB_1[0].size()
	var h3 = pC_1.size()
	var w3 = pC_1[0].size()
	var h4 = pD_1.size()
	var w4 = pD_1[0].size()
	if mirror1[2] == 'y':
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[x][w1-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][x][w1-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h1):
			for y in range(w1):
				if pA_1[x][y] == 1 and pA_2[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[1][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pA_2[x][y] ==1 and pA_1[h1-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partA_tile[0][h1-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if mirror2[2] == 'y':
		for x in range(h2):
			for y in range(w2):
				if pB_1[x][y] == 1 and pB_2[x][w2-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[1][x][w2-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pB_2[x][y] ==1 and pB_1[x][w2-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[0][x][w2-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h2):
			for y in range(w2):
				if pB_1[x][y] == 1 and pB_2[h2-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[1][h2-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pB_2[x][y] ==1 and pB_1[h2-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partB_tile[0][h2-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if mirror3[2] == 'y':
		for x in range(h3):
			for y in range(w3):
				if pC_1[x][y] == 1 and pC_2[x][w3-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[1][x][w3-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pC_2[x][y] ==1 and pC_1[x][w3-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[0][x][w3-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h3):
			for y in range(w3):
				if pC_1[x][y] == 1 and pC_2[h3-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[1][h3-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pC_2[x][y] ==1 and pC_1[h3-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partC_tile[0][h3-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if mirror4[2] == 'y':
		for x in range(h4):
			for y in range(w4):
				if pD_1[x][y] == 1 and pD_2[x][w4-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partD_tile[1][x][w4-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pD_2[x][y] ==1 and pD_1[x][w4-1-y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partD_tile[0][x][w4-1-y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	else:
		for x in range(h4):
			for y in range(w4):
				if pD_1[x][y] == 1 and pD_2[h4-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partD_tile[1][h4-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
				elif pD_2[x][y] ==1 and pD_1[h4-x-1][y] == 0:
					var pos_ident
					pos_ident=supervised_get_position_in_2D_array(main_matirx,partD_tile[0][h4-x-1][y])
					one_zero_matrix[pos_ident.x][pos_ident.y] = 1
					if main_matirx[pos_ident.x][pos_ident.y] in hint_tiles:
						pass
					else:
						hint_tiles.append(main_matirx[pos_ident.x][pos_ident.y])
					terminated = false
	if terminated:
		return [one_zero_matrix,hint_tiles]
	else:
		return game_player_4_mirrors(one_zero_matrix, main_matirx, mirror1, mirror2, mirror3, mirror4)







func supervised_get_position_in_2D_array(matrix,element):
	var failed = Vector2(-1,-1)
	for x in range(matrix.size()):
		for y in range(matrix[x].size()):
			if matrix[x][y].position == element.position:
				return Vector2(x,y)
	return failed


func resegment_player_matrix(binary_matrix, tile_matrix, mirror1):
	var var_tile
	var var1_0
	if mirror1[2] == 'x':
		var1_0=Matrix.segmentation_x(mirror1[2], mirror1[3], binary_matrix, mirror1[0],mirror1[1])
		var_tile=Matrix.segmentation_x(mirror1[2], mirror1[3], tile_matrix, mirror1[0],mirror1[1])
	elif mirror1[2] == 'y':
		var1_0=Matrix.segmentation_y(mirror1[2], mirror1[3], binary_matrix, mirror1[0],mirror1[1])
		var_tile=Matrix.segmentation_y(mirror1[2], mirror1[3], tile_matrix, mirror1[0],mirror1[1])
	return [var1_0, var_tile]



#func resegment_matrix(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number):
#	if mirror_number == 0:
#		if mirror_axis == 'x':
#			segments=Matrix.segmentation_x(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin=Matrix.segmentation_x(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
#		elif mirror_axis == 'y':
#			segments=Matrix.segmentation_y(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin=Matrix.segmentation_y(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
#	elif mirror_number ==1:
#		if mirror_axis == 'x':
#			segments1=Matrix.segmentation_x(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin1=Matrix.segmentation_x(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
#		elif mirror_axis == 'y':
#			segments1=Matrix.segmentation_y(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin1=Matrix.segmentation_y(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)


#
#func get_segments(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number):
#	if mirror_number==0:
#		if mirror_axis=='x':
#			segments=Matrix.segmentation_x(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin=Matrix.segmentation_x(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
#			if segments[1]==Matrix.matrix_y_reflection(segments[0]) and segments[0]==Matrix.matrix_y_reflection(segments[1]):
#				reload_till_get_possibility_to_reflect(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number)
#
#		elif mirror_axis == 'y':
#			segments=Matrix.segmentation_y(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin=Matrix.segmentation_y(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
#			if segments[1]==Matrix.matrix_x_reflection(segments[0]) and segments[0]==Matrix.matrix_x_reflection(segments[1]):
#				reload_till_get_possibility_to_reflect(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number)
#
#	elif mirror_number==1:
#		if mirror_axis=='x':
#			segments1=Matrix.segmentation_x(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin1=Matrix.segmentation_x(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
#			if segments1[1]==Matrix.matrix_y_reflection(segments1[0]) and segments1[0]==Matrix.matrix_y_reflection(segments1[1]):		
#				reload_till_get_possibility_to_reflect(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number)
#
#		elif mirror_axis == 'y':
#			segments1=Matrix.segmentation_y(mirror_axis, mirror_size, test_matrix, mirror_position_h,mirror_position_w)
#			segments_origin1=Matrix.segmentation_y(mirror_axis, mirror_size, Matrix.original_matrix, mirror_position_h,mirror_position_w)
#			if segments1[1]==Matrix.matrix_x_reflection(segments1[0]) and segments1[0]==Matrix.matrix_x_reflection(segments1[1]):
#				reload_till_get_possibility_to_reflect(mirror_position_h,mirror_position_w,mirror_axis,mirror_size, mirror_number)
