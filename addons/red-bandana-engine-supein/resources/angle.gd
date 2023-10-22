class_name AngleResource
extends Resource

enum { CUSTOM_RESOURCE }

# tool

export (int,0,360) var value:int = 0

func _init(v:int):
	value = v

static func ZERO():
	return new(0)
