extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
signal cancel_pressed
signal ad_completed
onready var tween = $Tween

var game_over_text = [
	"Don't giveup! You lost a battle, not the war.",
	"Oh No! You were almost there.",
	"See through it! You could do it.",
	"Giveup?",
	"You are better than you think.",
	"Don't mind. You will have a good news today.",
	"Breath, Observe, you can do it."

]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass # Replace with function body.signal

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_cancel_pressed() -> void:
	Input.vibrate_handheld(SceneController.button_vibration)
	Sounds.sound_collection.button_pressed.play()
	hide_it()
	emit_signal("cancel_pressed")


func _on_ok_pressed() -> void:
	Input.vibrate_handheld(SceneController.button_vibration)
	Sounds.sound_collection.button_pressed.play()
	#AdvertManager.timer_reset_adv()
	yield(AdvertManager.timer_reset_adv(),'completed')
	emit_signal('ad_completed')
	hide_it()

func show_it():
	Sounds.sound_collection.move_down.play()
	$Sprite/Label.text = str(game_over_text[randi() % game_over_text.size()])
	tween.interpolate_property(self,'position', position,Vector2(0,-1548),0.5,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	tween.start()

func hide_it():
	Sounds.sound_collection.move_down.play()
	tween.interpolate_property(self,'position', position,Vector2(0,0),1,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.start()
