extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func play_hint_adv():
	print("hint add")


func load_cancels_adv():
	print("cancel add")


func timer_reset_adv():
	
	yield(get_tree().create_timer(2),"timeout")
	print('timer advert')
	pass
