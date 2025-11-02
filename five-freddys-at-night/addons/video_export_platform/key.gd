extends Node3D

var isin = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_area_3d_body_entered(body: Node3D) -> void:	
	isin = true	

func _on_area_3d_body_exited(body: Node3D) -> void:
	isin = false	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and isin == true:
		self.visible = false
		sprintvalue.gotkey = true	
		
