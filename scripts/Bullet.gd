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

func on_timer_timeout():
	self.queue_free()
	get_node("/root/World/Player/").bullet_count = 0

func get_bullet_position():
	self.translation

func set_bullet_position(position):
	self.translation = position
	self.translation.x -= 1
	self.translation.y += .5