extends Camera3D

func _ready():
	set_as_top_level(true)

func _physics_process(_delta):
	var target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	look_at_from_position(pos, target, Vector3.UP)
