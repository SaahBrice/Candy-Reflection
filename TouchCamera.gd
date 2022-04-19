extends Camera2D

#export (NodePath) var target
var target

# Optional: export these properties for convenient editing.
var target_return_enabled = true
export (float) var target_return_rate = 2

export (float) var drag_speed = 0.5


export (float) var scroll_upper_limit = -900
var y
var min_zoom = 0.5
var max_zoom = 2
var zoom_sensitivity = 10
var zoom_speed = 0.05

var events = {}
var last_drag_distance = 0


func _ready() -> void:
	#position = SceneController.camera_position
	pass

func _process(delta):
	if target and target_return_enabled and events.size() == 0:
		#position = lerp(position, get_node(target).position, target_return_rate)
		position.y = lerp(position.y, target.rect_position.y, target_return_rate)
		#position.y = lerp(position.y, get_node(target).position.y, target_return_rate)

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			events[event.index] = event
		else:
			events.erase(event.index)
	if event is InputEventScreenDrag:
		events[event.index] = event
		if events.size() == 1:
			#position += event.relative.rotated(rotation) * zoom.x
			#position =lerp(position, position + event.relative.rotated(rotation)*zoom.x, drag_speed)
			position.y =lerp(position.y - event.relative.rotated(rotation).y*zoom.x ,position.y, drag_speed)
			if position.y >=800:
				position.y = 800
			if position.y <= scroll_upper_limit:
				position.y = scroll_upper_limit

			print(position)
