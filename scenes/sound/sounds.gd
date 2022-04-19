extends Node2D


var sound_collection = {}


var note_types = [
	'C','Cs','D','Ds','E','F','Fs','G','Gs','A','As','B'
]

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


onready var C_2 = [$music_box/C/C3,$music_box/C/C4,$music_box/C/C5,$music_box/C/C6]
onready var Cs_2 = [$music_box/Cs/Cs3,$music_box/Cs/Cs4,$music_box/Cs/Cs5]
onready var D_2 = [$music_box/D/D3,$music_box/D/D4,$music_box/D/D5]
onready var Ds_2 = [$music_box/Ds/Ds3,$music_box/Ds/Ds4,$music_box/Ds/Ds5]
onready var E_2 = [$music_box/E/E3,$music_box/E/E4,$music_box/E/E5]
onready var F_2 = [$music_box/F/F3,$music_box/F/F4,$music_box/F/F5]
onready var Fs_2 = [$music_box/Fs/Fs3,$music_box/Fs/Fs4,$music_box/Fs/Fs5]
onready var G_2 = [$music_box/G/G3,$music_box/G/G4,$music_box/G/G5]
onready var Gs_2 = [$music_box/Gs/Gs3,$music_box/Gs/Gs4,$music_box/Gs/Gs5]
onready var A_2 = [$music_box/A/A3,$music_box/A/A4,$music_box/A/A5]
onready var As_2 = [$music_box/As/As3,$music_box/As/As4,$music_box/As/As5]
onready var B_2 = [$music_box/B/B3,$music_box/B/B4,$music_box/B/B5]



onready var C_3 = [$purple_sound/C/C3,$purple_sound/C/C4,$purple_sound/C/C5,$purple_sound/C/C6]
onready var Cs_3 = [$purple_sound/Cs/Cs3,$purple_sound/Cs/Cs4,$purple_sound/Cs/Cs5]
onready var D_3 = [$purple_sound/D/D3,$purple_sound/D/D4,$purple_sound/D/D5]
onready var Ds_3 = [$purple_sound/Ds/Ds3,$purple_sound/Ds/Ds4,$purple_sound/Ds/Ds5]
onready var E_3 = [$purple_sound/E/E3,$purple_sound/E/E4,$purple_sound/E/E5]
onready var F_3 = [$purple_sound/F/F3,$purple_sound/F/F4,$purple_sound/F/F5]
onready var Fs_3 = [$purple_sound/Fs/Fs3,$purple_sound/Fs/Fs4,$purple_sound/Fs/Fs5]
onready var G_3 = [$purple_sound/G/G3,$purple_sound/G/G4,$purple_sound/G/G5]
onready var Gs_3 = [$purple_sound/Gs/Gs3,$purple_sound/Gs/Gs4,$purple_sound/Gs/Gs5]
onready var A_3 = [$purple_sound/A/A3,$purple_sound/A/A4,$purple_sound/A/A5]
onready var As_3 = [$purple_sound/As/As3,$purple_sound/As/As4,$purple_sound/As/As5]
onready var B_3 = [$purple_sound/B/B3,$purple_sound/B/B4,$purple_sound/B/B5]




#var level1_sounds
#onready var level1_sound_notes = [
#	C_1[0],Cs_1[0],D_1[0],Ds_1[0],E_1[0],F_1[0],Fs_1[0],G_1[0],Gs_1[0],A_1[0],As_1[0],B_1[0],
#	C_1[1],Cs_1[1],D_1[1],Ds_1[1],E_1[1],F_1[1],Fs_1[1],G_1[1],Gs_1[1],A_1[1],As_1[1],B_1[1],
#	C_1[2],Cs_1[2],D_1[2],Ds_1[2],E_1[2],F_1[2],Fs_1[2],G_1[2],Gs_1[2],A_1[2],As_1[2],B_1[2],
#	C_1[3]
#]

var level1_sounds
onready var level1_sound_notes = [
	C_1[0],Cs_1[0],D_1[0],Ds_1[0],E_1[0],F_1[0],Fs_1[0],G_1[0],Gs_1[0],A_1[0],As_1[0],B_1[0],
	C_1[1],Cs_1[1],D_1[1],Ds_1[1],E_1[1],F_1[1],Fs_1[1],G_1[1],Gs_1[1],A_1[1],As_1[1],B_1[1],
	C_1[2],Cs_1[2],D_1[2],Ds_1[2],E_1[2],F_1[2],Fs_1[2],G_1[2],Gs_1[2],A_1[2],As_1[2],B_1[2],
	C_1[3]
]

var level2_sounds
onready var level2_sound_notes = [
	C_2[0],Cs_2[0],D_2[0],Ds_2[0],E_2[0],F_2[0],Fs_2[0],G_2[0],Gs_2[0],A_2[0],As_2[0],B_2[0],
	C_2[1],Cs_2[1],D_2[1],Ds_2[1],E_2[1],F_2[1],Fs_2[1],G_2[1],Gs_2[1],A_2[1],As_2[1],B_2[1],
	C_2[2],Cs_2[2],D_2[2],Ds_2[2],E_2[2],F_2[2],Fs_2[2],G_2[2],Gs_2[2],A_2[2],As_2[2],B_2[2],
	C_2[3]
]

var level3_sounds
onready var level3_sound_notes = [
	C_3[0],Cs_3[0],D_3[0],Ds_3[0],E_3[0],F_3[0],Fs_3[0],G_3[0],Gs_3[0],A_3[0],As_3[0],B_3[0],
	C_3[1],Cs_3[1],D_3[1],Ds_3[1],E_3[1],F_3[1],Fs_3[1],G_3[1],Gs_3[1],A_3[1],As_3[1],B_3[1],
	C_3[2],Cs_3[2],D_3[2],Ds_3[2],E_3[2],F_3[2],Fs_3[2],G_3[2],Gs_3[2],A_3[2],As_3[2],B_3[2],
	C_3[3]
]
#onready var level1_sounds = [
#	$'level1_sounds/1',
#	$'level1_sounds/2',
#	$'level1_sounds/3',
#	$'level1_sounds/4',
#	$'level1_sounds/5',
#	$'level1_sounds/6',
#	$'level1_sounds/7',
#	$'level1_sounds/8',
#	$'level1_sounds/9',
#	$'level1_sounds/10',
#	$'level1_sounds/11',
#	$'level1_sounds/12'
#
#]

#onready var level2_sounds = [
#	$'level2_sounds2/1',
#	$'level2_sounds2/2',
#	$'level2_sounds2/3',
#	$'level2_sounds2/4',
#	$'level2_sounds2/5',
#	$'level2_sounds2/6',
#	$'level2_sounds2/7',
#	$'level2_sounds2/8',
#	$'level2_sounds2/9',
#	$'level2_sounds2/10',
#	$'level2_sounds2/11',
#	$'level2_sounds2/12'
#
#]

#onready var level3_sounds = [
#	$'level3_sounds3/1',
#	$'level3_sounds3/2',
#	$'level3_sounds3/3',
#	$'level3_sounds3/4',
#	$'level3_sounds3/5',
#	$'level3_sounds3/6',
#	$'level3_sounds3/7',
#	$'level3_sounds3/8',
#	$'level3_sounds3/9',
#	$'level3_sounds3/10',
#	$'level3_sounds3/11',
#	$'level3_sounds3/12'
#]


var note_scale
var note_scale_values = ['major', 'minor']


func _ready() -> void:
	randomize()
	sound_collection = {
		'no_hints_left':$no_hints_left,
		'no_touches_left':$no_touches_left,
		'button_pressed':$button_pressed,
		'move_up':$move_up,
		'move_down':$move_down,
		'cancel_tile':$cancel_tile,
		'nature_sound':$nature_sound,
		'piano_level_music':$piano_level,
		'very_relaxing_piano':$very_relaxing_piano,
		'rain_thunder':$rain_thunder,
		}
	

	note_scale = note_scale_values[randi() % 2]
	if note_scale == 'major':
		var x = randi()% 25
		level3_sounds = [
			level1_sound_notes[x],level1_sound_notes[x+2],level1_sound_notes[x+4],
			level1_sound_notes[x+5],level1_sound_notes[x+7],level1_sound_notes[x+9],
			level1_sound_notes[x+11],level1_sound_notes[x+12],level1_sound_notes[x],
			level1_sound_notes[x+2],level1_sound_notes[x+4], level1_sound_notes[x+5]
			]
		level1_sounds = [
			level2_sound_notes[x],level2_sound_notes[x+2],level2_sound_notes[x+4],
			level2_sound_notes[x+5],level2_sound_notes[x+7],level2_sound_notes[x+9],
			level2_sound_notes[x+11],level2_sound_notes[x+12],level2_sound_notes[x],
			level2_sound_notes[x+2],level2_sound_notes[x+4], level2_sound_notes[x+5]
			]
		level2_sounds = [
			level3_sound_notes[x],level3_sound_notes[x+2],level3_sound_notes[x+4],
			level3_sound_notes[x+5],level3_sound_notes[x+7],level3_sound_notes[x+9],
			level3_sound_notes[x+11],level3_sound_notes[x+12],level3_sound_notes[x],
			level3_sound_notes[x+2],level3_sound_notes[x+4], level3_sound_notes[x+5]
			]
	elif note_scale == 'minor':
		var x = randi()% 25
		level3_sounds = [
			level1_sound_notes[x],level1_sound_notes[x+2],level1_sound_notes[x+3],
			level1_sound_notes[x+5],level1_sound_notes[x+7],level1_sound_notes[x+8],
			level1_sound_notes[x+10],level1_sound_notes[x+12],level1_sound_notes[x],
			level1_sound_notes[x+2],level1_sound_notes[x+3], level1_sound_notes[x+5]
			]
		level1_sounds = [
			level2_sound_notes[x],level2_sound_notes[x+2],level2_sound_notes[x+3],
			level2_sound_notes[x+5],level2_sound_notes[x+7],level2_sound_notes[x+8],
			level2_sound_notes[x+10],level2_sound_notes[x+12],level2_sound_notes[x],
			level2_sound_notes[x+2],level2_sound_notes[x+3], level2_sound_notes[x+5]
			]
		level2_sounds = [
			level3_sound_notes[x],level3_sound_notes[x+2],level3_sound_notes[x+3],
			level3_sound_notes[x+5],level3_sound_notes[x+7],level3_sound_notes[x+8],
			level3_sound_notes[x+10],level3_sound_notes[x+12],level3_sound_notes[x],
			level3_sound_notes[x+2],level3_sound_notes[x+3], level3_sound_notes[x+5]
			]
	else:
		print("Neither minor nor major")



func get_sound(level, collected_sound):
	var position_of_sound
	if level == 3:
		position_of_sound = level1_sound_notes.find(collected_sound[-1])
		return get_notes(position_of_sound, collected_sound,C_1,Cs_1,D_1,Ds_1,E_1,F_1,Fs_1,G_1,Gs_1,A_1,As_1,B_1)
	elif level == 1:
		position_of_sound = level2_sound_notes.find(collected_sound[-1])
		return get_notes(position_of_sound, collected_sound,C_2,Cs_2,D_2,Ds_2,E_2,F_2,Fs_2,G_2,Gs_2,A_2,As_2,B_2)
	elif level == 2:
		position_of_sound = level3_sound_notes.find(collected_sound[-1])
		return get_notes(position_of_sound, collected_sound,C_3,Cs_3,D_3,Ds_3,E_3,F_3,Fs_3,G_3,Gs_3,A_3,As_3,B_3)



func get_notes(position_of_sound, collected_sound,C_1,Cs_1,D_1,Ds_1,E_1,F_1,Fs_1,G_1,Gs_1,A_1,As_1,B_1):
	var new_collected_sound
	if position_of_sound > 11:
		position_of_sound -= 12
		if position_of_sound > 11:
			position_of_sound -= 12
	if note_scale == 'major':
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
	elif note_scale == 'minor':
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
				new_collected_sound = [collected_sound[-1], F_1[randi()%3], Gs_1[randi()%3],F_1[randi()%3],F_1[randi()%3]]
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
		
	return new_collected_sound
