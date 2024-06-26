extends Node2D

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	var screen_center = screen_size / 2

	$Earth.position = screen_center

func _input(event):
	if event.is_action_pressed("ui_accept"):  # Space key
		print("HOUSTON!!")
		$Rocket.launch()
