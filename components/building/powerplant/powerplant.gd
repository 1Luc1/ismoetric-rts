extends Building


var buildings: Array[Dictionary] = [
		{"icon":"path1434_icon.png", "index":2, "size": Vector2i(1, 1), "cost": 480.00},
		{"icon":"g2387_icon.png", "index":3, "size": Vector2i(2, 2), "cost": 1360.00}
	]


func _on_animated_sprite_2d_animation_finished():
	super._on_animated_sprite_2d_animation_finished()
	$GPUParticles2D.visible = true
	$GPUParticles2D2.visible = true
	get_tree().call_group("gui", "add_buildings", buildings)
	get_tree().call_group("gui", "add_power", 20)

