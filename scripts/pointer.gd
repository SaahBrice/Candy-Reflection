extends Node2D

onready var object_position = $pointer.position
onready var object = $pointer
onready var tween = $Tween
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	#timer.set_wait_time()
	timer.set_one_shot(false)
	timer.connect("timeout",self, "animate")
	add_child(timer)
	timer.start()
	#animate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func animate():
	tween.start()
	tween.interpolate_property(object, "position", object_position, object_position + Vector2(0,50), SceneController.pointer_speed, Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	yield(get_tree().create_timer(0.5), "timeout")
	tween.interpolate_property(object, "position", object_position + Vector2(0,50), object_position, SceneController.pointer_speed, Tween.TRANS_SINE,Tween.EASE_IN_OUT)	
	yield(get_tree().create_timer(0.5), "timeout")
