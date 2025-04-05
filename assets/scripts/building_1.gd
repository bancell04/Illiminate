extends Node2D

@onready var roof = $layer_5
@onready var walls = [$layer_1, $layer_2, $layer_3, $layer_4]
@onready var overlay = get_tree().get_root().get_node("Game/Player/Camera2D/Overlay")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		roof.visible = false
		overlay.visible = true;
		for i in range(len(walls)):
			if i == 0:
				walls[i].modulate.a = 0.4
			else:
				walls[i].visible = false
				walls[i].collision_enabled = false

			



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		overlay.visible = false;
		roof.visible = true
		for layer in walls:
			layer.modulate.a = 1
			layer.visible = true 
			layer.collision_enabled = true 
		
