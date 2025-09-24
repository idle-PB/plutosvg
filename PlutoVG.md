# PlutoVG API Documentation

PlutoVG is a 2D vector graphics library for rendering and image manipulation. This documentation covers all available functions and data structures.

## Table of Contents

- [Version Information](#version-information)
- [Data Structures](#data-structures)
- [Matrix Operations](#matrix-operations)
- [Path Operations](#path-operations)
- [Text Processing](#text-processing)
- [Font Management](#font-management)
- [Color Management](#color-management)
- [Surface Operations](#surface-operations)
- [Paint Objects](#paint-objects)
- [Canvas Operations](#canvas-operations)

---

## Version Information

### `plutovg_version()`
**Returns:** Integer representing the library version

Gets the version of the plutovg library as an encoded integer.

### `plutovg_version_string()`
**Returns:** String containing the version

Gets the version of the plutovg library as a human-readable string.

---

## Data Structures

### plutovg_point
Represents a point in 2D space.
- `x` - X coordinate (float)
- `y` - Y coordinate (float)

### plutovg_rect
Represents a rectangle in 2D space.
- `x` - X coordinate of top-left corner (float)
- `y` - Y coordinate of top-left corner (float)
- `w` - Width (float)
- `h` - Height (float)

### plutovg_matrix
Represents a 2D transformation matrix.
- `a` - Horizontal scaling factor (float)
- `b` - Vertical shearing factor (float)
- `c` - Horizontal shearing factor (float)
- `d` - Vertical scaling factor (float)
- `e` - Horizontal translation offset (float)
- `f` - Vertical translation offset (float)

### plutovg_color
Represents an RGBA color.
- `r` - Red component (0.0-1.0)
- `g` - Green component (0.0-1.0)
- `b` - Blue component (0.0-1.0)
- `a` - Alpha component (0.0-1.0)

---

## Matrix Operations

### `plutovg_matrix_init(matrix, a, b, c, d, e, f)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `a, b, c, d, e, f` - Matrix components (float)

Initializes a 2D transformation matrix with specified values.

### `plutovg_matrix_init_identity(matrix)`
**Parameters:**
- `matrix` - Pointer to matrix structure

Initializes a matrix to the identity matrix (no transformation).

### `plutovg_matrix_init_translate(matrix, tx, ty)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `tx, ty` - Translation offsets (float)

Initializes a matrix for translation transformation.

### `plutovg_matrix_init_scale(matrix, sx, sy)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `sx, sy` - Scaling factors (float)

Initializes a matrix for scaling transformation.

### `plutovg_matrix_init_rotate(matrix, angle)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `angle` - Rotation angle in radians (float)

Initializes a matrix for rotation transformation.

### `plutovg_matrix_init_shear(matrix, shx, shy)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `shx, shy` - Shearing factors (float)

Initializes a matrix for shearing transformation.

### `plutovg_matrix_translate(matrix, tx, ty)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `tx, ty` - Translation offsets (float)

Applies translation to an existing matrix.

### `plutovg_matrix_scale(matrix, sx, sy)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `sx, sy` - Scaling factors (float)

Applies scaling to an existing matrix.

### `plutovg_matrix_rotate(matrix, angle)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `angle` - Rotation angle in radians (float)

Applies rotation to an existing matrix.

### `plutovg_matrix_shear(matrix, shx, shy)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `shx, shy` - Shearing factors (float)

Applies shearing to an existing matrix.

### `plutovg_matrix_multiply(matrix, left, right)`
**Parameters:**
- `matrix` - Pointer to result matrix
- `left` - Pointer to first matrix
- `right` - Pointer to second matrix

Multiplies two matrices and stores the result.

### `plutovg_matrix_invert(matrix, inverse)`
**Parameters:**
- `matrix` - Pointer to matrix to invert
- `inverse` - Pointer to store inverse (can be NULL)

**Returns:** Boolean indicating if matrix is invertible

Calculates the inverse of a matrix.

### `plutovg_matrix_map(matrix, x, y, xx, yy)`
**Parameters:**
- `matrix` - Pointer to transformation matrix
- `x, y` - Input coordinates (float)
- `xx, yy` - Pointers to store transformed coordinates

Transforms a point using the matrix.

### `plutovg_matrix_map_point(matrix, src, dst)`
**Parameters:**
- `matrix` - Pointer to transformation matrix
- `src` - Pointer to source point
- `dst` - Pointer to destination point

Transforms a point structure using the matrix.

### `plutovg_matrix_map_points(matrix, src, dst, count)`
**Parameters:**
- `matrix` - Pointer to transformation matrix
- `src` - Pointer to source point array
- `dst` - Pointer to destination point array
- `count` - Number of points to transform (integer)

Transforms an array of points using the matrix.

### `plutovg_matrix_map_rect(matrix, src, dst)`
**Parameters:**
- `matrix` - Pointer to transformation matrix
- `src` - Pointer to source rectangle
- `dst` - Pointer to destination rectangle

Transforms a rectangle using the matrix.

### `plutovg_matrix_parse(matrix, data, length)`
**Parameters:**
- `matrix` - Pointer to matrix structure
- `data` - SVG transform string
- `length` - String length (-1 for null-terminated)

**Returns:** Boolean indicating success

Parses an SVG transform string into a matrix.

---

## Path Operations

### `plutovg_path_create()`
**Returns:** Pointer to new path object

Creates a new empty path object.

### `plutovg_path_reference(path)`
**Parameters:**
- `path` - Pointer to path object

**Returns:** Pointer to the referenced path

Increases the reference count of a path object.

### `plutovg_path_destroy(path)`
**Parameters:**
- `path` - Pointer to path object

Decreases the reference count and destroys the path when it reaches zero.

### `plutovg_path_get_reference_count(path)`
**Parameters:**
- `path` - Pointer to path object

**Returns:** Current reference count (integer)

Gets the current reference count of a path object.

### `plutovg_path_get_elements(path, elements)`
**Parameters:**
- `path` - Pointer to path object
- `elements` - Pointer to store element array pointer

**Returns:** Number of elements (integer)

Retrieves the elements of a path.

### `plutovg_path_move_to(path, x, y)`
**Parameters:**
- `path` - Pointer to path object
- `x, y` - Coordinates (float)

Moves the current point to a new position without drawing.

### `plutovg_path_line_to(path, x, y)`
**Parameters:**
- `path` - Pointer to path object
- `x, y` - End point coordinates (float)

Adds a straight line segment to the path.

### `plutovg_path_quad_to(path, x1, y1, x2, y2)`
**Parameters:**
- `path` - Pointer to path object
- `x1, y1` - Control point coordinates (float)
- `x2, y2` - End point coordinates (float)

Adds a quadratic Bézier curve to the path.

### `plutovg_path_cubic_to(path, x1, y1, x2, y2, x3, y3)`
**Parameters:**
- `path` - Pointer to path object
- `x1, y1` - First control point (float)
- `x2, y2` - Second control point (float)
- `x3, y3` - End point (float)

Adds a cubic Bézier curve to the path.

### `plutovg_path_arc_to(path, rx, ry, angle, large_arc_flag, sweep_flag, x, y)`
**Parameters:**
- `path` - Pointer to path object
- `rx, ry` - Ellipse radii (float)
- `angle` - Rotation angle in radians (float)
- `large_arc_flag` - Large arc flag (boolean)
- `sweep_flag` - Sweep direction flag (boolean)
- `x, y` - End point coordinates (float)

Adds an elliptical arc to the path.

### `plutovg_path_close(path)`
**Parameters:**
- `path` - Pointer to path object

Closes the current sub-path by drawing a line to the start point.

### `plutovg_path_get_current_point(path, x, y)`
**Parameters:**
- `path` - Pointer to path object
- `x, y` - Pointers to store current coordinates

Gets the current point of the path.

### `plutovg_path_reserve(path, count)`
**Parameters:**
- `path` - Pointer to path object
- `count` - Number of elements to reserve (integer)

Reserves space for path elements to optimize memory allocation.

### `plutovg_path_reset(path)`
**Parameters:**
- `path` - Pointer to path object

Clears all path data, resetting to initial state.

### `plutovg_path_add_rect(path, x, y, w, h)`
**Parameters:**
- `path` - Pointer to path object
- `x, y` - Top-left corner coordinates (float)
- `w, h` - Width and height (float)

Adds a rectangle to the path.

### `plutovg_path_add_round_rect(path, x, y, w, h, rx, ry)`
**Parameters:**
- `path` - Pointer to path object
- `x, y` - Top-left corner coordinates (float)
- `w, h` - Width and height (float)
- `rx, ry` - Corner radii (float)

Adds a rounded rectangle to the path.

### `plutovg_path_add_ellipse(path, cx, cy, rx, ry)`
**Parameters:**
- `path` - Pointer to path object
- `cx, cy` - Center coordinates (float)
- `rx, ry` - Radii (float)

Adds an ellipse to the path.

### `plutovg_path_add_circle(path, cx, cy, r)`
**Parameters:**
- `path` - Pointer to path object
- `cx, cy` - Center coordinates (float)
- `r` - Radius (float)

Adds a circle to the path.

### `plutovg_path_add_arc(path, cx, cy, r, a0, a1, ccw)`
**Parameters:**
- `path` - Pointer to path object
- `cx, cy` - Center coordinates (float)
- `r` - Radius (float)
- `a0, a1` - Start and end angles in radians (float)
- `ccw` - Counter-clockwise direction flag (boolean)

Adds an arc to the path.

### `plutovg_path_add_path(path, source, matrix)`
**Parameters:**
- `path` - Pointer to destination path object
- `source` - Pointer to source path object
- `matrix` - Pointer to transformation matrix (can be NULL)

Adds all elements from another path to the current path.

### `plutovg_path_transform(path, matrix)`
**Parameters:**
- `path` - Pointer to path object
- `matrix` - Pointer to transformation matrix

Applies a transformation matrix to the entire path.

### `plutovg_path_traverse(path, traverse_func, closure)`
**Parameters:**
- `path` - Pointer to path object
- `traverse_func` - Pointer to callback function
- `closure` - User-defined data for callback

Traverses the path and calls the callback for each element.

### `plutovg_path_traverse_flatten(path, traverse_func, closure)`
**Parameters:**
- `path` - Pointer to path object
- `traverse_func` - Pointer to callback function
- `closure` - User-defined data for callback

Traverses the path with Bézier curves flattened to line segments.

### `plutovg_path_traverse_dashed(path, offset, dashes, ndashes, traverse_func, closure)`
**Parameters:**
- `path` - Pointer to path object
- `offset` - Starting offset into dash pattern (float)
- `dashes` - Array of dash lengths
- `ndashes` - Number of dash elements (integer)
- `traverse_func` - Pointer to callback function
- `closure` - User-defined data for callback

Traverses the path with a dashed pattern applied.

### `plutovg_path_clone(path)`
**Parameters:**
- `path` - Pointer to path object

**Returns:** Pointer to cloned path

Creates a copy of the path.

### `plutovg_path_clone_flatten(path)`
**Parameters:**
- `path` - Pointer to path object

**Returns:** Pointer to cloned path with flattened curves

Creates a copy of the path with Bézier curves flattened.

### `plutovg_path_clone_dashed(path, offset, dashes, ndashes)`
**Parameters:**
- `path` - Pointer to path object
- `offset` - Starting offset into dash pattern (float)
- `dashes` - Array of dash lengths
- `ndashes` - Number of dash elements (integer)

**Returns:** Pointer to cloned path with dash pattern

Creates a copy of the path with a dashed pattern applied.

### `plutovg_path_extents(path, extents, tight)`
**Parameters:**
- `path` - Pointer to path object
- `extents` - Pointer to rectangle for bounding box
- `tight` - Precise bounds flag (boolean)

**Returns:** Total path length (float)

Computes the bounding box and total length of the path.

### `plutovg_path_length(path)`
**Parameters:**
- `path` - Pointer to path object

**Returns:** Total path length (float)

Calculates the total length of the path.

### `plutovg_path_parse(path, data, length)`
**Parameters:**
- `path` - Pointer to path object
- `data` - SVG path data string
- `length` - String length (-1 for null-terminated)

**Returns:** Boolean indicating success

Parses SVG path data into a path object.

---

## Text Processing

### `plutovg_text_iterator_init(it, text, length, encoding)`
**Parameters:**
- `it` - Pointer to text iterator structure
- `text` - Pointer to text data
- `length` - Text length (-1 for null-terminated)
- `encoding` - Text encoding type

Initializes a text iterator for traversing Unicode code points.

### `plutovg_text_iterator_has_next(it)`
**Parameters:**
- `it` - Pointer to text iterator

**Returns:** Boolean indicating if more code points available

Checks if there are more code points to iterate.

### `plutovg_text_iterator_next(it)`
**Parameters:**
- `it` - Pointer to text iterator

**Returns:** Next Unicode code point (integer)

Retrieves the next code point and advances the iterator.

---

## Font Management

### `plutovg_font_face_load_from_file(filename, ttcindex)`
**Parameters:**
- `filename` - Path to font file
- `ttcindex` - TrueType Collection index (integer)

**Returns:** Pointer to font face object or NULL on failure

Loads a font face from a file.

### `plutovg_font_face_load_from_data(data, length, ttcindex, destroy_func, closure)`
**Parameters:**
- `data` - Pointer to font data
- `length` - Data length (integer)
- `ttcindex` - TrueType Collection index (integer)
- `destroy_func` - Function to free data when done
- `closure` - User data for destroy function

**Returns:** Pointer to font face object or NULL on failure

Loads a font face from memory data.

### `plutovg_font_face_reference(face)`
**Parameters:**
- `face` - Pointer to font face object

**Returns:** Pointer to referenced font face

Increments the reference count of a font face.

### `plutovg_font_face_destroy(face)`
**Parameters:**
- `face` - Pointer to font face object

Decrements the reference count and destroys the font face when it reaches zero.

### `plutovg_font_face_get_reference_count(face)`
**Parameters:**
- `face` - Pointer to font face object

**Returns:** Current reference count (integer)

Gets the current reference count of a font face.

### `plutovg_font_face_get_metrics(face, size, ascent, descent, line_gap, extents)`
**Parameters:**
- `face` - Pointer to font face object
- `size` - Font size in pixels (float)
- `ascent` - Pointer to store ascent value
- `descent` - Pointer to store descent value
- `line_gap` - Pointer to store line gap value
- `extents` - Pointer to rectangle for font bounding box

Retrieves font metrics at a specified size.

### `plutovg_font_face_get_glyph_metrics(face, size, codepoint, advance_width, left_side_bearing, extents)`
**Parameters:**
- `face` - Pointer to font face object
- `size` - Font size in pixels (float)
- `codepoint` - Unicode code point (integer)
- `advance_width` - Pointer to store advance width
- `left_side_bearing` - Pointer to store left bearing
- `extents` - Pointer to rectangle for glyph bounds

Retrieves metrics for a specific glyph.

### `plutovg_font_face_get_glyph_path(face, size, x, y, codepoint, path)`
**Parameters:**
- `face` - Pointer to font face object
- `size` - Font size in pixels (float)
- `x, y` - Glyph position (float)
- `codepoint` - Unicode code point (integer)
- `path` - Pointer to path object to store glyph outline

**Returns:** Glyph advance width (float)

Retrieves the path outline of a glyph.

### `plutovg_font_face_traverse_glyph_path(face, size, x, y, codepoint, traverse_func, closure)`
**Parameters:**
- `face` - Pointer to font face object
- `size` - Font size in pixels (float)
- `x, y` - Glyph position (float)
- `codepoint` - Unicode code point (integer)
- `traverse_func` - Pointer to callback function
- `closure` - User data for callback

**Returns:** Glyph advance width (float)

Traverses the glyph path and calls a callback for each element.

### `plutovg_font_face_text_extents(face, size, text, length, encoding, extents)`
**Parameters:**
- `face` - Pointer to font face object
- `size` - Font size in pixels (float)
- `text` - Pointer to text data
- `length` - Text length (-1 for null-terminated)
- `encoding` - Text encoding type
- `extents` - Pointer to rectangle for text bounds

**Returns:** Total text advance width (float)

Computes the bounding box and advance width of text.

---

## Font Cache Management

### `plutovg_font_face_cache_create()`
**Returns:** Pointer to new font cache object

Creates a new empty font face cache.

### `plutovg_font_face_cache_reference(cache)`
**Parameters:**
- `cache` - Pointer to font cache object

**Returns:** Pointer to referenced cache

Increments the reference count of a font cache.

### `plutovg_font_face_cache_destroy(cache)`
**Parameters:**
- `cache` - Pointer to font cache object

Decrements the reference count and destroys the cache when it reaches zero.

### `plutovg_font_face_cache_reference_count(cache)`
**Parameters:**
- `cache` - Pointer to font cache object

**Returns:** Current reference count (integer)

Gets the current reference count of a font cache.

### `plutovg_font_face_cache_reset(cache)`
**Parameters:**
- `cache` - Pointer to font cache object

Removes all entries from the font cache.

### `plutovg_font_face_cache_add(cache, family, bold, italic, face)`
**Parameters:**
- `cache` - Pointer to font cache object
- `family` - Font family name string
- `bold` - Bold style flag (boolean)
- `italic` - Italic style flag (boolean)
- `face` - Pointer to font face object

Adds a font face to the cache with specified family and style.

### `plutovg_font_face_cache_add_file(cache, family, bold, italic, filename, ttcindex)`
**Parameters:**
- `cache` - Pointer to font cache object
- `family` - Font family name string
- `bold` - Bold style flag (boolean)
- `italic` - Italic style flag (boolean)
- `filename` - Path to font file
- `ttcindex` - TrueType Collection index (integer)

**Returns:** Boolean indicating success

Loads a font face from file and adds it to the cache.

### `plutovg_font_face_cache_get(cache, family, bold, italic)`
**Parameters:**
- `cache` - Pointer to font cache object
- `family` - Font family name string
- `bold` - Bold style flag (boolean)
- `italic` - Italic style flag (boolean)

**Returns:** Pointer to matching font face or NULL

Retrieves a font face from the cache by family and style.

### `plutovg_font_face_cache_load_file(cache, filename)`
**Parameters:**
- `cache` - Pointer to font cache object
- `filename` - Path to font file

**Returns:** Number of faces loaded or -1 on error

Loads all font faces from a file and adds them to the cache.

### `plutovg_font_face_cache_load_dir(cache, dirname)`
**Parameters:**
- `cache` - Pointer to font cache object
- `dirname` - Path to directory

**Returns:** Number of faces loaded or -1 on error

Recursively loads all font files from a directory and adds them to the cache.

### `plutovg_font_face_cache_load_sys(cache)`
**Parameters:**
- `cache` - Pointer to font cache object

**Returns:** Number of faces loaded or -1 on error

Loads all available system fonts and adds them to the cache.

---

## Color Management

### `plutovg_color_init_rgb(color, r, g, b)`
**Parameters:**
- `color` - Pointer to color structure
- `r, g, b` - RGB components (0.0-1.0)

Initializes a color using RGB values.

### `plutovg_color_init_rgba(color, r, g, b, a)`
**Parameters:**
- `color` - Pointer to color structure
- `r, g, b, a` - RGBA components (0.0-1.0)

Initializes a color using RGBA values.

### `plutovg_color_init_rgb8(color, r, g, b)`
**Parameters:**
- `color` - Pointer to color structure
- `r, g, b` - RGB components (0-255)

Initializes a color using 8-bit RGB values.

### `plutovg_color_init_rgba8(color, r, g, b, a)`
**Parameters:**
- `color` - Pointer to color structure
- `r, g, b, a` - RGBA components (0-255)

Initializes a color using 8-bit RGBA values.

### `plutovg_color_init_rgba32(color, value)`
**Parameters:**
- `color` - Pointer to color structure
- `value` - 32-bit RGBA value (integer)

Initializes a color from a 32-bit RGBA value.

### `plutovg_color_init_argb32(color, value)`
**Parameters:**
- `color` - Pointer to color structure
- `value` - 32-bit ARGB value (integer)

Initializes a color from a 32-bit ARGB value.

### `plutovg_color_init_hsl(color, h, s, l)`
**Parameters:**
- `color` - Pointer to color structure
- `h` - Hue in degrees (0-360)
- `s, l` - Saturation and lightness (0.0-1.0)

Initializes a color using HSL values.

### `plutovg_color_init_hsla(color, h, s, l, a)`
**Parameters:**
- `color` - Pointer to color structure
- `h` - Hue in degrees (0-360)
- `s, l, a` - Saturation, lightness, and alpha (0.0-1.0)

Initializes a color using HSLA values.

### `plutovg_color_to_rgba32(color)`
**Parameters:**
- `color` - Pointer to color structure

**Returns:** 32-bit RGBA value (integer)

Converts a color to a 32-bit RGBA value.

### `plutovg_color_to_argb32(color)`
**Parameters:**
- `color` - Pointer to color structure

**Returns:** 32-bit ARGB value (integer)

Converts a color to a 32-bit ARGB value.

### `plutovg_color_parse(color, data, length)`
**Parameters:**
- `color` - Pointer to color structure
- `data` - CSS color string
- `length` - String length (-1 for null-terminated)

**Returns:** Number of characters consumed (0 on failure)

Parses a color from a CSS color string.

---

## Surface Operations

### `plutovg_surface_create(width, height)`
**Parameters:**
- `width, height` - Surface dimensions in pixels (integer)

**Returns:** Pointer to new surface object

Creates a new image surface with specified dimensions.

### `plutovg_surface_create_for_data(data, width, height, stride)`
**Parameters:**
- `data` - Pointer to pixel data
- `width, height` - Surface dimensions in pixels (integer)
- `stride` - Bytes per row (integer)

**Returns:** Pointer to surface object using existing data

Creates a surface using existing pixel data.

### `plutovg_surface_load_from_image_file(filename)`
**Parameters:**
- `filename` - Path to image file

**Returns:** Pointer to surface object or NULL on failure

Loads an image surface from a file.

### `plutovg_surface_load_from_image_data(data, length)`
**Parameters:**
- `data` - Pointer to image data
- `length` - Data length in bytes (integer)

**Returns:** Pointer to surface object or NULL on failure

Loads an image surface from raw image data.

### `plutovg_surface_load_from_image_base64(data, length)`
**Parameters:**
- `data` - Base64-encoded image data string
- `length` - String length (-1 for null-terminated)

**Returns:** Pointer to surface object or NULL on failure

Loads an image surface from base64-encoded data.

### `plutovg_surface_reference(surface)`
**Parameters:**
- `surface` - Pointer to surface object

**Returns:** Pointer to referenced surface

Increments the reference count of a surface.

### `plutovg_surface_destroy(surface)`
**Parameters:**
- `surface` - Pointer to surface object

Decrements the reference count and destroys the surface when it reaches zero.

### `plutovg_surface_get_reference_count(surface)`
**Parameters:**
- `surface` - Pointer to surface object

**Returns:** Current reference count (integer)

Gets the current reference count of a surface.

### `plutovg_surface_get_data(surface)`
**Parameters:**
- `surface` - Pointer to surface object

**Returns:** Pointer to pixel data

Gets the pixel data of the surface.

### `plutovg_surface_get_width(surface)`
**Parameters:**
- `surface` - Pointer to surface object

**Returns:** Width in pixels (integer)

Gets the width of the surface.

### `plutovg_surface_get_height(surface)`
**Parameters:**
- `surface` - Pointer to surface object

**Returns:** Height in pixels (integer)

Gets the height of the surface.

### `plutovg_surface_get_stride(surface)`
**Parameters:**
- `surface` - Pointer to surface object

**Returns:** Bytes per row (integer)

Gets the stride (bytes per row) of the surface.

### `plutovg_surface_clear(surface, color)`
**Parameters:**
- `surface` - Pointer to surface object
- `color` - Pointer to clear color

Clears the entire surface with the specified color.

### `plutovg_surface_write_to_png(surface, filename)`
**Parameters:**
- `surface` - Pointer to surface object
- `filename` - Output PNG file path

**Returns:** Boolean indicating success

Writes the surface to a PNG file.

### `plutovg_surface_write_to_jpg(surface, filename, quality)`
**Parameters:**
- `surface` - Pointer to surface object
- `filename` - Output JPEG file path
- `quality` - JPEG quality (0-100)

**Returns:** Boolean indicating success

Writes the surface to a JPEG file.

### `plutovg_surface_write_to_png_stream(surface, write_func, closure)`
**Parameters:**
- `surface` - Pointer to surface object
- `write_func` - Callback function for writing data
- `closure` - User data for callback

**Returns:** Boolean indicating success

Writes the surface to a PNG stream using a callback.

### `plutovg_surface_write_to_jpg_stream(surface, write_func, closure, quality)`
**Parameters:**
- `surface` - Pointer to surface object
- `write_func` - Callback function for writing data
- `closure` - User data for callback
- `quality` - JPEG quality (0-100)

**Returns:** Boolean indicating success

Writes the surface to a JPEG stream using a callback.

### `plutovg_convert_argb_to_rgba(dst, src, width, height, stride)`
**Parameters:**
- `dst` - Destination buffer pointer
- `src` - Source buffer pointer
- `width, height` - Image dimensions (integer)
- `stride` - Bytes per row (integer)

Converts pixel data from premultiplied ARGB to RGBA format.

### `plutovg_convert_rgba_to_argb(dst, src, width, height, stride)`
**Parameters:**
- `dst` - Destination buffer pointer
- `src` - Source buffer pointer
- `width, height` - Image dimensions (integer)
- `stride` - Bytes per row (integer)

Converts pixel data from RGBA to premultiplied ARGB format.

---

## Paint Objects

### `plutovg_paint_create_rgb(r, g, b)`
**Parameters:**
- `r, g, b` - RGB components (0.0-1.0)

**Returns:** Pointer to solid color paint

Creates a solid RGB paint.

### `plutovg_paint_create_rgba(r, g, b, a)`
**Parameters:**
- `r, g, b, a` - RGBA components (0.0-1.0)

**Returns:** Pointer to solid color paint

Creates a solid RGBA paint.

### `plutovg_paint_create_color(color)`
**Parameters:**
- `color` - Pointer