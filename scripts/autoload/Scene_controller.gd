extends Node

var all_tile_appearing_speed = 1
var new_scene
var clock_time = 15
var tutorial_completed = false
var current_level = 0
var piano_total_level = 20
var pass_it = false

var button_vibration = 100
var tile_vibration = 70
var winning_vibration = 200

var exit_scene_transition =false
var enter_scene_transition = true

var scenes_tests = false
var completed_levels = []

###############################################################################
############# LEVEL1 VARIABLES ###########################
 
var level1_completed_levels = 0
var level1_completed = false
var	current_level_one_value = 25
#################################
var level2_completed_levels = 0
var level2_completed = false
var	current_level_two_value = 30
#################################
var level3_completed_levels = 0
var level3_completed = false
var	current_level_three_value = 35
#################################


var present_level = 0
var previous_level = 0



###############################################################################
##################x    LEVEL COLORS  #############
var l1_orgn = Color8(192,204,214,200)
var l1_touched = Color8(0,140,255,255)

var l2_orgn = Color8(192,204,214,200)
var l2_touched = Color8(255,255,0,255)

var l3_orgn = Color8(192,204,214,150)
var l3_touched = Color8(43,255,222,255)




#################################################################



var transition_speed = 1
var tile_appearing_speed = 0.5
var pointer_speed = 1

var touched_scene = 0

var original_color = Color8(192,204,214,200)
var scene3colour = Color8(230,61,196,255)
var scene2colour = Color8(0,255,0,255)
var scene1colour = Color8(0,140,255,255)

var camera_position = Vector2(320,700)

var message_speed = 5
var dark_screen_speed = 3

var old_level = 1
var old_level_scene
var old_level_scene2

var off_menu_buttons = false


var level1 = Vector2(0,0)
var level2 = Vector2(-700,0)
var level3 = Vector2(-1400,0)

var levels_position = [level1,level2,level3]


