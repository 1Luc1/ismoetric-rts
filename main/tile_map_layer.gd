extends TileMapLayer

@onready var building_floor: TileMapLayer = $building

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_released("left_mouse_btn"):
			get_tree().call_group("input_handler", "drag_end")
		if Input.is_action_just_pressed("right_mouse_btn") and cell_empty():
			get_tree().call_group("input_handler", "empty_cell_clicked", get_global_mouse_position())
		if Input.is_action_just_pressed("left_mouse_btn") and cell_empty():
			get_tree().call_group("input_handler", "unselect")
	if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_LEFT:
		get_tree().call_group("input_handler", "drag", get_global_mouse_position())


func build(target, tile_id) -> void:
	var source_id := 4
	var coords = local_to_map(target)
	var atlas_coords = Vector2i(0,0)
	building_floor.set_cell(coords, source_id, atlas_coords, tile_id)


func remove_navigation(target, size) -> void:
	var coords = local_to_map(target)
	var move_cords: Vector2i = coords
	for x in size.x:
		set_cell(move_cords, 1, Vector2i(0,0), 1)
		for y in size.y-1:
			move_cords = get_neighbor_cell(move_cords, TileSet.CELL_NEIGHBOR_TOP_RIGHT_SIDE)
			set_cell(move_cords, 1, Vector2i(0,0), 1)
		move_cords = get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_TOP_LEFT_SIDE)


func cell_empty() -> bool:
	var mouse_pos = get_global_mouse_position()
	var coords := local_to_map(mouse_pos)
	var empty_cell = get_cell_source_id(coords) == -1
	var space = get_world_2d().direct_space_state
	var point = PhysicsPointQueryParameters2D.new()
	point.position = mouse_pos
	return empty_cell and space.intersect_point(point, 1, ).size() == 0


func getCellGlobalPosition(globalPosition: Vector2) -> Vector2:
	return to_global(map_to_local(local_to_map(to_local(globalPosition))))
