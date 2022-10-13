class_name BuildingQueue
extends Node

var queue: Array[BuildButton]

func add(btn: BuildButton):
	if not queue.has(btn):
		queue.push_back(btn)
	var position = queue.find(btn)
	if position == 0:
		btn.start_building()
	else:
		btn.set_queue_cnt(position)


func remove(btn: BuildButton):
	if queue.has(btn):
		for i in range(queue.size()):
			queue[i].set_queue_cnt(i-1)
		var index = queue.find(btn)
		queue.pop_at(index)
		btn.reset_building()
	if queue.size() > 0:
		queue.front().start_building()
