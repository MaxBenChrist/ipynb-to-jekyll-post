import lxml.etree as et
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("file")
args = parser.parse_args()

print(args.file)
parser = et.XMLParser(resolve_entities=False)
tree = et.parse(args.file, parser)

for bad in tree.xpath("//[contains(@class,'prompt')]"):  
	bad.getparent().remove(bad)

print et.tostring(tree, pretty_print=True, xml_declaration=True)
