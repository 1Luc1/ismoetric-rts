extends Building


var units: Array[Dictionary] = [
		{"icon":"mvc_icon.png", "scene":"res://components/vehicle/mcv/mcv.tscn"},
		{"icon":"soldier_icon.png", "scene":"res://components/units/soldier/soldier.tscn"}
	]

var waypoint_resource = preload("res://components/building/waypoint.tscn")
var waypoint

func _ready():
	super._ready()
	waypoint = waypoint_resource.instantiate()
	waypoint.visible = false
	get_parent().add_child(waypoint)

func _on_animated_sprite_2d_animation_finished():
	super._on_animated_sprite_2d_animation_finished()
	waypoint.global_position = $WaypointMarker.global_position
	get_tree().call_group("gui", "add_units", self, units)
	
func spawn_unit(unit_data):
	var unit = super.spawn_unit(unit_data)
	unit.global_position = $SpawnMarker.global_position
	unit.set_target_location(waypoint.global_position)
	
func set_waypoint(target):
	if waypoint:
		get_parent().remove_child(waypoint)
	waypoint.global_position = target
	get_parent().add_child(waypoint)
	waypoint.visible = true
	
func select():
	super.select()
	if waypoint:
		waypoint.visible = true

func unselect():
	super.unselect()
	if waypoint:
		waypoint.visible = false
