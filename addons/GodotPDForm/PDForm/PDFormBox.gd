#  ███████████  ██████████   ███████████
# ░░███░░░░░███░░███░░░░███ ░░███░░░░░░█
#  ░███    ░███ ░███   ░░███ ░███   █ ░   ██████  ████████  █████████████   ██
#  ░██████████  ░███    ░███ ░███████    ███░░███░░███░░███░░███░░███░░███ ░░
#  ░███░░░░░░   ░███    ░███ ░███░░░█   ░███ ░███ ░███ ░░░  ░███ ░███ ░███
#  ░███         ░███    ███  ░███  ░    ░███ ░███ ░███      ░███ ░███ ░███
#  █████        ██████████   █████      ░░██████  █████     █████░███ █████ ██
# ░░░░░        ░░░░░░░░░░   ░░░░░        ░░░░░░  ░░░░░     ░░░░░ ░░░ ░░░░░ ░░
#  ███████████
# ░░███░░░░░███
#  ░███    ░███  ██████  █████ █████
#  ░██████████  ███░░███░░███ ░░███
#  ░███░░░░░███░███ ░███ ░░░█████░
#  ░███    ░███░███ ░███  ███░░░███
#  ███████████ ░░██████  █████ █████
# ░░░░░░░░░░░   ░░░░░░  ░░░░░ ░░░░░

@tool
class_name PDFormBox extends ColorRect
## Adds a box (empty, filled, or bordered) to the PDF document.


#                                            ░██
#                                            ░██
# ░█████████████   ░███████  ░█████████████  ░████████   ░███████  ░██░████  ░███████
# ░██   ░██   ░██ ░██    ░██ ░██   ░██   ░██ ░██    ░██ ░██    ░██ ░███     ░██
# ░██   ░██   ░██ ░█████████ ░██   ░██   ░██ ░██    ░██ ░█████████ ░██       ░███████
# ░██   ░██   ░██ ░██        ░██   ░██   ░██ ░███   ░██ ░██        ░██             ░██
# ░██   ░██   ░██  ░███████  ░██   ░██   ░██ ░██░█████   ░███████  ░██       ░███████

const _size : Vector2i = Vector2i(612,792)
var _prev_alpha : float = self.color.a

## Toggles whether a border will be drawn.
@export var draw_border : bool = false :
	set(n):
		draw_border = n
		_update_border()

## Sets the color of the border. NOTE: Exported documents ignore alpha.
@export var border_color : Color = Color(0,0,0,1) :
	set(n):
		border_color = n
		_update_border()

## Sets the thickness of the border.
@export_range(0,4,1,"or_greater") var border_thickness : int = 2 :
	set(n):
		border_thickness = n
		_update_border()

## Determines if the box will be filled.[br]
## Changing this to false will change the alpha value to 0, and to true will reset
## the alpha value to whatever it was before setting it to false. If you wish to
## change the alpha value of the box, do so while this is set to true.
@export var fill_box : bool = true :
	set(n):
		fill_box = n
		if !fill_box:
			_prev_alpha = self.color.a
			self.color.a = 0
		else:
			self.color.a = _prev_alpha

@export_tool_button("Center Horizontally") var c_horiz_tool = _center_h
@export_tool_button("Center Vertically") var c_vert_tool = _center_v


#                               ░██    ░██                          ░██
#                               ░██    ░██                          ░██
# ░█████████████   ░███████  ░████████ ░████████   ░███████   ░████████  ░███████
# ░██   ░██   ░██ ░██    ░██    ░██    ░██    ░██ ░██    ░██ ░██    ░██ ░██
# ░██   ░██   ░██ ░█████████    ░██    ░██    ░██ ░██    ░██ ░██    ░██  ░███████
# ░██   ░██   ░██ ░██           ░██    ░██    ░██ ░██    ░██ ░██   ░███        ░██
# ░██   ░██   ░██  ░███████      ░████ ░██    ░██  ░███████   ░█████░██  ░███████


func _center_h() -> void:
	self.position.x = (_size.x - Vector2i(self.size).x)/2



func _center_v() -> void:
	self.position.y = (_size.y - Vector2i(self.size).y)/2



func _update_border() -> void:
	queue_redraw()


#                                  ░██
#
#  ░███████  ░████████   ░████████ ░██░████████   ░███████
# ░██    ░██ ░██    ░██ ░██    ░██ ░██░██    ░██ ░██    ░██
# ░█████████ ░██    ░██ ░██    ░██ ░██░██    ░██ ░█████████
# ░██        ░██    ░██ ░██   ░███ ░██░██    ░██ ░██
#  ░███████  ░██    ░██  ░█████░██ ░██░██    ░██  ░███████
#                              ░██
#                        ░███████


func _ready() -> void:
	resized.connect(_update_border)
	minimum_size_changed.connect(_update_border)



func _draw() -> void:
	if draw_border:
		var r = Rect2i(Vector2i.ZERO, self.size)
		draw_rect(r, border_color, false, border_thickness, false)



func _get_configuration_warnings() -> PackedStringArray:
	var warnings : PackedStringArray
	if !get_parent() is PDFormPage:
		warnings.append("Must be the child of a PDFormPage node.")
	if get_child_count() != 0:
		warnings.append("No children of this node will be added to this document.")
	return warnings


#                     ░██                         ░██
#                                                 ░██
# ░████████  ░██░████ ░██░██    ░██  ░██████   ░████████  ░███████
# ░██    ░██ ░███     ░██░██    ░██       ░██     ░██    ░██    ░██
# ░██    ░██ ░██      ░██ ░██  ░██   ░███████     ░██    ░█████████
# ░███   ░██ ░██      ░██  ░██░██   ░██   ░██     ░██    ░██
# ░██░█████  ░██      ░██   ░███     ░█████░██     ░████  ░███████
# ░██
# ░██


func _get_page_number() -> int:
	var out = -1
	var p = get_parent()
	if p.has_method("get_page_number"):
		out = p.get_page_number()
	return out



func _get_border_data() -> Dictionary:
	return {
		"show" : draw_border,
		"thickness" : border_thickness,
		"color" : border_color
	}
