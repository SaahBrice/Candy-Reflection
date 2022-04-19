# Saves and loads savegame files
# Each node is responsible for finding itself in the save_game
# dict so saves don't rely on the nodes' path or their source file
extends Resource



export(String) var new_scene
#
export(bool) var tutorial_completed

################################################################################
############## LEVEL1 VARIABLES ###########################
#
export(int) var level1_completed_levels 
export(bool) var level1_completed
export(int) var current_level_one_value
##################################
export(int) var level2_completed_levels
export(bool) var level2_completed
export(int) var	current_level_two_value
##################################
export(int) var level3_completed_levels
export(bool) var level3_completed
export(int) var	current_level_three_value
##################################
#
#
export(int) var present_level
export(int) var previous_level

export(int) var hint_number
export(int) var number_of_cancles
