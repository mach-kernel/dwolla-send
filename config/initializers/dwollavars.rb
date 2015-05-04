require 'dwolla'

module DwollaVars
	mattr_reader  :Dwolla, :pin

	@@Dwolla ||= Dwolla
	
	@@Dwolla::api_key ||= "bXTSJDHveBHltmu95EM7a6gt6zdRmPJnQgJP774ev+Bc02sEnf"
	@@Dwolla::api_secret ||= "v0OG0MCM9eEHeNuC/QAQ89B6s2VcwyjEHgJuBd0e6Lp2sUyIkU"

	@@Dwolla::token ||= "q58Z92xpws58yKn9iWW77sOnsSGL3QDIOCo1c4zLtrOxxuCoZW"
	@@pin ||= 1337

	@@Dwolla::sandbox ||= true
end
