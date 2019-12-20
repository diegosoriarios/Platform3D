extends KinematicBody

var timer
export var time = 5
export var direction = 1
var MOVE_SPEED = 5
onready var player = get_node("/root/World/Player")
onready var area = $Area

func _ready():
	timer = Timer.new()
	timer.wait_time = time
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start()
	
func on_timer_timeout():
	timer.wait_time = time
	direction *= -1

func _physics_process(delta):
	var move_vec = Vector3()
	move_vec.y += 1 * direction

	move_vec = move_vec.normalized()
	move_vec *= MOVE_SPEED
	move_and_slide(move_vec, Vector3(0, 1, 0))
	
	print(move_vec)

func _process(delta):
	var bodies = area.get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			body.y_velo -= -(.98 * MOVE_SPEED) - 12