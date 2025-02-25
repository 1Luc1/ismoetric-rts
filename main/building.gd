extends TileMapLayer

func build(target, tile_id) -> void:
	var source_id := 4
	var coords = get_parent().local_to_map(target)
	var atlas_coords = Vector2i(0,0)
	set_cell(coords, source_id, atlas_coords, tile_id)

func remove_navigation(target, size) -> void:
	get_parent().remove_navigation(target, size)
