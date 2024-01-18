import 'package:xml/xml.dart';


Future<void> main() async {
  XmlDocument metaXml = XmlDocument.parse('''
<?xpacket begin="" id="W5M0MpCehiHzreSzNTczkc9d"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

</rdf:RDF>
<?xpacket end="r"?>
''');

  // $s .= $this->_getxmpdescription('pdf', 'http://ns.adobe.com/pdf/1.3/', $pdf);
  // $s .= $this->_getxmpdescription('xmp', 'http://ns.adobe.com/xap/1.0/', $xmp);
  // if($dc)
  // $s .= $this->_getxmpdescription('dc', 'http://purl.org/dc/elements/1.1/', $dc);
  // $s .= $this->_getxmpdescription('pdfaid', 'http://www.aiim.org/pdfa/ns/id/', $pdfaid);
  // $s .= '</rdf:RDF>'."\n";
  // $s .= '<?xpacket end="r"?>';

  print(metaXml);
}

