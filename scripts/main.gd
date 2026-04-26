extends Node

var player: Car

func _ready() -> void:
	Engine.max_fps = 60
	player = $Car
	
	$Track/MeshInstance3D.position.y = -1
	$Track/MeshInstance3D.rotation_degrees.y = 180

	
func _process(delta: float) -> void:
	pass
	#if Input.is_key_pressed(KEY_D):
		#if player.rotate == -3:
			#player.rotate = -1
		#else:
			#player.rotate = 3
		#
	#if Input.is_key_pressed(KEY_A):
		#if player.rotate == 3:
			#player.rotate = 1
		#else:
			#player.rotate = -3
#
	#if not Input.is_key_pressed(KEY_A) and  not Input.is_key_pressed(KEY_D):
		#player.rotate = 0
