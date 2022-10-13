class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()


# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: State = get_node(initial_state)


func _ready() -> void:
	await owner.ready
	add_to_group("input_handler")

	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	state.enter()


#func unit_clicked(unit: CharacterBody2D):
#	state.unit_clicked(unit)

func units_clicked(units: Array):
	state.units_clicked(units)
	
func building_clicked(building: StaticBody2D):
	state.building_clicked(building)
	
func empty_cell_clicked(target):
	state.empty_cell_clicked(target)
	
func icon_selected(data):
	state.icon_selected(data)
	
func unselect():
	state.unselect()
	
func drag(position):
	state.drag(position)

func drag_end():
	state.drag_end()
	
func delete_clicked():
	state.delete_clicked()

# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
