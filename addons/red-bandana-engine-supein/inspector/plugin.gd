extends EditorInspectorPlugin

signal handling

var customizations:Dictionary

func can_handle(object:Object):
	var customizable = object is Node and "CUSTOMIZE_PROPERTY_INSPECTOR" in object
	if customizable:
		customizations = object.CUSTOMIZE_PROPERTY_INSPECTOR
	return customizable

func parse_property(object,type,path,hint,hint_text,usage):

	if path in customizations.keys(): pass
	else: return

	var Editor
	match customizations[path]:
		"AngleEditor":
			Editor = load("res://addons/red-bandana-engine-supein/inspector/editor/angle.gd")

	if Editor:
		var editor = Editor.new()
		print(self,editor," constructed.")
		add_property_editor(path,editor)
		return true
	else:
		return false
