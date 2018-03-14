extends KinematicBody2D

const TOP = Vector2(0, -1)
const RIGHT = Vector2(1, 0)
const LEFT = Vector2(-1, 0)
const DOWN = Vector2(0, 1)

var direction = Vector2(0,0)

var grid
var type


func _ready():
	grid = get_parent()
	type = grid.ENTITY_TYPES.PLAYER
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		direction += TOP
	if Input.is_action_pressed("move_down"):
		direction += DOWN
	if Input.is_action_pressed("move_left"):
		direction += LEFT
	if Input.is_action_pressed("move_right"):
		direction += RIGHT
	
	set_pos(grid.update_child_pos(self))
