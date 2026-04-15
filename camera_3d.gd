extends Camera3D

var offset: Vector3
@onready var target = $"../Player/Player"

func _ready() -> void:
	offset = position

func _physics_process(delta):
	var target_pos = target.global_transform.origin + target.global_transform.basis * offset
	global_transform.origin = global_transform.origin.lerp(target_pos, 0.08)
	look_at(target.global_transform.origin + Vector3(0, 0, 0)) # 1m上（頭付近）を見る
