# PlutoSVG API Documentation

PlutoSVG is a lightweight C library for loading and rendering SVG documents. It provides a simple API for parsing SVG files and rendering them to surfaces or canvases.

## Version Information

**Current Version:** 0.0.7

## Overview

PlutoSVG is built on top of PlutoVG and provides functionality to:
- Load SVG documents from files or memory buffers
- Render SVG documents or specific elements
- Handle CSS color variables and current color resolution
- Integrate with FreeType for SVG font rendering
- Calculate document dimensions and element extents

## Core Types

### `plutosvg_document_t`
An opaque handle representing an SVG document. This structure contains the parsed SVG data and associated metadata.

### `plutosvg_palette_func_t`
```c
Prototype.i plutosvg_palette_func_t(*closure, *name, length.i, *color.plutovg_color)
```
Callback function type for resolving CSS color variables in SVG documents.

**Parameters:**
- `closure`: User-defined data passed to the callback
- `name`: Name of the color variable to resolve
- `length`: Length of the color variable name
- `color`: Output parameter where the resolved color should be stored

**Returns:** `true` if the color variable was successfully resolved, `false` otherwise

## API Functions

### Version Functions

#### `plutosvg_version()`
```c
plutosvg_version.i()
```
Returns the version number of PlutoSVG as an integer.

**Returns:** Version number encoded as an integer

#### `plutosvg_version_string()`
```c
PeekS(plutosvg_version_string(),-1,#PB_UTF8) 
```
Returns the version string of PlutoSVG.

**Returns:** Null-terminated version string (e.g., "0.0.7")

### Document Loading

#### `plutosvg_document_load_from_data()`
```c
plutosvg_document_load_from_data(*data, length.i, width.f, height.f, destroy_func.plutovg_destroy_func_t, *closure)
```
Loads an SVG document from a memory buffer.

**Parameters:**
- `*data`: Pointer to the SVG data buffer (must remain valid until document is destroyed)
- `length`: Length of the data buffer in bytes
- `width`: Container width for resolving intrinsic width, or `-1` if unspecified
- `height`: Container height for resolving intrinsic height, or `-1` if unspecified
- `destroy_func`: Optional custom cleanup function called when document is destroyed
- `closure`: User-defined data passed to the destroy function

**Returns:** Pointer to the loaded document, or `NULL` on failure

**Important:** The data buffer must remain valid for the lifetime of the document.

#### `plutosvg_document_load_from_file()`
```c
 plutosvg_document_load_from_file(filename.p-utf8, width.f=-1, height.f=-1)
```
Loads an SVG document from a file.

**Parameters:**
- `filename`: Path to the SVG file
- `width`: Container width for resolving intrinsic width, or `-1` if unspecified
- `height`: Container height for resolving intrinsic height, or `-1` if unspecified

**Returns:** Pointer to the loaded document, or `NULL` on failure

### Document Rendering

#### `plutosvg_document_render()`
```c
plutosvg_document_render.i(*document, id, canvas, *current_color.plutovg_color, palette_func.plutosvg_palette_func_t, *closure)
```
Renders an SVG document or specific element onto an existing canvas.

**Parameters:**
- `document`: Pointer to the SVG document
- `id`: ID of the specific element to render, or `NULL` to render the entire document
- `canvas`: Target canvas for rendering
- `current_color`: Color used to resolve CSS `currentColor` values
- `palette_func`: Optional callback for resolving CSS color variables
- `closure`: User-defined data passed to the palette function

**Returns:** `true` if rendering was successful, `false` otherwise

#### `plutosvg_document_render_to_surface()`
```c
plutosvg_document_render_to_surface.i(document, id, width.i, height.i, *current_color.plutovg_color, palette_func.plutosvg_palette_func_t, *closure)
```
Renders an SVG document or specific element to a new surface.

**Parameters:**
- `document`: Pointer to the SVG document
- `id`: ID of the specific element to render, or `NULL` to render the entire document
- `width`: Expected width of the surface, or `-1` if unspecified
- `height`: Expected height of the surface, or `-1` if unspecified
- `current_color`: Color used to resolve CSS `currentColor` values
- `palette_func`: Optional callback for resolving CSS color variables
- `closure`: User-defined data passed to the palette function

**Returns:** Pointer to the rendered surface, or `NULL` on failure

### Document Properties

#### `plutosvg_document_get_width()`
```c
plutosvg_document_get_width.f(*document)
```
Returns the intrinsic width of the SVG document.

**Parameters:**
- `document`: Pointer to the SVG document

**Returns:** The intrinsic width in units specified by the SVG

#### `plutosvg_document_get_height()`
```c
plutosvg_document_get_height.f(*document)
```
Returns the intrinsic height of the SVG document.

**Parameters:**
- `document`: Pointer to the SVG document

**Returns:** The intrinsic height in units specified by the SVG

#### `plutosvg_document_extents()`
```c
plutosvg_document_extents.i(*document, *id, *extents.plutovg_rect)
```
Calculates the bounding box of a specific element or the entire document.

**Parameters:**
- `document`: Pointer to the SVG document
- `id`: ID of the element whose extents to retrieve, or `NULL` for the entire document
- `extents`: Output parameter where the bounding box will be stored

**Returns:** `true` if extents were successfully calculated, `false` otherwise

### Memory Management

#### `plutosvg_document_destroy()`
```c
plutosvg_document_destroy(*document)
```
Destroys an SVG document and frees its resources.

**Parameters:**
- `document`: Pointer to the document to destroy (safe to pass `NULL`)

### FreeType Integration

#### `plutosvg_ft_svg_hooks()`
```c
plutosvg_ft_svg_hooks.i()
```
Retrieves PlutoSVG hooks for integrating with FreeType's SVG module.


## License

PlutoSVG is released under the MIT License. See the license header in the source files for full details.