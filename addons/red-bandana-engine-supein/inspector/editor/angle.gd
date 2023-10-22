extends EditorProperty

const Dial:PackedScene = preload("../scene/dial.tscn")

var dial:Control = Dial.instance()
var field:Control
var value

# A guard against internal changes when the property is updated.
var updating = false

func _init():
	self.read_only = true
	self.name = "AngleEditor"
	var container = VBoxContainer.new()
	add_child(container)
	field = EditorSpinSlider.new()
	field.flat = true
	field.value = 0.0
	field.step = 0.01
	field.min_value = 0
	field.max_value = TAU
	container.add_child(field)
	add_focusable(field)
	container.add_child(dial)
	if "label_reference" in self: # custom build stuff (cosmetical)
		label_reference = field

func _ready():
	dial.connect("value_changed",self,"_on_dial_value_changed")
	field.connect("value_changed",self,"_on_field_value_changed")

func _on_dial_value_changed(v):
	if updating: return
	self.value = TAU-TAU*v
	_update()

func _on_field_value_changed(v):
	if updating:return
	self.value = v
	_update()

func _update(notify:bool=true):
	updating = true
	printt("value->dial",self.value,(TAU-self.value)/TAU)
	dial.set_value((TAU-self.value)/TAU)
	field.set_value(self.value)
	if notify: emit_changed(get_edited_property(),self.value,"",true)
	updating = false

func update_property():
	var new_value = get_edited_object()[get_edited_property()]
	printt(self, "Initialising ... ",new_value,self.value)
	if new_value == self.value:	return
	self.value = new_value
	_update(false)
