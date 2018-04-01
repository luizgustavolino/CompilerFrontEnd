
// Real.swift

class Real : Token {

	let value:Float

	init(withValue v:Float) {
		value = v 
		super.init(withTag: Tag.REAL)
	}

	override func toString() -> String {
		return "\(value)"
	}

}