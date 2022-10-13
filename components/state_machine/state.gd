# Virtual base class for all states.
class_name State
extends Node

# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine = null


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass

#func unit_clicked(_unit: CharacterBody2D) -> void:
#	pass

func units_clicked(_units: Array) -> void:
	pass
	
func building_clicked(_unit: StaticBody2D) -> void:
	pass
	
func empty_cell_clicked(_target) -> void:
	pass
	
func icon_selected(_data) -> void:
	pass

func unselect() -> void:
	pass
	
func deploy() -> void:
	pass
	
func do_deploy(_unit: CharacterBody2D) -> void:
	pass
	
func reset() -> void:
	pass
	
func drag(_position) -> void:
	pass
	
func drag_end() -> void:
	pass
	
func delete_clicked() -> void:
	pass

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
