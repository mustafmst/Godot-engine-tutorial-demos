extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

enum ENTITY_TYPES { PLAYER, OBSTACLE, COLLECTIBLE }

var grid_size = Vector2(20,11)
var grid = []

onready var Obstacle = preload("res://Obstacle.tscn")


func _ready():
	# 1. Create the grid Array
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var player = get_node("Player")
	var start_position = update_child_pos(player)
	player.set_pos(start_position)
	
	# 2. Create obstacles
	var positions = []
	for n in range(5):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid_pos in positions:
			positions.append(grid_pos)
	
	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.set_pos(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y] = ENTITY_TYPES.OBSTACLE
		add_child(new_obstacle)
	pass


func is_cell_vacant(pos, direction):
	# Return true if the cell is vacant, else false
	var new_pos = world_to_map(pos) + direction
	if new_pos.x < grid_size.x and new_pos.x >= 0:
		if new_pos.y < grid_size.y and new_pos.y >= 0:
			if grid[new_pos.x][new_pos.y] == null:
				return true
	
	return false


func update_child_pos(child):
	# Move a child to a new position in the grid Array
	# Returns the new target world position of the child
	
	var grid_pos = world_to_map(child.get_pos())
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + child.direction
	grid[grid_pos.x][grid_pos.y] = child.type
	return map_to_world(new_grid_pos) + half_tile_size
