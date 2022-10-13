class_name NothingSelected
extends State

#func unit_clicked(unit: CharacterBody2D) -> void:
#	state_machine.transition_to("UnitSelected", {"unit": unit})
	
func units_clicked(units: Array) -> void:
	state_machine.transition_to("UnitsSelected", {"units": units})

func icon_selected(data) -> void:
	state_machine.transition_to("BuildMode", data)
	
func building_clicked(building: StaticBody2D) -> void:
	state_machine.transition_to("BuildingSelected", {"building": building})
	
func drag(position) -> void:
	state_machine.transition_to("DragMode", {"position": position})
