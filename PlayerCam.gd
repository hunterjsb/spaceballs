extends Camera2D

signal camera_lock_toggled(is_locked)

@export var zoom_speed = 0.1
@export var min_zoom = 0.1
@export var max_zoom = 5.0
@export var camera_locked = false

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		zoom_camera(zoom_speed)
	elif event.is_action_pressed("zoom_out"):
		zoom_camera(-zoom_speed)
	elif event.is_action_pressed("toggle_camera_lock"):
		toggle_camera_lock()

func zoom_camera(amount):
	zoom += Vector2.ONE * amount

func toggle_camera_lock():
	camera_locked = !camera_locked
	emit_signal("camera_lock_toggled", camera_locked)

func _process(delta):
	if camera_locked:
		position = get_node("/root/Space/Earth").position
