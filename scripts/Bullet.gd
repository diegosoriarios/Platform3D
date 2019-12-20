extends Area

var timer
var speed = 15
var velocity = Vector3()

func _ready():
	timer = Timer.new()
	timer.wait_time = .8
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start()

func start(xform):
	transform = xform
	transform.origin.y += 1.2
	velocity = -transform.basis.z * speed

func _process(delta):
	transform.origin += velocity * delta
	
	var bodies = get_overlapping_bodies()

	for body in bodies:
		print(body)
		if body.name == "Enemy":
			self.queue_free()
			body.hit()
			on_timer_timeout()

func on_timer_timeout():
	get_node("/root/World/Player/").bullet_count = 0
	self.queue_free()

func set_bullet_position(position):
	self.translation = position
	self.translation.x -= 1
	self.translation.y += .5