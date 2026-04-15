extends Camera2D
#@onready var target = $"../Player/Player2d"
@onready var target = $"../Bot/A/MeshInstance2D"
func _ready() -> void:
	zoom = Vector2(16,16)
func _physics_process(delta):
	position = target.position
