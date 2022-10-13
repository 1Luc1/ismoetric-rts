class_name BuildingSelected
extends State

var selected_unit

func enter(msg := {}) -> void:
	if msg.has("building"):
		select_unit(msg.building)

#func unit_clicked(unit: CharacterBody2D) -> void:
#	selected_unit.unselect()
#	state_machine.transition_to("UnitSelected", {"unit": unit})

func units_clicked(units: Array) -> void:
	selected_unit.unselect()
	state_machine.transition_to("UnitsSelected", {"units": units})

func empty_cell_clicked(target) -> void:
	selected_unit.set_waypoint(target)
	
func delete_clicked() -> void:
	selected_unit.unselect()
	selected_unit.destroy()
	state_machine.transition_to("NothingSelected")

func building_clicked(building: StaticBody2D) -> void:
	select_unit(building)

func icon_selected(data) -> void:
	selected_unit.unselect()
	state_machine.transition_to("BuildMode", data)
	
func unselect() -> void:
	selected_unit.unselect()
	state_machine.transition_to("NothingSelected")

func select_unit(unit):
	if selected_unit:
		selected_unit.unselect()
	selected_unit = unit
	selected_unit.select()
