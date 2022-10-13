class_name UnitSelected
extends State

var selected_unit

func enter(msg := {}) -> void:
	if msg.has("unit"):
		select_unit(msg.unit)

func unit_clicked(unit: CharacterBody2D) -> void:
	select_unit(unit)
	
func empty_cell_clicked(target) -> void:
	selected_unit.set_target_location(target)
	
func icon_selected(data) -> void:
	selected_unit.unselect()
	state_machine.transition_to("BuildMode", data)
	
func building_clicked(building: StaticBody2D) -> void:
	selected_unit.unselect()
	state_machine.transition_to("BuildingSelected", {"building": building})
	
func unselect() -> void:
	selected_unit.unselect()
	selected_unit = null
	state_machine.transition_to("NothingSelected")

func select_unit(unit):
	if selected_unit:
		selected_unit.unselect()
	selected_unit = unit
	selected_unit.select()
	
