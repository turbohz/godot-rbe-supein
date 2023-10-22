extends Node2D

tool

const CUSTOMIZE_PROPERTY_INSPECTOR = {
	angle="AngleEditor"
}

export (float,0,6.28319) var angle:float = 0.0 setget _angle
func _angle(v:float):
	angle = v
	if is_inside_tree():
		$sprite.rotation = (PI/2)+v
