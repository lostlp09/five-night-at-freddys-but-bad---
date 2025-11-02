extends Node3D

var isindoor = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("interact") and sprintvalue.gotkey == true and isindoor:
		get_tree().change_scene_to_file("res://win.tscn")
		

func _on_doorenter_body_entered(body: Node3D) -> void:
	isindoor = true


func _on_doorenter_body_exited(body: Node3D) -> void:
	isindoor = false
