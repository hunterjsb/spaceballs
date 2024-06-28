extends Node2D

var G = 67  # Gravitational constant

@onready var camera = $Camera2D
var zoom_speed = 0.1
var min_zoom = 0.1
var max_zoom = 5.0

var SpawnedBody = preload("res://SpawnedBody.gd")  # Preload the SpawnedBody script
var bodies = []  # Array to keep track of grav bodies
var charging = false  # Charging rocket


func _ready():
	$Moon.velocity = Vector2(-300, -300)
	$Rocket.set_earth($Earth)
	bodies += [$Earth, $Moon, $Rocket]

func _physics_process(delta):
	# Apply gravity to spawned bodies
	for body in bodies:
		for other_body in bodies:
			if body != other_body:
				apply_gravity(body, other_body, delta)

func apply_gravity(body1: GravitationalBody, body2: GravitationalBody, delta: float):
	var force = body1.gravitational_force(body2) * G
	body1.apply_force(force * delta)
	body2.apply_force(-force * delta)

func _input(event):
	if event.is_action_pressed("ui_accept"):  # Space key pressed
		if $Rocket.launched:
			$Rocket.velocity = Vector2.ZERO
			$Rocket.launched = false
			$Rocket.set_earth($Earth)
		else:
			charging = true
			$Rocket.start_charging()  
	elif event.is_action_released("ui_accept"):  # Space key released
		if charging:
			charging = false
			$Rocket.launch()
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed and Input.is_key_pressed(KEY_CTRL):
			zoom_camera(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed and Input.is_key_pressed(KEY_CTRL):
			zoom_camera(-zoom_speed)
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			spawn_body(get_global_mouse_position())

func _process(delta):
	if charging:
		$Rocket.continue_charging(delta)

func zoom_camera(zoom_factor):
	var new_zoom = camera.zoom + Vector2(zoom_factor, zoom_factor)
	new_zoom = new_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
	camera.zoom = new_zoom
	
func spawn_body(position: Vector2):
	var new_body = SpawnedBody.new()
	new_body.position = position
	new_body.velocity = Vector2(randf_range(-100, 100), randf_range(-100, 100))  # Random initial velocity
	add_child(new_body)
	bodies.append(new_body)
	
	# Ensure the new body is on top of existing bodies
	move_child(new_body, get_child_count() - 1)
