extends Node

var charas:Array[Node2D]

func _ready() -> void:
	Engine.max_fps = 60

	charas.append($Player/Player2d)
	for c in $Bot.get_children():
		charas.append(c.get_child(0))
	
func _process(delta: float) -> void:
	for a in charas:
		for b in charas:
			if a == b:
				continue
			var diff = a.position - b.position
			
			if diff.length_squared() < 9:
				if a is Player or a is Bot:
					a.velocity += diff.normalized()*0.01
				if b is Player or b is Bot:
					b.velocity -= diff.normalized()*0.01
				
