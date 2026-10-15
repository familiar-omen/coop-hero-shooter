class_name TargetLock extends Node

@export var progressBars : Array[ProgressBar]

var amount = 0:
	set(value):
		for bar in progressBars:
			bar.value = value
var maximum = 0:
	set(value):
		for bar in progressBars:
			bar.max_value = value
