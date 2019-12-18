extends Spatial

onready var model = $MeshInstance
onready var area = $Area

func _process(delta):
	model.rotate_y(deg2rad(1))

	var bodies = area.get_overlapping_bodies()

	for body in bodies:
		print(body.name)
		if body.name == "Player":
			self.queue_free()