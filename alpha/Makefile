all: frifri-scad.svg frifri-scad.gcode

SLIC3R=--solid-infill-every-layers 1 --support-material

%.gcode: %.stl
	slic3r ${SLIC3R} $<

%.svg: %.stl
	slic3r ${SLIC3R} --export-svg $<

frifri-scad.stl: frifri.scad frifri.stl
	openscad -o $@ $<

clean:
	rm *.3ds *.mtl *.obj *.stl *.gcode *.svg
