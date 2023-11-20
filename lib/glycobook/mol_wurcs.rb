require "java"

require_relative '../jar/cdk.jar'
require_relative '../jar/MolWURCS.jar'

java_import 'org.glycoinfo.MolWURCS.io.formats.ChemFormatType'
java_import 'org.openscience.cdk.exception.CDKException'
java_import 'org.openscience.cdk.interfaces.IAtomContainerSet'
java_import 'org.openscience.cdk.io.IChemObjectWriter'
java_import 'org.openscience.cdk.io.ISimpleChemObjectReader'
java_import 'org.openscience.cdk.silent.AtomContainerSet'
java_import 'java.io.StringReader'
java_import 'java.nio.file.Files'
java_import 'java.nio.file.Paths'
java_import 'java.io.IOException'
java_import 'java.lang.System'
java_import 'java.util.ArrayList'

module GlycoBook
class MolWURCS

def wurcs2mdlmol(w)

  begin
    reader = ChemFormatType::WURCS.createReader
    reader.setReader(StringReader.new(w))
    return unless reader.accepts(AtomContainerSet.java_class)
    mols = AtomContainerSet.new
    mols = reader.read(mols)
    reader.close
  rescue CDKException, IOException => e
    e.printStackTrace()
  end

  return if mols.nil?

  # write mol
  string_writer = java.io.StringWriter.new

  begin
    writer = org.openscience.cdk.io.SDFWriter.new(string_writer)
    if writer.accepts(mols.java_class)
      writer.write(mols)
    elsif writer.accepts(mols.get_atom_container(0).java_class)
      writer.write(mols.get_atom_container(0))
    end
    writer.close
  rescue Java::OrgOpenscienceCdkException::CDKException, Java::JavaIo::IOException => e
    e.printStackTrace()
  end

  return  string_writer.to_s
end

end
end