class_name Building
extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

var outline = preload("res://components/building/building.tres")


func _ready():
	if anim:
		anim.play("build")


func _unhandled_input(_event):
	if is_selected() and Input.is_action_just_pressed("delete"):
		print("delete hit")
		get_tree().call_group("input_handler", "delete_clicked")


func _on_select_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_just_pressed("left_mouse_btn"):
			get_tree().call_group("input_handler", "building_clicked", self)


func spawn_unit(unit_data) -> CharacterBody2D:
	var unit_res = load(unit_data.scene)
	var unit = unit_res.instantiate()
	get_parent().add_child(unit)
	return unit


func set_waypoint(_target):
	pass


func select():
	sprite.set_material(outline)


func is_selected() -> bool:
	return sprite.material != null


func unselect():
	sprite.material = null


func destroy():
	queue_free()


func _on_animated_sprite_2d_animation_finished():
	sprite.visible = true
	anim.visible = false


func _on_building_area_area_entered(area: Area2D):
	if area.is_in_group("build_area"):
		modulate = Color(1,0.1,0.1, 0.8)


func _on_building_area_area_exited(area):
	if area.is_in_group("build_area"):
		modulate = Color(1,1,1,1)
