#  ███████████  ██████████   ███████████
# ░░███░░░░░███░░███░░░░███ ░░███░░░░░░█
#  ░███    ░███ ░███   ░░███ ░███   █ ░   ██████  ████████  █████████████   ██
#  ░██████████  ░███    ░███ ░███████    ███░░███░░███░░███░░███░░███░░███ ░░
#  ░███░░░░░░   ░███    ░███ ░███░░░█   ░███ ░███ ░███ ░░░  ░███ ░███ ░███
#  ░███         ░███    ███  ░███  ░    ░███ ░███ ░███      ░███ ░███ ░███
#  █████        ██████████   █████      ░░██████  █████     █████░███ █████ ██
# ░░░░░        ░░░░░░░░░░   ░░░░░        ░░░░░░  ░░░░░     ░░░░░ ░░░ ░░░░░ ░░
#  █████
# ░░███
#  ░███  █████████████    ██████    ███████  ██████
#  ░███ ░░███░░███░░███  ░░░░░███  ███░░███ ███░░███
#  ░███  ░███ ░███ ░███   ███████ ░███ ░███░███████
#  ░███  ░███ ░███ ░███  ███░░███ ░███ ░███░███░░░
#  █████ █████░███ █████░░████████░░███████░░██████
# ░░░░░ ░░░░░ ░░░ ░░░░░  ░░░░░░░░  ░░░░░███ ░░░░░░
#                                  ███ ░███
#                                 ░░██████
#                                  ░░░░░░

@tool
class_name PDFormImage extends TextureRect
## Adds an image to the PDF document. Must be the child of a [PDFormPage].


func _get_configuration_warnings() -> PackedStringArray:
	var warnings : PackedStringArray
	if !get_parent() is PDFormPage:
		warnings.append("Must be the child of a PDFormPage node.")
	if get_child_count() != 0:
		warnings.append("No children of this node will be added to this document.")
	return warnings
