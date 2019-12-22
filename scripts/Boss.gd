extends KinematicBody

onready var player = get_node("/root/World/Player")
onready var area = $Area
var attack_player = false

onready var raycast = $RayCast
onready var raycast2 = $RayCast2
onready var raycast3 = $RayCast3
onready var raycast4 = $RayCast4
onready var ray1 = $Ray1
onready var ray2 = $Ray2
onready var ray3 = $Ray3
onready var ray4 = $Ray4
var timer
var timerAttack
var allow_attack = true

func _ready():
	ray1.visible = false
	ray2.visible = false
	ray3.visible = false
	ray4.visible = false

func _process(delta):
	var player_pos = player.global_transform.origin
	if attack_player:
		ray1.visible = true
		ray2.visible = true
		ray3.visible = true
		ray4.visible = true
		look_at(player_pos, Vector3(0, 1, 0))
		
		timerAttack = Timer.new()
		timerAttack.wait_time = .1
		timerAttack.connect("timeout", self, "on_timer_attack__timeout")
		add_child(timerAttack)
		timerAttack.start()
		
		timer = Timer.new()
		timer.wait_time = 1
		timer.connect("timeout", self, "on_timer_timeout")
		add_child(timer)
		timer.start()
	
	var collider1 = raycast.get_collider()
	var collider2 = raycast2.get_collider()
	var collider3 = raycast3.get_collider()
	var collider4 = raycast4.get_collider()
	
	var raycast_collision = raycast.is_colliding() or raycast2.is_colliding() or raycast3.is_colliding() or raycast4.is_colliding()
	
	if attack_player and raycast_collision and allow_attack:
		if collider1.is_in_group("Player") or collider2.is_in_group("Player") or collider3.is_in_group("Player") or collider4.is_in_group("Player"):
			player.hit()
	
	var bodies = area.get_overlapping_bodies()
	
	if allow_attack:
		for body in bodies:
			if body.name == "Player":
				attack_player = true
				return
			else:
				attack_player = false

func on_timer_timeout():
	allow_attack = true

func on_timer_attack():
	ray1.visible = false
	ray2.visible = false
	ray3.visible = false
	ray4.visible = false
	timerAttack.wait_time = 1