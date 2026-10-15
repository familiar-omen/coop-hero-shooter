extends Control

@onready var health_bar : ProgressBar = $HealthBar

func _process(delta: float) -> void:
	var parent = get_parent()
	var health_request : HealthRequest = HealthRequest.new().query(parent)
	
	health_bar.max_value = health_request.maximum
	health_bar.value = health_request.current
