; PlutoSVG PureBasic Header
; Author idle 
; Ported from plutosvg.h
; Copyright (c) 2020-2025 Samuel Ugochukwu <sammycageagle@gmail.com>
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

; Version constants
#PLUTOSVG_VERSION_MAJOR = 0
#PLUTOSVG_VERSION_MINOR = 0  
#PLUTOSVG_VERSION_MICRO = 7

#PLUTOVG_VERSION_MAJOR = 1
#PLUTOVG_VERSION_MINOR = 3
#PLUTOVG_VERSION_MICRO = 1

#PLUTOVG_PI = #PI 
#PLUTOVG_TWO_PI = 2*#PI 
#PLUTOVG_HALF_PI = #PI/2 
#PLUTOVG_SQRT2 = 1.4142135623730950488
#PLUTOVG_KAPPA = 0.5522847498307933984

; Structures
Structure plutovg_point
  x.f
  y.f
EndStructure

Structure plutovg_rect
  x.f
  y.f
  w.f
  h.f
EndStructure

Structure plutovg_matrix
  a.f
  b.f
  c.f
  d.f
  e.f
  f.f
EndStructure

Structure plutovg_color
  r.f
  g.f
  b.f
  a.f
EndStructure

Structure plutovg_gradient_stop
  offset.f
  color.plutovg_color
EndStructure

Structure plutovg_path_header 
  command.l
  length.l
EndStructure

Structure plutovg_path_element
  StructureUnion
    header.plutovg_path_header 
    point.plutovg_point
  EndStructureUnion
EndStructure

Structure plutovg_path_iterator
  *elements.plutovg_path_element
  size.l
  index.l
EndStructure

Structure plutovg_text_iterator
  *text
  length.l
  encoding.l
  index.l
EndStructure

; Enumerations
Enumeration plutovg_path_command
  #PLUTOVG_PATH_COMMAND_MOVE_TO
  #PLUTOVG_PATH_COMMAND_LINE_TO
  #PLUTOVG_PATH_COMMAND_CUBIC_TO
  #PLUTOVG_PATH_COMMAND_CLOSE
EndEnumeration

Enumeration plutovg_text_encoding
  #PLUTOVG_TEXT_ENCODING_LATIN1
  #PLUTOVG_TEXT_ENCODING_UTF8
  #PLUTOVG_TEXT_ENCODING_UTF16
  #PLUTOVG_TEXT_ENCODING_UTF32
EndEnumeration

Enumeration plutovg_texture_type
  #PLUTOVG_TEXTURE_TYPE_PLAIN
  #PLUTOVG_TEXTURE_TYPE_TILED
EndEnumeration

Enumeration plutovg_spread_method
  #PLUTOVG_SPREAD_METHOD_PAD
  #PLUTOVG_SPREAD_METHOD_REFLECT
  #PLUTOVG_SPREAD_METHOD_REPEAT
EndEnumeration

Enumeration plutovg_fill_rule
  #PLUTOVG_FILL_RULE_NON_ZERO
  #PLUTOVG_FILL_RULE_EVEN_ODD
EndEnumeration

Enumeration plutovg_operator
  #PLUTOVG_OPERATOR_CLEAR
  #PLUTOVG_OPERATOR_SRC
  #PLUTOVG_OPERATOR_DST
  #PLUTOVG_OPERATOR_SRC_OVER
  #PLUTOVG_OPERATOR_DST_OVER
  #PLUTOVG_OPERATOR_SRC_IN
  #PLUTOVG_OPERATOR_DST_IN
  #PLUTOVG_OPERATOR_SRC_OUT
  #PLUTOVG_OPERATOR_DST_OUT
  #PLUTOVG_OPERATOR_SRC_ATOP
  #PLUTOVG_OPERATOR_DST_ATOP
  #PLUTOVG_OPERATOR_XOR
EndEnumeration

Enumeration plutovg_line_cap
  #PLUTOVG_LINE_CAP_BUTT
  #PLUTOVG_LINE_CAP_ROUND
  #PLUTOVG_LINE_CAP_SQUARE
EndEnumeration

Enumeration plutovg_line_join
  #PLUTOVG_LINE_JOIN_MITER
  #PLUTOVG_LINE_JOIN_ROUND
  #PLUTOVG_LINE_JOIN_BEVEL
EndEnumeration


Prototype.i plutovg_destroy_func_t(*closure)
Prototype.i plutosvg_palette_func_t(*closure, *name, length.i, *color.plutovg_color)

ImportC "libplutosvg.a" 
  
  ;-Version functions
  plutosvg_version.i()
  plutosvg_version_string()
  
  ;-Document loading functions
  plutosvg_document_load_from_data(*data, length.i, width.f, height.f, destroy_func.plutovg_destroy_func_t, *closure)
  plutosvg_document_load_from_file(filename.p-utf8, width.f, height.f)
  
  ;-Document rendering functions
  plutosvg_document_render.i(*document, id, canvas, *current_color.plutovg_color, palette_func.plutosvg_palette_func_t, *closure)
  plutosvg_document_render_to_surface.i(document, id, width.i, height.i, *current_color.plutovg_color, palette_func.plutosvg_palette_func_t, *closure)
  
  ;-Document property functions
  plutosvg_document_get_width.f(*document)
  plutosvg_document_get_height.f(*document)
  plutosvg_document_extents.i(*document, *id, *extents.plutovg_rect)
  
  ;-Document cleanup
  plutosvg_document_destroy(*document)
  
  ;-FreeType integration
  plutosvg_ft_svg_hooks.i()
  
  ;-Version functions
  plutovg_version()
  plutovg_version_string()
  
  ;-Matrix functions
  plutovg_matrix_init(*matrix.plutovg_matrix, a.f, b.f, c.f, d.f, e.f, f.f)
  plutovg_matrix_init_identity(*matrix.plutovg_matrix)
  plutovg_matrix_init_translate(*matrix.plutovg_matrix, tx.f, ty.f)
  plutovg_matrix_init_scale(*matrix.plutovg_matrix, sx.f, sy.f)
  plutovg_matrix_init_rotate(*matrix.plutovg_matrix, angle.f)
  plutovg_matrix_init_shear(*matrix.plutovg_matrix, shx.f, shy.f)
  plutovg_matrix_translate(*matrix.plutovg_matrix, tx.f, ty.f)
  plutovg_matrix_scale(*matrix.plutovg_matrix, sx.f, sy.f)
  plutovg_matrix_rotate(*matrix.plutovg_matrix, angle.f)
  plutovg_matrix_shear(*matrix.plutovg_matrix, shx.f, shy.f)
  plutovg_matrix_multiply(*matrix.plutovg_matrix, *left.plutovg_matrix, *right.plutovg_matrix)
  plutovg_matrix_invert.b(*matrix.plutovg_matrix, *inverse.plutovg_matrix)
  plutovg_matrix_map(*matrix.plutovg_matrix, x.f, y.f, *xx.Float, *yy.Float)
  plutovg_matrix_map_point(*matrix.plutovg_matrix, *src.plutovg_point, *dst.plutovg_point)
  plutovg_matrix_map_points(*matrix.plutovg_matrix, *src.plutovg_point, *dst.plutovg_point, count.l)
  plutovg_matrix_map_rect(*matrix.plutovg_matrix, *src.plutovg_rect, *dst.plutovg_rect)
  plutovg_matrix_parse.b(*matrix.plutovg_matrix,*pdata, length.l)
  
  ;-Path functions
  plutovg_path_create()
  plutovg_path_reference(*path)
  plutovg_path_destroy(*path)
  plutovg_path_get_reference_count.l(*path)
  plutovg_path_get_elements.l(*path,*elements)
  plutovg_path_move_to(*path, x.f, y.f)
  plutovg_path_line_to(*path, x.f, y.f)
  plutovg_path_quad_to(*path, x1.f, y1.f, x2.f, y2.f)
  plutovg_path_cubic_to(*path, x1.f, y1.f, x2.f, y2.f, x3.f, y3.f)
  plutovg_path_arc_to(*path, rx.f, ry.f, angle.f, large_arc_flag.b, sweep_flag.b, x.f, y.f)
  plutovg_path_close(*path)
  plutovg_path_get_current_point(*path, *x.Float, *y.Float)
  plutovg_path_reserve(*path, count.l)
  plutovg_path_reset(*path)
  plutovg_path_add_rect(*path, x.f, y.f, w.f, h.f)
  plutovg_path_add_round_rect(*path, x.f, y.f, w.f, h.f, rx.f, ry.f)
  plutovg_path_add_ellipse(*path, cx.f, cy.f, rx.f, ry.f)
  plutovg_path_add_circle(*path, cx.f, cy.f, r.f)
  plutovg_path_add_arc(*path, cx.f, cy.f, r.f, a0.f, a1.f, ccw.b)
  plutovg_path_add_path(*path, *source, *matrix.plutovg_matrix)
  plutovg_path_transform(*path, *matrix.plutovg_matrix)
  plutovg_path_traverse(*path, *traverse_func, *closure)
  plutovg_path_traverse_flatten(*path, *traverse_func, *closure)
  plutovg_path_traverse_dashed(*path, offset.f, *dashes.Float, ndashes.l, *traverse_func, *closure)
  plutovg_path_clone(*path)
  plutovg_path_clone_flatten(*path)
  plutovg_path_clone_dashed(*path, offset.f, *dashes.Float, ndashes.l)
  plutovg_path_extents.f(*path, *extents.plutovg_rect, tight.b)
  plutovg_path_length.f(*path)
  plutovg_path_parse.b(*path, *pData, length.l)
  
  ;-Path iterator functions
  plutovg_path_iterator_init(*it.plutovg_path_iterator, *path)
  plutovg_path_iterator_has_next.b(*it.plutovg_path_iterator)
  plutovg_path_iterator_next.l(*it.plutovg_path_iterator, *points.plutovg_point)
  
  ;-Text iterator functions
  plutovg_text_iterator_init(*it.plutovg_text_iterator, *text, length.l, encoding.l)
  plutovg_text_iterator_has_next.b(*it.plutovg_text_iterator)
  plutovg_text_iterator_next.l(*it.plutovg_text_iterator)
  
  ;-Font face functions
  plutovg_font_face_load_from_file(filename.p-utf8, ttcindex.l)
  plutovg_font_face_load_from_data(*data, length.l, ttcindex.l, *destroy_func, *closure)
  plutovg_font_face_reference(*face)
  plutovg_font_face_destroy(*face)
  plutovg_font_face_get_reference_count.l(*face)
  plutovg_font_face_get_metrics(*face, size.f, *ascent.Float, *descent.Float, *line_gap.Float, *extents.plutovg_rect)
  plutovg_font_face_get_glyph_metrics(*face, size.f, codepoint.l, *advance_width.Float, *left_side_bearing.Float, *extents.plutovg_rect)
  plutovg_font_face_get_glyph_path.f(*face, size.f, x.f, y.f, codepoint.l, *path)
  plutovg_font_face_traverse_glyph_path.f(*face, size.f, x.f, y.f, codepoint.l, *traverse_func, *closure)
  plutovg_font_face_text_extents.f(*face, size.f, *text, length.l, encoding.l, *extents.plutovg_rect)
  
  ;-Font face cache functions
  plutovg_font_face_cache_create()
  plutovg_font_face_cache_reference(*cache)
  plutovg_font_face_cache_destroy(*cache)
  plutovg_font_face_cache_reference_count.l(*cache)
  plutovg_font_face_cache_reset(*cache)
  plutovg_font_face_cache_add(*cache, family.p-ascii, bold.b, italic.b, *face)
  plutovg_font_face_cache_add_file.b(*cache, family.p-ascii, bold.b, italic.b, filename.p-ascii, ttcindex.l)
  plutovg_font_face_cache_get(*cache, family.p-ascii, bold.b, italic.b)
  plutovg_font_face_cache_load_file.l(*cache, filename.p-ascii)
  plutovg_font_face_cache_load_dir.l(*cache, dirname.p-ascii)
  plutovg_font_face_cache_load_sys.l(*cache)
  
  ;-Color functions
  plutovg_color_init_rgb(*color.plutovg_color, r.f, g.f, b.f)
  plutovg_color_init_rgba(*color.plutovg_color, r.f, g.f, b.f, a.f)
  plutovg_color_init_rgb8(*color.plutovg_color, r.l, g.l, b.l)
  plutovg_color_init_rgba8(*color.plutovg_color, r.l, g.l, b.l, a.l)
  plutovg_color_init_rgba32(*color.plutovg_color, value.l)
  plutovg_color_init_argb32(*color.plutovg_color, value.l)
  plutovg_color_init_hsl(*color.plutovg_color, h.f, s.f, l.f)
  plutovg_color_init_hsla(*color.plutovg_color, h.f, s.f, l.f, a.f)
  plutovg_color_to_rgba32.l(*color.plutovg_color)
  plutovg_color_to_argb32.l(*color.plutovg_color)
  plutovg_color_parse.l(*color.plutovg_color, *pData, length.l)
  
  ;-Surface functions
  plutovg_surface_create(width.l, height.l)
  plutovg_surface_create_for_data(*data.Byte, width.l, height.l, stride.l)
  plutovg_surface_load_from_image_file(filename.p-ascii)
  plutovg_surface_load_from_image_data(*data, length.l)
  plutovg_surface_load_from_image_base64(*pData, length.l)
  plutovg_surface_reference(*surface)
  plutovg_surface_destroy(*surface)
  plutovg_surface_get_reference_count.l(*surface)
  plutovg_surface_get_data(*surface)
  plutovg_surface_get_width.l(*surface)
  plutovg_surface_get_height.l(*surface)
  plutovg_surface_get_stride.l(*surface)
  plutovg_surface_clear(*surface, *color.plutovg_color)
  plutovg_surface_write_to_png.b(*surface, filename.p-ascii)
  plutovg_surface_write_to_jpg.b(*surface, filename.p-ascii, quality.l)
  plutovg_surface_write_to_png_stream.b(*surface, *write_func, *closure)
  plutovg_surface_write_to_jpg_stream.b(*surface, *write_func, *closure, quality.l)
  
  ;-Pixel format conversion functions
  plutovg_convert_argb_to_rgba(*dst.Byte, *src.Byte, width.l, height.l, stride.l)
  plutovg_convert_rgba_to_argb(*dst.Byte, *src.Byte, width.l, height.l, stride.l)
  
  ;-Paint functions
  plutovg_paint_create_rgb(r.f, g.f, b.f)
  plutovg_paint_create_rgba(r.f, g.f, b.f, a.f)
  plutovg_paint_create_color(*color.plutovg_color)
  plutovg_paint_create_linear_gradient(x1.f, y1.f, x2.f, y2.f, spread.l, *stops.plutovg_gradient_stop, nstops.l, *matrix.plutovg_matrix)
  plutovg_paint_create_radial_gradient(cx.f, cy.f, cr.f, fx.f, fy.f, fr.f, spread.l, *stops.plutovg_gradient_stop, nstops.l, *matrix.plutovg_matrix)
  plutovg_paint_create_texture(*surface, type.l, opacity.f, *matrix.plutovg_matrix)
  plutovg_paint_reference(*paint)
  plutovg_paint_destroy(*paint)
  plutovg_paint_get_reference_count.l(*paint)
  
  ;-Canvas functions
  plutovg_canvas_create(*surface)
  plutovg_canvas_reference(*canvas)
  plutovg_canvas_destroy(*canvas)
  plutovg_canvas_get_reference_count.l(*canvas)
  plutovg_canvas_get_surface(*canvas)
  plutovg_canvas_save(*canvas)
  plutovg_canvas_restore(*canvas)
  
  ;-Canvas paint settings
  plutovg_canvas_set_rgb(*canvas, r.f, g.f, b.f)
  plutovg_canvas_set_rgba(*canvas, r.f, g.f, b.f, a.f)
  plutovg_canvas_set_color(*canvas, *color.plutovg_color)
  plutovg_canvas_set_linear_gradient(*canvas, x1.f, y1.f, x2.f, y2.f, spread.l, *stops.plutovg_gradient_stop, nstops.l, *matrix.plutovg_matrix)
  plutovg_canvas_set_radial_gradient(*canvas, cx.f, cy.f, cr.f, fx.f, fy.f, fr.f, spread.l, *stops.plutovg_gradient_stop, nstops.l, *matrix.plutovg_matrix)
  plutovg_canvas_set_texture(*canvas, *surface, type.l, opacity.f, *matrix.plutovg_matrix)
  plutovg_canvas_set_paint(*canvas, *paint)
  plutovg_canvas_get_paint(*canvas, *color.plutovg_color)
  
  ;-Canvas font settings
  plutovg_canvas_set_font_face_cache(*canvas, *cache)
  plutovg_canvas_get_font_face_cache(*canvas)
  plutovg_canvas_add_font_face(*canvas, family.p-ascii, bold.b, italic.b, *face)
  plutovg_canvas_add_font_file.b(*canvas, family.p-ascii, bold.b, italic.b, filename.p-ascii, ttcindex.l)
  plutovg_canvas_select_font_face.b(*canvas, family.p-ascii, bold.b, italic.b)
  plutovg_canvas_set_font(*canvas, *face, size.f)
  plutovg_canvas_set_font_face(*canvas, *face)
  plutovg_canvas_get_font_face(*canvas)
  plutovg_canvas_set_font_size(*canvas, size.f)
  plutovg_canvas_get_font_size.f(*canvas)
  
  ;-Canvas state settings
  plutovg_canvas_set_fill_rule(*canvas, winding.l)
  plutovg_canvas_get_fill_rule.l(*canvas)
  plutovg_canvas_set_operator(*canvas, op.l)
  plutovg_canvas_get_operator.l(*canvas)
  plutovg_canvas_set_opacity(*canvas, opacity.f)
  plutovg_canvas_get_opacity.f(*canvas)
  plutovg_canvas_set_line_width(*canvas, line_width.f)
  plutovg_canvas_get_line_width.f(*canvas)
  plutovg_canvas_set_line_cap(*canvas, line_cap.l)
  plutovg_canvas_get_line_cap.l(*canvas)
  plutovg_canvas_set_line_join(*canvas, line_join.l)
  plutovg_canvas_get_line_join.l(*canvas)
  plutovg_canvas_set_miter_limit(*canvas, miter_limit.f)
  plutovg_canvas_get_miter_limit.f(*canvas)
  plutovg_canvas_set_dash(*canvas, offset.f, *dashes.Float, ndashes.l)
  plutovg_canvas_set_dash_offset(*canvas, offset.f)
  plutovg_canvas_get_dash_offset.f(*canvas)
  plutovg_canvas_set_dash_array(*canvas, *dashes.Float, ndashes.l)
  plutovg_canvas_get_dash_array.l(*canvas, *dashes)
  
  ;-Canvas transformation functions
  plutovg_canvas_translate(*canvas, tx.f, ty.f)
  plutovg_canvas_scale(*canvas, sx.f, sy.f)
  plutovg_canvas_shear(*canvas, shx.f, shy.f)
  plutovg_canvas_rotate(*canvas, angle.f)
  plutovg_canvas_transform(*canvas, *matrix.plutovg_matrix)
  plutovg_canvas_reset_matrix(*canvas)
  plutovg_canvas_set_matrix(*canvas, *matrix.plutovg_matrix)
  plutovg_canvas_get_matrix(*canvas, *matrix.plutovg_matrix)
  plutovg_canvas_map(*canvas, x.f, y.f, *xx.Float, *yy.Float)
  plutovg_canvas_map_point(*canvas, *src.plutovg_point, *dst.plutovg_point)
  plutovg_canvas_map_rect(*canvas, *src.plutovg_rect, *dst.plutovg_rect)
  
  ;-Canvas path construction functions
  plutovg_canvas_move_to(*canvas, x.f, y.f)
  plutovg_canvas_line_to(*canvas, x.f, y.f)
  plutovg_canvas_quad_to(*canvas, x1.f, y1.f, x2.f, y2.f)
  plutovg_canvas_cubic_to(*canvas, x1.f, y1.f, x2.f, y2.f, x3.f, y3.f)
  plutovg_canvas_arc_to(*canvas, rx.f, ry.f, angle.f, large_arc_flag.b, sweep_flag.b, x.f, y.f)
  plutovg_canvas_rect(*canvas, x.f, y.f, w.f, h.f)
  plutovg_canvas_round_rect(*canvas, x.f, y.f, w.f, h.f, rx.f, ry.f)
  plutovg_canvas_ellipse(*canvas, cx.f, cy.f, rx.f, ry.f)
  plutovg_canvas_circle(*canvas, cx.f, cy.f, r.f)
  plutovg_canvas_arc(*canvas, cx.f, cy.f, r.f, a0.f, a1.f, ccw.b)
  plutovg_canvas_add_path(*canvas, *path)
  plutovg_canvas_new_path(*canvas)
  plutovg_canvas_close_path(*canvas)
  plutovg_canvas_get_current_point(*canvas, *x.Float, *y.Float)
  plutovg_canvas_get_path(*canvas)
  
  ;-Canvas hit testing functions
  plutovg_canvas_fill_contains.b(*canvas, x.f, y.f)
  plutovg_canvas_stroke_contains.b(*canvas, x.f, y.f)
  plutovg_canvas_clip_contains.b(*canvas, x.f, y.f)
  
  ;-Canvas extent functions
  plutovg_canvas_fill_extents(*canvas, *extents.plutovg_rect)
  plutovg_canvas_stroke_extents(*canvas, *extents.plutovg_rect)
  plutovg_canvas_clip_extents(*canvas, *extents.plutovg_rect)
  
  ;-Canvas drawing operations
  plutovg_canvas_fill(*canvas)
  plutovg_canvas_stroke(*canvas)
  plutovg_canvas_clip(*canvas)
  plutovg_canvas_paint(*canvas)
  plutovg_canvas_fill_preserve(*canvas)
  plutovg_canvas_stroke_preserve(*canvas)
  plutovg_canvas_clip_preserve(*canvas)
  
  ;-Canvas shape drawing functions
  plutovg_canvas_fill_rect(*canvas, x.f, y.f, w.f, h.f)
  plutovg_canvas_fill_path(*canvas, *path)
  plutovg_canvas_stroke_rect(*canvas, x.f, y.f, w.f, h.f)
  plutovg_canvas_stroke_path(*canvas, *path)
  plutovg_canvas_clip_rect(*canvas, x.f, y.f, w.f, h.f)
  plutovg_canvas_clip_path(*canvas, *path)
  
  ;-Canvas text functions
  plutovg_canvas_add_glyph.f(*canvas, codepoint.l, x.f, y.f)
  plutovg_canvas_add_text.f(*canvas, *text, length.l, encoding.l, x.f, y.f)
  plutovg_canvas_fill_text.f(*canvas, *text, length.l, encoding.l, x.f, y.f)
  plutovg_canvas_stroke_text.f(*canvas, *text, length.l, encoding.l, x.f, y.f)
  plutovg_canvas_clip_text.f(*canvas, *text, length.l, encoding.l, x.f, y.f)
  
  ;-Canvas text metrics functions
  plutovg_canvas_font_metrics(*canvas, *ascent.Float, *descent.Float, *line_gap.Float, *extents.plutovg_rect)
  plutovg_canvas_glyph_metrics(*canvas, codepoint.l, *advance_width.Float, *left_side_bearing.Float, *extents.plutovg_rect)
  plutovg_canvas_text_extents.f(*canvas, *text, length.l, encoding.l, *extents.plutovg_rect)
  
  
EndImport

CompilerIf #PB_Compiler_IsMainFile
  
  UsePNGImageDecoder()
    
  Procedure TestSVGtoPNG(svg.s,topng.s, width.f = -1, height.f = -1)
    Protected document.i
    Protected surface.i 
    
    document = plutosvg_document_load_from_file(svg, width, height)
    If document
      Debug "SVG loaded successfully"
      Debug "Width: " + StrF(plutosvg_document_get_width(document))
      Debug "Height: " + StrF(plutosvg_document_get_height(document))
      
      surface = plutosvg_document_render_to_surface(document,0, -1, -1, #Null, #Null, #Null);
      If surface 
        plutovg_surface_write_to_png(surface, topng) 
        plutovg_surface_destroy(surface)
        plutosvg_document_destroy(document)
        ProcedureReturn 1 
      Else 
        Debug "Failed to create surface" 
      EndIf 
      
    Else
      Debug "Failed to load SVG file: " + svg
    EndIf 
  EndProcedure
  
  Debug "PlutoSVG Version: " + PeekS(plutosvg_version_string(),-1,#PB_UTF8) 
  Debug "Version Code: " + Str(plutosvg_version())
  
  Global svg.s = GetPathPart(ProgramFilename()) + "camera.svg" 
  Global topng.s =  GetPathPart(ProgramFilename()) + "mycamera.png"
  
  If TestSVGtoPNG(svg.s,topng.s)
    
    cam = LoadImage(-1,topng)
    If cam  
      OpenWindow(0,0,0,ImageWidth(cam),ImageHeight(cam),"test") 
      ImageGadget(0,0,0,ImageWidth(cam),ImageHeight(cam),ImageID(cam)) 
      Repeat 
      Until WaitWindowEvent() = #PB_Event_CloseWindow 
    Else 
      MessageRequester("oops","cant find image")
    EndIf   
    
  EndIf 
  
CompilerEndIf