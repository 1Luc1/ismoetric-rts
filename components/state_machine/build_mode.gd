class_name BuildMode
extends State

@export var tile_map := NodePath()
@export var build_area := NodePath()

@onready var tilemap: TileMap = get_node(tile_map)
@onready var buildarea: Area2D = get_node(build_area)

var tile_id
var btn

func enter(msg := {}) -> void:
	if msg.has("tile_id"):
		tile_id = msg.tile_id
		buildarea.enable(msg.size)
		btn = msg.btn
		
func unselect() -> void:
	buildarea.disable()
	state_machine.transition_to("NothingSelected")

func empty_cell_clicked(target):
	if buildarea.is_valid():
		buildarea.disable()
		tilemap.build(target, tile_id)
		get_tree().call_group("fog_handler", "blend_fog", target)
		tilemap.remove_navigation(target, buildarea.size)
		btn.reset()
		state_machine.transition_to("NothingSelected")

