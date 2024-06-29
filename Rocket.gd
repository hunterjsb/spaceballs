extends GravitationalBody

var launched = false
var earth: GravitationalBody
var base_launch_speed = 300
var max_launch_speed = 1700
var charge_rate = 500  # How fast the launch speed increases per second
var current_charge = 0
var launch_angle = deg_to_rad(45)  # Launch angle in radians (45 degrees)

@onready var launch_indicator = $LaunchIndicator

func set_earth(earth_body: GravitationalBody):
	earth = earth_body
	update_position()

func update_position():
	if not launched and earth:
		var surface_normal = (position - earth.position).normalized()
		position = earth.position + surface_normal * (earth.radius + radius)
		rotation = surface_normal.angle() + PI/2  # Point rocket away from Earth's center

func start_charging():
	current_charge = 0

func continue_charging(delta):
	current_charge += charge_rate * delta
	current_charge = min(current_charge, max_launch_speed - base_launch_speed)
	update_launch_indicator()

func launch():
	if not launched and earth:
		launched = true
		var surface_normal = (position - earth.position).normalized()
		var launch_direction = surface_normal.rotated(launch_angle)
		var launch_speed = base_launch_speed + current_charge
		velocity = launch_direction * launch_speed
		print("Launching rocket with velocity: ", velocity)
		launch_indicator.points = []  # Hide the indicator

func update_launch_indicator():
	if not launched and earth:
		var surface_normal = (position - earth.position).normalized()
		var launch_direction = surface_normal.rotated(launch_angle)
		var indicator_length = 50 * (1 + current_charge / (max_launch_speed - base_launch_speed))
		launch_indicator.points = [Vector2.ZERO, launch_direction * indicator_length]
		launch_indicator.default_color = Color(1, 1 - current_charge / (max_launch_speed - base_launch_speed), 0)

func _physics_process(delta):
	if launched:
		super._physics_process(delta)
	else:
		update_position()
