require 'java'

require_relative 'jar/glycanbuilder2.jar'
require_relative 'jar/wurcsframework.jar'
require_relative 'jar/slf4j-api.jar'
require_relative "jar/batik-all.jar"

java_import 'java.io.ByteArrayOutputStream'
java_import 'java.util.Base64'
java_import 'javax.imageio.ImageIO'
java_import 'org.eurocarbdb.application.glycanbuilder.BuilderWorkspace'
java_import 'org.eurocarbdb.application.glycanbuilder.massutil.MassOptions'
java_import 'org.eurocarbdb.application.glycanbuilder.renderutil.GlycanRendererAWT'
java_import 'org.eurocarbdb.application.glycanbuilder.util.GraphicOptions'
java_import 'org.glycoinfo.application.glycanbuilder.converterWURCS2.WURCS2Parser'

java_import 'org.eurocarbdb.application.glycanbuilder.renderutil.SVGUtils'

java_import 'java.util.LinkedList'

module GlycanBuilder
    
  def self.generatePng(w)
    naki = "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"        

      workspace = BuilderWorkspace.new(GlycanRendererAWT.new)
  workspace.initData()
  workspace.setNotation(GraphicOptions::NOTATION_SNFG)
  parser= WURCS2Parser.new
  begin
    glycan = parser.readGlycan(w, MassOptions.new)
    image = workspace.getGlycanRenderer().getImage(glycan, true, false, true)
    stream = ByteArrayOutputStream.new
    ImageIO.write(image, "png", stream)
    base = Base64.getEncoder().encodeToString(stream.toByteArray())
    return base
    #return "<img src=\"data:image/png;base64,#{base}\">"
  rescue Exception, StackOverflowError => e
    return naki
  end

  end

  def self.generateSvg(wurcs)
    workspace = BuilderWorkspace.new(GlycanRendererAWT.new)
    workspace.init_data
    workspace.set_notation(GraphicOptions::NOTATION_SNFG)

    begin
      glycan = WURCS2Parser.new.read_glycan(wurcs, MassOptions.new)
      glycans = LinkedList.new
      glycans.add(glycan)

      SVGUtils.get_vector_graphics(workspace.get_glycan_renderer, glycans, false, true)
    rescue Exception, StackOverflowError => e
      return "<pre>#{e.to_s}</pre>"
    end
  end



  def self.showImage(w,format)
    if format == "png"
    base = self.generatePng(w)
    IRuby.html "<img src=\"data:image/png;base64,#{base}\">"
    elsif format == "svg"
    IRuby.html "<img src=\"data:image/svg;#{self.generateSvg(w)}\">"
    else
      IRuby.html "#{format} is not supported"  
    end
  end
end
