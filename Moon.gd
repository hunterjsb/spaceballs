extends Sprite2D

@export var orbit_speed = 2.0  # Degrees per second
@export var orbit_radius = 300.0
@export var rotation_speed = 0.5  # Degrees per second
@export var mass = 1_000

var orbit_angle = 0.0

func _process(delta):
	# Update orbit
	orbit_angle += orbit_speed * delta
	position = get_parent().get_node("Earth").position + Vector2(cos(orbit_angle), sin(orbit_angle)) * orbit_radius
	
	# Rotate Moon
	rotation_degrees += rotation_speed * delta
