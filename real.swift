
// Real.swift

class Real : Token {

	let value:Float

	// Além de uma tag, guarda um valor 
	// de ponto flutuante 
	init(withValue v:Float) {
		value = v 
		super.init(withTag: Tag.REAL)
	}

	override func toString() -> String {
		return "\(value)"
	}

}