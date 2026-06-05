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
#  ░███    ░███  ██████    █████   ██████
#  ░██████████  ░░░░░███  ███░░   ███░░███
#  ░███░░░░░███  ███████ ░░█████ ░███████
#  ░███    ░███ ███░░███  ░░░░███░███░░░
#  ███████████ ░░████████ ██████ ░░██████
# ░░░░░░░░░░░   ░░░░░░░░ ░░░░░░   ░░░░░░

@tool
class_name PDFormBase extends Control
## Base for the [b]PDForm[/b]s. Requires at least one [PDFormPage] as a child, and only takes
## [PDFormPage] nodes as its immediate children.
##
## This is the framework that is required for all [b]PDForm[/b]s. It keeps and sorts the pages
## of the document. You should not have [PDFormBase] as the child of any other [b]PDForm[/b]
## node.[br]
## With the first [PDFormPage] added, this is the equivalent of [method PDF.newPDF].


#                                            ░██
#                                            ░██
# ░█████████████   ░███████  ░█████████████  ░████████   ░███████  ░██░████  ░███████
# ░██   ░██   ░██ ░██    ░██ ░██   ░██   ░██ ░██    ░██ ░██    ░██ ░███     ░██
# ░██   ░██   ░██ ░█████████ ░██   ░██   ░██ ░██    ░██ ░█████████ ░██       ░███████
# ░██   ░██   ░██ ░██        ░██   ░██   ░██ ░███   ░██ ░██        ░██             ░██
# ░██   ░██   ░██  ░███████  ░██   ░██   ░██ ░██░█████   ░███████  ░██       ░███████


const _size : Vector2i = Vector2i(612,792) # Size of the document.
# Until I find a way to change the size of the document in PDF.gd, these will remain
# set forcefully to one size.

@export var doc_title : String = "New PDForm"
@export var doc_creator : String = "Godette"

## Changes which page in the document is currently being shown. This does not affect the
## document; only the way it is being displayed in Godot.
@export var current_page : int = 0 :
	set(n):
		current_page = clampi(n,0,get_child_count()-1)
		_change_visible_page()

## Paths to the fonts that should be imported to the document. Provided fonts must be
## in the format of:
	## [codeblock]{ "font name" : String, "font path" : String }[/codeblock]
## Provided paths must be [b]absolute[/b], not relative.
@export var fonts_to_embed : Array[Dictionary] = []


#                     ░██                         ░██
#                                                 ░██
# ░████████  ░██░████ ░██░██    ░██  ░██████   ░████████  ░███████
# ░██    ░██ ░███     ░██░██    ░██       ░██     ░██    ░██    ░██
# ░██    ░██ ░██      ░██ ░██  ░██   ░███████     ░██    ░█████████
# ░███   ░██ ░██      ░██  ░██░██   ░██   ░██     ░██    ░██
# ░██░█████  ░██      ░██   ░███     ░█████░██     ░████  ░███████
# ░██
# ░██


func _resize_default() -> void:
	self.custom_minimum_size = _size
	self.set_size(_size)



func _change_visible_page() -> void:
	var children = get_children()
	for c in children: # make sure all children are PDFormPage
		if _get_any_class(c) != "PDFormPage":
			return
		c.visible = false
	children[current_page].visible = true



static func _get_any_class(node : Node) -> String:
	var out : String = ""
	var a = node.get_script()
	if !a == null:
		out = a.get_global_name()
	if a == null or out == "":
		out = node.get_class()
	return out


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
	_resize_default()
	resized.connect(_resize_default)
	minimum_size_changed.connect(_resize_default)
	build_export("")



func _get_configuration_warnings() -> PackedStringArray:
	var warnings : PackedStringArray
	var children = get_children()
	if children.size() == 0:
		warnings.append("Requires at least one PDFormPage node as a child.")
	else:
		for c in children:
			if !c is PDFormPage:
				warnings.append("Immediate children of this node must all be PDFormPage nodes.")
				break
	return warnings


#                               ░██    ░██                          ░██
#                               ░██    ░██                          ░██
# ░█████████████   ░███████  ░████████ ░████████   ░███████   ░████████  ░███████
# ░██   ░██   ░██ ░██    ░██    ░██    ░██    ░██ ░██    ░██ ░██    ░██ ░██
# ░██   ░██   ░██ ░█████████    ░██    ░██    ░██ ░██    ░██ ░██    ░██  ░███████
# ░██   ░██   ░██ ░██           ░██    ░██    ░██ ░██    ░██ ░██   ░███        ░██
# ░██   ░██   ░██  ░███████      ░████ ░██    ░██  ░███████   ░█████░██  ░███████


## Exports the [PDFormBase] and its children as a PDF via [method PDF.export].
## [param export_path] is an absolute path, and must include the filename and .pdf
## extension.[br]
## Set [param verbose] to false to see each the success or failure of each element.
func build_export(export_path : String, verbose : bool = false) -> void:
	if Engine.is_editor_hint():
		return

	# Get the pages
	var pages := get_children()
	pages.filter(func(a : Node) -> bool:
		if _get_any_class(a) == "PDFormPage":
			return true
		return false )

	# Get the contents of the pages
	var tree : Array[Dictionary]
	for i in pages.size():
		tree.append( {"page" : pages[i], "page number" : i+1} )
		var contents = pages[i].get_children()
		contents.filter(func(a : Node) -> bool:
			var acceptable = ["PDFormImage", "PDFormLabel", "PDFormBox"]
			if _get_any_class(a) in acceptable:
				return true
			return false )
		tree[i]["contents"] = contents

	# tree format:
		# {
			# "page" : PDFormPage node,
			# "page number" : int (starting at 1),
			# "contents" : [array of the children of PDFormPage]
		# }

	# Create the PDF, and set the title and creator; adds the first page automatically.
	var pdf_create_success = PDF.newPDF( doc_title, doc_creator )
	if verbose: printt("Creating PDF with page 1:", pages[0].name, pdf_create_success)

	# Add all other pages
	for i in pages.size()-1:
		var element_success = PDF.newPage()
		if verbose: printt("Adding page:", pages[i+1].name, element_success)

	# Embed fonts
	for f in fonts_to_embed:
		var element_success = PDF.newFont( f["font name"], f["font path"] )
		if verbose: printt("Importing font:", f["font name"], element_success)

	for i in pages.size():
		var page : int = i+1
		for c in tree[i]["contents"]:
			match _get_any_class(c):

				"PDFormLabel":
					var pos : Vector2i = c.position
					var text : String = c.text
					var textsize : int = c.font_size
					var textfont : String = c.font_face
					var element_success = PDF.newLabel(page, pos, text, textsize, textfont)
					if verbose: printt("Creating label:", c.name, element_success)

				"PDFormBox":
					var pos : Vector2i = c.position as Vector2i
					var boxsize : Vector2i = c.size as Vector2i
					var fillcolor = c.color
					if !c.fill_box:
						fillcolor = null
					var borderweight : int = c.border_thickness
					var bordercolor = c.border_color
					if !c.draw_border:
						bordercolor = null
					var element_success = PDF.newBox(page, pos, boxsize, fillcolor, bordercolor, borderweight)
					if verbose: printt("Creating box:", c.name, element_success)

				"PDFormImage":
					var pos : Vector2i = c.position as Vector2i
					var img : Image = c.texture.get_image()
					var imgsize : Vector2i = c.size as Vector2i
					var element_success = PDF.newImage(page, pos, img, imgsize)
					if verbose: printt("Creating image:", c.name, element_success)

	var export_success = PDF.export(export_path)
	if verbose: printt("Successful export:", export_success)
