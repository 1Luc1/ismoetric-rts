extends Building

var buildings: Array[Dictionary] = [
		{"icon":"g646-9_icon.png", "index":1, "size": Vector2i(1, 2), "cost": 320.00}
	]


func _on_animated_sprite_2d_animation_finished():
	super._on_animated_sprite_2d_animation_finished()
	get_tree().call_group("gui", "add_buildings", buildings)
	GameData.add_money(5000)


func destroy():
	get_tree().call_group("gui", "remove_buildings", buildings)
	super.destroy()
