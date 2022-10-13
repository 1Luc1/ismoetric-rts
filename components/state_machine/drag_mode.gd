class_name DragMode
extends State

@export var select_drag := NodePath()
@onready var selectdraw = get_node(select_drag)

var start_position

func enter(msg := {}) -> void:
	if msg.has("position"):
		start_position = msg.position
	
func drag(position):
	selectdraw.update_status(start_position, position, true)
	
func drag_end():	
	var units:Array[CharacterBody2D] = []
	units = selectdraw.end()
	state_machine.transition_to("UnitsSelected", {"units": units})
