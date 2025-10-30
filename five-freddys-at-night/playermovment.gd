extends CharacterBody3D
var maxrotationup = 0.8
var maxrotationdown = -1.5
var sense = 0.005
var pitch = 0
var jump
@onready var camera = $Camera3D
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event: InputEvent) -> void:
	print("hi")
	if event is InputEventMouseMotion:
		pitch -= event.relative.y * sense
		
		pitch = clamp(pitch,maxrotationdown,maxrotationup)
		
		self.rotation.y   += event.relative.x  * sense * -1
		camera.rotation.x = pitch
		print(pitch)
		

func _physics_process(delta: float) -> void:
	var rotation1 = self.rotation
	
	var movment1 = Vector3(0,self.velocity.y,0)
	self.velocity.z = 0
	self.velocity.x = 0
	movment1.y -= 0.8
	
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
		
	
	self.velocity = movment1.rotated(Vector3.UP,rotation1.y)
	move_and_slide()
	
	
	
	
	
	
	
