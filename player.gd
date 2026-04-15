class_name Player

extends Node2D

var velocity: Vector2 = Vector2.ZERO
var map_image: Image
var map_size: Vector2


@onready var model: Node3D = $"../Player"

var turn_cnt = 0
func _ready():
	position.x = model.position.x
	position.y = model.position.z
	
	map_image = $"../../Map2".texture.get_image()
	map_size = map_image.get_size()

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
	
	if is_dirt(position):
		velocity *= 0.9
	else:
		velocity *= 0.97
	

	model.position.x = position.x
	model.position.z = position.y
	model.rotation.y = atan2(forward.x, forward.y)

func is_dirt(pos: Vector2) -> bool:
	var p = pos + map_size/2.0
	
	# マップ範囲外のチェック
	var rect = Rect2(Vector2.ZERO, map_size)
	if not rect.has_point(p):
		return true
	
	var pixel_color: Color = map_image.get_pixel(p.x, p.y)
	if pixel_color.a == 1:
		return false
	return true
		
