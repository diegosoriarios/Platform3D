extends KinematicBody

onready var player = get_node("/root/World/Player")
var move_speed = 1
onready var area = $Area
var follow_player = false
var health = 3
var timer

func _ready():
	pass

func _process(delta):
	var bodies = area.get_overlapping_bodies()
	var player_pos = player.global_transform.origin
	look_at(player_pos, Vector3(0, 1, 0))
	
	for body in bodies:
		if body.name == "Player":
			follow_player = true
			return
		else:
			follow_player = false

func _physics_process(delta):
	if follow_player:
		var player_origin = player.get_global_transform().origin
		var enemy_origin = self.get_global_transform().origin
		var offset = player_origin - enemy_origin
		move_and_collide(offset.normalized() * move_speed * delta)

func hit():
	health -= 1
	if health == 0:
		self.queue_free()