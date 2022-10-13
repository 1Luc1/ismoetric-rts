extends Node


var global_money = 0

func get_money(money):
	var return_money = 0
	if (global_money - money) > 0:
		global_money -= money
		return_money = money
	return return_money
	
func add_money(money):
	global_money += money
