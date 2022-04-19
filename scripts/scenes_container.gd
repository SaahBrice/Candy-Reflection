extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var scenes_level1 = []
var scenes_level2 = []
var scenes_level3 = []
var tutorial_levels = []
var scene
var N_scenes_in_level_one = 25
var N_scenes_in_level_two = 30
var N_scenes_in_level_three = 35
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t1 = preload("res://scenes/tutorial/tuto1.tscn")
	#s1.connect("level_completed",self, 'levelCompleted')
	tutorial_levels.append(t1)
	var t2 = preload("res://scenes/tutorial2/tuto2.tscn")
	tutorial_levels.append(t2)
	var t3 = preload("res://scenes/tutorial3/tuto3.tscn")
	tutorial_levels.append(t3)
	
	for x in range(N_scenes_in_level_one):
		scene = "res://scenes/piano/p" + str(x+1) + "/p" + str(x+1) + ".tscn"
		scene = load(scene)
		scenes_level1.append(scene)
	for y in range(N_scenes_in_level_two):
		scene = "res://scenes/bell/b" + str(y+1) + "/b" + str(y+1) + ".tscn"
		scene = load(scene)
		scenes_level2.append(scene)
	for a in range(N_scenes_in_level_three):
		scene = "res://scenes/sad_ring/s" + str(a+1) + "/s" + str(a+1) + ".tscn"
		scene = load(scene)
		scenes_level3.append(scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
