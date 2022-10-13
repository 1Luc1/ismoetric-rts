extends Building


func _on_animated_sprite_2d_animation_finished():
	super._on_animated_sprite_2d_animation_finished()
	$GPUParticles2D.visible = true
	$GPUParticles2D2.visible = true
