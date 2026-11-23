extends Node

@export var timeLabel : Label

var time :float = 0
func _process(delta: float) -> void:
	time+=delta
	timeLabel.text = "%.1f" %time
