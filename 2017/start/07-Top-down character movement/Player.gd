extends KinematicBody2D

var direction = Vector2(0,0)
var velocity = Vector2(0,0)

const TOP = Vector2(0, -1)
const RIGHT = Vector2(1, 0)
const LEFT = Vector2(-1, 0)
const DOWN = Vector2(0, 1)

var speed = 0
const MAX_SPEED = 500


func _ready():
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
	direction = direction.normalized()
	var is_moving = direction.length() != 0
	if is_moving:
		speed = MAX_SPEED
	else:
		speed = 0
	
	velocity = speed * direction * delta
	
	move(velocity)
	pass