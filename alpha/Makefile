all: frifri-scad.gcode

SLIC3R=--load ~/Desktop/Slic3r-PLA_07-26.ini --solid-infill-every-layers 1 --support-material

%.gcode: %.stl
	slic3r ${SLIC3R} -o $@ $<

%.svg: %.stl
	slic3r ${SLIC3R} --export-svg $<

frifri-scad.stl: frifri.scad frifri.stl
	openscad -o $@ $<

frifri-enveloppe.stl: frifri-enveloppe.scad
	openscad --render -o tmp-$@ $<
	# Cleanup the .STL file or Wings3D import.
	admesh -a $@ tmp-$@
	rm tmp-$@

clean:
	rm *.3ds *.mtl *.obj *.stl *.gcode *.svg
