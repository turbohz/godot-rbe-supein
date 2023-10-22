extends EditorPlugin

tool

const InspectorPlugin = preload("inspector/plugin.gd")

var inspector:InspectorPlugin
var editor_selection
signal selection_changed

func _init():
	name = "RBE!Supein"

func _enter_tree():

	editor_selection = get_editor_interface().get_selection()
	editor_selection.connect("selection_changed", self, "_on_EditorSelection_selection_changed")

	inspector = InspectorPlugin.new()
	add_inspector_plugin(inspector)

func _exit_tree():
	remove_inspector_plugin(inspector)

func _on_EditorSelection_selection_changed():
	editor_selection = get_editor_interface().get_selection()
	emit_signal("selection_changed",editor_selection)
