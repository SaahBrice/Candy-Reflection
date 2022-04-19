extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
signal tile_touched

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TextureButton_pressed() -> void:
		emit_signal("tile_touched",self.position.y/90,self.position.x/90)

