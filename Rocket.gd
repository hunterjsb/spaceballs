extends Sprite2D

var velocity = Vector2.ZERO
var launched = false

func _process(delta):
	if launched:
		# Apply gravity from Earth and Moon
		var earth_gravity = calculate_gravity(get_parent().get_node("Earth"))
		var moon_gravity = calculate_gravity(get_parent().get_node("Moon"))
		
		velocity += (earth_gravity + moon_gravity) * delta
		position += velocity * delta

func launch():
	var earth = get_parent().get_node("Earth")
	position = earth.position + Vector2(0, -earth.texture.get_height() / 2 - 5)  #  pixels above Earth
	launched = true
	velocity = Vector2(750, -750)  # Initial launch velocity

func calculate_gravity(body):
	var direction = body.position - position
	var distance = direction.length()
	var force = 1000 * body.mass / (distance * distance)  # Simplified gravity formula
	return direction.normalized() * force
