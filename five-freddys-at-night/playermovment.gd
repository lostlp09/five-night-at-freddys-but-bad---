extends CharacterBody3D
var maxrotationup = 0.8
var maxrotationdown = -1.5
var sense = 0.005
var pitch = 0
signal  sprintcooldown
var jump
var sprint  = 0
var isrecharging = false
@onready var flashlight =$Camera3D/SpotLight3D
@onready var camera = $Camera3D
func _ready() -> void:
	sprintvalue.sprintvalue = 100
	sprintcooldown.connect(oncooldown)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pitch -= event.relative.y * sense
		
		pitch = clamp(pitch,maxrotationdown,maxrotationup)
		
		self.rotation.y   += event.relative.x  * sense * -1
		camera.rotation.x = pitch
	
		

func _physics_process(delta: float) -> void:

	var rotation1 = self.rotation
	
	var movment1 = Vector3(0,self.velocity.y,0)
	self.velocity.z = 0
	self.velocity.x = 0
	movment1.y -= 0.8
	if Input.is_action_just_pressed("flashlight"):
		if flashlight.visible == true:
			flashlight.visible = false
		else:
			flashlight.visible = true

	if Input.is_action_pressed("forward"):
		movment1 += Vector3(0,0,400) * delta
	if Input.is_action_pressed("backward"):
		movment1 += Vector3(0,0,-400)* delta
	if Input.is_action_pressed("left"):
		movment1 += Vector3(400,0,0)* delta
	if Input.is_action_pressed("right"):
		movment1 += Vector3(-400,0,0)* delta
	if Input.is_action_just_pressed("jump")and is_on_floor():
		movment1.y = 16

	if Input.is_action_pressed("sprint"):
		if sprintvalue.sprintvalue - 1 >= 0:
			
			sprint += delta
			movment1.x *= 2.5
			movment1.z *= 2.5
			if sprint >= 0.05:
				sprintvalue.sprintvalue -=1
				sprint = 0
		if isrecharging == false and sprintvalue.sprintvalue <= 0:
			print("rennen")
			isrecharging = true
			sprintcooldown.emit()
	else:
		if isrecharging == false and sprintvalue.sprintvalue < 100:
			sprintcooldown.emit()
			isrecharging = true
			
		sprint = 0
	self.velocity = movment1.rotated(Vector3.UP,rotation1.y)
	move_and_slide()
	
	
func oncooldown():
	while sprintvalue.sprintvalue < 100:
		if not Input.is_action_pressed("sprint"):
			sprintvalue.sprintvalue +=1
		
		else:
			break
			isrecharging = false

		await get_tree().create_timer(0.1).timeout
	isrecharging = false




func _on_area_3d_area_entered(area: Area3D) -> void:
	if area == $"../../../../Freddy/kill":
		
		get_tree().change_scene_to_file("res://death.tscn")
	else:
		print("cap")
