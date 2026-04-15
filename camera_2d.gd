extends Camera2D
@onready var target = $"../Player/Player2d"
func _ready() -> void:
	zoom = Vector2(16,16)
func _physics_process(delta):
	position = target.position
