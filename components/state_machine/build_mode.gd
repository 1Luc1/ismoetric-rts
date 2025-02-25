class_name BuildMode
extends State

@export var building_layer := NodePath()
@export var build_area := NodePath()

@onready var buildinglayer: TileMapLayer = get_node(building_layer)
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
		buildinglayer.build(target, tile_id)
		get_tree().call_group("fog_handler", "blend_fog", target)
		buildinglayer.remove_navigation(target, buildarea.size)
		btn.reset()
		state_machine.transition_to("NothingSelected")
