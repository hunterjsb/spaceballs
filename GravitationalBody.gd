# GravitationalBody.gd
extends Area2D

class_name GravitationalBody

@export var mass: float = 1.0
@export var radius: float = 10.0  # For collision detection
var velocity: Vector2 = Vector2.ZERO

func apply_force(force: Vector2):
	velocity += force / mass

func move(delta: float):
	position += velocity * delta

func gravitational_force(other: GravitationalBody) -> Vector2:
	var direction = other.position - position
	var distance = direction.length()
	var force_magnitude = (mass * other.mass) / (distance * distance)
	return direction.normalized() * force_magnitude

func _physics_process(delta):
	move(delta)
