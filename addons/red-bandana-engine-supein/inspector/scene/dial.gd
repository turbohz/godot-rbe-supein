extends Panel

tool

# ratio of unusable radius
# (mouse won't register in this inner circle)
var dead_zone:float = 0.4

var rect:Rect2 setget ,_rect
func _rect()->Rect2:
	return Rect2(rect_global_position,rect_size)

var pressing:bool = false setget _pressing
func _pressing(pressed:bool):

	# just pressed
	if not pressing and pressed:
		_ratio = ratio

	# just released
	elif pressing and not pressed:
		self.ratio = ratio()
		update()

	pressing = pressed

var _ratio:float = NAN
export (float,0,1) var ratio:float setget _set_ratio
func _set_ratio(r):
	ratio = wrapf(r,0.0,1.0)
	update()
	if is_inside_tree():
		owner.call("emit_signal","value_changed",ratio)

var radius:float setget ,_radius
func _radius()->float: return min(rect_size.x,rect_size.y)/2

func angle(ratio:float=NAN)->float:
	if is_nan(ratio): ratio = self.ratio
	return TAU-TAU*ratio

func ratio(point:Vector2=Vector2.INF)->float:
	if point == Vector2.INF: point = get_local_mouse_position()
	var center = rect_size / 2.0
	var relative_point= point-center

	# check if its too close to the center, and we should ignore it
	if relative_point.length() < self.radius*dead_zone:
		return self.ratio

	var direction = relative_point*Vector2(1,-1).normalized()
	var angle = direction.angle()
	return angle/TAU

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		self.pressing = event.pressed
		return
	elif event is InputEventMouseMotion and pressing:
		self.ratio = ratio()
		update()

func _draw():
	var center:Vector2 = rect_size / 2.0

	if pressing:
		var _point:Vector2 = center + self.radius*Vector2.RIGHT.rotated(angle(_ratio))
		draw_line(center,_point,Color.white,1.0,true)

	var point:Vector2 = center + self.radius*Vector2.RIGHT.rotated(angle())
	draw_line(center,point,Color.red,3.0,true)
