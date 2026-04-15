class_name Player

extends Node2D

var velocity: Vector2 = Vector2.ZERO


@onready var model: Node3D = $"../Player"

var turn_cnt = 0
func _ready():
	position.x = model.position.x
	position.y = model.position.z
	

func _process(delta):
	var turn = false
	if Input.is_key_pressed(KEY_A):
		rotation_degrees += -1.5
		turn = true
	if Input.is_key_pressed(KEY_D):
		rotation_degrees += 1.5
		turn = true

	var forward = Vector2.UP.rotated(rotation)

	if turn:
		turn_cnt += 1
	else:
		if turn_cnt > 60:
			velocity += forward * 0.7
		turn_cnt = 0
	
	
	velocity += forward * 0.015
	#print(velocity.length())
	position += velocity
	
	velocity *= 0.97
	

	model.position.x = position.x
	model.position.z = position.y
	model.rotation.y = atan2(forward.x, forward.y)
