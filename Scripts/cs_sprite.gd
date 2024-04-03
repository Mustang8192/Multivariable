extends Sprite2D
class_name CSSprite

@export var id: int


func _enter_tree():
	get_parent().child_get(self)
