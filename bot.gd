class_name Bot
extends Node2D

var map_image: Image
var map_size: Vector2

var velocity:Vector2
var rot_hist:Array[int]
var is_corner:bool=false
var senser_pos= 46

@onready var model = $"../MeshInstance3D"

func _ready() -> void:
	map_image = $"../../../Map2".texture.get_image()
	map_size = map_image.get_size()
	
func _process(delta: float) -> void:
	
	var direction = Vector2.UP.rotated(rotation).normalized()
	var right_direction = Vector2.RIGHT.rotated(rotation)
	
	var right_sensor_pos = position + direction * senser_pos + right_direction * 8
	var left_sensor_pos = position + direction * senser_pos - right_direction * 8
	#
	#$MeshInstance2D.global_position = right_sensor_pos
	#$MeshInstance2D2.global_position = left_sensor_pos
	
	var right_is_dirt = is_dirt(right_sensor_pos)
	var left_is_dirt = is_dirt(left_sensor_pos)
	
	if rot_hist.size() >= 30:
		rot_hist.pop_front()
		
	if left_is_dirt and not right_is_dirt:
		rotation_degrees += 1.5
		rot_hist.append(1)
	elif right_is_dirt and not left_is_dirt:
		rotation_degrees -= 1.5
		rot_hist.append(-1)
	elif not left_is_dirt and not right_is_dirt:
		rot_hist.append(0)
	var sum=0
	for rh in rot_hist:
		sum += rh
	if left_is_dirt and right_is_dirt:

		if sum > 0:
			rotation_degrees += 1.5
			rot_hist.append(1)
		elif sum < 0:
			rotation_degrees += -1.5
			rot_hist.append(-1)
		
		
	if not is_corner and abs(sum) >= 5.0:
		is_corner = true
	
	if is_corner:
		if abs(sum) < 1.0:
			is_corner = false
			velocity += direction * 0.7
		
	
	velocity += direction * 0.015
	position += velocity

	if is_dirt(position):
		velocity *= 0.9
	else:
		velocity *= 0.97


	model.position.x = position.x
	model.position.z = position.y
	model.rotation.y = atan2(direction.x, direction.y)


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
		
	
