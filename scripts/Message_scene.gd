extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var activate_exiting_transition = false
onready var new_scene  =  SceneController.new_scene
var messages = [
	'"She always told me to show my best face to the mirror and i will be happy with the face looking back at me."',
	'"She was beautiful, soft, and smooth like her mirrors."',
	'"She always told me that when i give to others, i give to myself."',
	'"Eventually, everything has a reflection."',
	'"When you are stucked, tap on the bulb icon."',
	'"To cancel all, tap on the cross icon."',
	'"It takes one step to be bold."',
	'"Remember to do your best every day."',
	'"Relax, Reflect, feel great."',
	'"Did you combine a nice progression?"',
	'"Sometimes, it is ok to be numb."',
	'"You are smarter than you think you are. Give it anothe try."',
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	if !activate_exiting_transition:
		$BackgroundGameG2.modulate.a = 0
	var choice = randi() % (messages.size()) # Returns random integer between 1 and 100
	$text_message.text = str(messages[choice])
	start_counter()

func start_counter():
	yield(get_tree().create_timer(SceneController.message_speed), "timeout")
	exiting_transition()
	yield(get_tree().create_timer(0.5),"timeout")
	activate_exiting_transition = false
	Sounds.sound_collection.piano_level_music.stop()
	get_tree().change_scene(new_scene)



func exiting_transition():
	activate_exiting_transition = true

func _process(delta: float) -> void:
	if activate_exiting_transition:
		$BackgroundGameG2.modulate.a += SceneController.transition_speed*delta
