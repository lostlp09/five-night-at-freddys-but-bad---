extends CharacterBody3D

@export var movement_speed: float = 5
@onready var navigation_agent: NavigationAgent3D =$NavigationAgent3D
@onready var player = $"../SubViewportContainer/SubViewport/Node3D/player"

func _ready() -> void:
	loop()
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	set_movement_target(player.position)
func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
func _physics_process(delta):

	
	var target = player.position
	target.y = self.position.y   # Höhe gleich setzen = nur horizontale Richtung
	self.look_at(target,Vector3.UP)
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer3D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	
 
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	self.velocity = safe_velocity
	if self.position.distance_to(player.position) <= 100:
		self.velocity *= 2
		
	move_and_slide()
	
func loop():
	while true == true:
		set_movement_target(player.position)
		await get_tree().create_timer(1).timeout

func near():
	
	self.velocity *=2 



	
		
