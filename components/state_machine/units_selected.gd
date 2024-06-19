class_name UnitsSelected
extends State

var selected_units = []

func enter(msg := {}) -> void:
	if msg.has("units"):
		var units = msg.units
		if units.size() == 0:
			state_machine.transition_to("NothingSelected")
		else:
			select_units(units)


func drag(position) -> void:
	for unit in selected_units:
		unit.unselect()
	state_machine.transition_to("DragMode", {"position": position})


func units_clicked(units: Array) -> void:
	select_units(units)


func empty_cell_clicked(target) -> void:
	for unit in selected_units:
		unit.set_target_location(target)


func icon_selected(data) -> void:
	for unit in selected_units:
		unit.unselect()
	state_machine.transition_to("BuildMode", data)


func building_clicked(building: StaticBody2D) -> void:
	for unit in selected_units:
		unit.unselect()
	state_machine.transition_to("BuildingSelected", {"building": building})


func unselect() -> void:
	for unit in selected_units:
		unit.unselect()
		unit = null
	state_machine.transition_to("NothingSelected")
	MouseCursor.reset()


func select_units(units):
	for unit in selected_units:
		#if selected_unit:
			#selected_unit.unselect()
		if unit != null and weakref(unit).get_ref():
			unit.unselect()
		
	selected_units = units
	for unit in selected_units:
		unit.select()
	MouseCursor.play_move()
