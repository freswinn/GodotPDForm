# Introduction
GodotPDForm is a fork of GodotPDF, which can be found here: https://github.com/nng2/GodotPDF

In this fork, I have modified the code somewhat, mostly adding documentation and typecasts, but also adding new classes of nodes to the Godot editor. With these classes, you are now able to build a scene that acts as a form for your PDF document, which you can then directly call to export as a PDF.

# PDForm Nodes
All PDForm nodes can be found in the node list when adding a new node by typing PDForm.

![Screenshot of Godot showing a sample PDForm scene and its scene tree](/img/NodeTree.png)

## PDFormBase
The base of these nodes is PDFormBase. It is not at all necessary to create a scene where the root node is a PDFormBase, but it is recommended.
In the PDFormBase, you set your document's title and author, select which page is currently visible, and list the file paths of any and all fonts you want to import into the document when exporting.
PDFormBase should only have PDFormPage nodes as its immediate children, and it requires at least one.

## PDFormPage
The child of PDFormBase. Each PDFormPage is a new page that will be added to your document. The size of the page cannot be changed, as it outlines the size of the page in the exported document.
Changing the color of the page does not change the color of the page in the exported document. You will have to do that yourself with a PDFormBox.
PDFormPage's children should be PDFormBox, PDFormImage, and PDFormLabel.

## PDFormBox
A child of PDFormPage. Creates a box in the document. You can add a border or even choose not to fill the box. Provides a couple of tool buttons in the inspector to center the box in the document.

## PDFormImage
A child of PDFormPage. Creates an image in the document. Set the texture and size, and it will export accordingly.

## PDFormLabel
A child of PDFormPage. Creates text in the document. There are a number of limitations on this.
The text will ignore whatever formatting you throw at it, including font color, line breaks, and alignment. It will always render as a single line of text, and will ignore the size of the label node. This is a limitation from GodotPDF.
You can, however, change the font face and the size of the font. Changing the font size should be done via the provided font_size exported variable found in the inspector.
To change the font face, you must provide the name of the font as provided in PDFormBase. This does not change how the font appears in the editor, however! To do that, you will have to import the font into Godot and then set it via Theme Override/Font.

# Exporting the PDF
Once you have your scene saved, you merely need to call the build_export(filepath) function from the PDFormBase node!
