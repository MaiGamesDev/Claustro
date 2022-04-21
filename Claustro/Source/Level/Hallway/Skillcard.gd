extends VBoxContainer


# Called when the node enters the scene tree for the first time.

func _on_mouse_entered():
	print("asdfr")
	var value = 30
	var space = get_node("Space")
	var tween = get_node("Tween")
	tween.interpolate_property(space, "rect_min_size:y", space.rect_min_size.y, value, 1.0, tween.TRANS_QUINT, tween.EASE_OUT)
	tween.start()
