mkdir lib/jar
curl "https://gitlab.com/glycoinfo/wurcsframework/-/package_files/73054558/download" -o "lib/jar/wurcsframework-1.2.13.jar"
curl "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.6/slf4j-api-2.0.6.jar" -o "lib/jar/slf4j-api-2.0.6.jar"
curl "https://gitlab.glyco.info/glycosmos/subsumption/subsumption/-/package_files/238/download" -o "lib/jar/subsumption-0.9.5.jar"
curl "https://gitlab.glyco.info/glycosmos/glytoucangroup/archetype/lib/-/package_files/334/download" -o "lib/jar/archetype-0.1.0.jar"