class_name Car
extends CharacterBody2D

var model: Node3D

var accel:float=0.0
var power:Vector2=Vector2.ZERO

func _ready() -> void:
	model = $MeshInstance3D
	
	var material = model.get_active_material(0).duplicate()
	var random_color = Color.from_hsv(randf(), 1, 1)
	material.albedo_color = random_color
	model.set_surface_override_material(0, material)
	

#func _input(event: InputEvent) -> void:
	#print(event)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_D):
		rotation_degrees += 1.5
		#accel = lerp(accel, 0.0, 0.01)
	elif Input.is_key_pressed(KEY_A):
		rotation_degrees -= 1.5
		#accel = lerp(accel, 0.0, 0.01)
	
	if not Input.is_key_pressed(KEY_D) and not Input.is_key_pressed(KEY_A):
		accel = lerp(accel, 0.5, 0.03)
		
	
	var current_direction = Vector2.UP.rotated(rotation)
	power = power.lerp(current_direction, 0.03)
	#print(power.length())
	
	position += power * accel
	#power = lerp(power, 0.5, 0.03)
	#var v = Vector2.DOWN
	#v.lerp()
#
		
		#if rotating_cnt > 60:
			#power *= 3
		#rotating_cnt =0
		#
	##var t = clamp(rotating_cnt / 90.0, 0.0, 1.0)
	##var steer_weight = ease(t, -2.0)
	##var turn_speed = lerp(1.0, 2.0, steer_weight)
	#
	#var t = clamp(rotating_cnt / 60.0, 0.0, 1.0)
	#
	#
	##rotation_degrees += turn_speed * rotate
	#if not rotate == 256:
		#rotation_degrees += lerp(1.0, 1.5, t) * rotate
		#
	#position += Vector2.UP.rotated(rotation) * power
	#var fow = Vector2.UP.rotated(rotation)
	#dir = dir.lerp(fow,0.03)
	
	#position += dir * power
	update_model()
func update_model():
	model.position.x = position.x
	model.position.z = position.y
	model.rotation.y = atan2(Vector2.UP.rotated(rotation).x, Vector2.UP.rotated(rotation).y)
