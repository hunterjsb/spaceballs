extends Node2D

var G = 67  # Gravitational constant
var time_scale = 1  # Time scale to make the simulation visible

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	var screen_center = screen_size / 2

	$Earth.position = screen_center
	$Moon.position = $Earth.position + Vector2(300, 0)
	$Moon.velocity = Vector2(0, -320) * time_scale  # Initial orbital velocity
	
	$Rocket.set_earth($Earth)

func _physics_process(delta):
	if not $Rocket.launched:
		apply_gravity($Earth, $Moon, delta)
	else:
		apply_gravity($Earth, $Moon, delta)
		apply_gravity($Earth, $Rocket, delta)
		apply_gravity($Moon, $Rocket, delta)

func apply_gravity(body1: GravitationalBody, body2: GravitationalBody, delta: float):
	var force = body1.gravitational_force(body2) * G * time_scale
	body1.apply_force(force * delta)
	body2.apply_force(-force * delta)

func _input(event):
	if event.is_action_pressed("ui_accept"):  # Space key
		print("HOUSTON!!")
		$Rocket.launch()
