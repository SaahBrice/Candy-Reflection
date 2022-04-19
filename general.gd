extends Node







































onready var tile = preload("res://Node2D.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var positions=[]
var array_width=3
var array_height=5
var y_display=10
var x_display = 10
var mirror_size = 2
var mirror_axis = 'x'
var mirror_x = 0
var mirror_y = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_out_original_grid()
	print_out_mirror()
	
			


func print_out_original_grid():
	print(get_viewport().size)
	if array_height%2 ==0:
		$main_matrix_position.position.y = (0.5*(get_viewport().size.y*3.273)+40) - ((array_height/2) * 90)
	else:
		$main_matrix_position.position.y = (0.5*(get_viewport().size.y*3.273)-5) - ((array_height/2) * 90)		
	if array_width%2 ==0:
		$main_matrix_position.position.x =(0.5*int(get_viewport().size.x*3.273)+35) - ((array_width/2) * 90)
	else:
		$main_matrix_position.position.x =(0.5*int(get_viewport().size.x*3.273)-5) - ((array_width/2) * 90)
				
	print((0.5*int(get_viewport().size.x*3.273)+15) - ((array_width/2) * 90))
	for x in range(array_height):
		positions.append([])
		for y in range(array_width):
			var test_squares = tile.instance()
			test_squares.position =  Vector2(y*90, x*90)
			positions[x].append(Vector2(x, y))
			$main_matrix_position.call_deferred("add_child", test_squares)
	for x in range(positions.size()):
		print(positions[x])
func print_out_mirror():
	if mirror_axis == 'y':
		var mirror = $mirror
		mirror.scale.y =0.1
		mirror.scale.x = mirror.scale.x*mirror_size*1.2
		mirror.position.x = $main_matrix_position.position.x + mirror_x*90 + 50
		if mirror_size%2==0:
			mirror.position.y = $main_matrix_position.position.y + (mirror_y-0.5+mirror_size/2)*(90)
		else:
			mirror.position.y = $main_matrix_position.position.y + (mirror_y+0.08+mirror_size/2)*(90)
	elif mirror_axis == 'x':
		var mirror = $mirror
		mirror.scale.x =0.1
		mirror.scale.y = mirror.scale.y*mirror_size*1.2
		mirror.position.y = $main_matrix_position.position.y + mirror_y*90 +50
		print($main_matrix_position.position.y)
		if mirror_size%2==0:
			mirror.position.x = $main_matrix_position.position.x + (mirror_x-0.5+mirror_size/2)*(90)
		else:
			mirror.position.x = $main_matrix_position.position.x + (mirror_x+0.08+mirror_size/2)*(90)
			
