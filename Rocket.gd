extends GravitationalBody

var launched = false
var launch_position: Vector2
var earth: GravitationalBody

func _ready():
	mass = 2  # Rocket mass in kg
	radius = 5   # Adjust based on your sprite size

func set_earth(earth_body: GravitationalBody):
	earth = earth_body
	update_position()

func update_position():
	if not launched and earth:
		var direction = (position - earth.position).normalized()
		position = earth.position + direction * (earth.radius + radius)
		rotation = direction.angle() + PI/2

func launch():
	launched = true
	apply_force(Vector2(1750, -750))  # Adjust launch force as needed

func _physics_process(delta):
	if launched:
		super._physics_process(delta)
	else:
		update_position()
