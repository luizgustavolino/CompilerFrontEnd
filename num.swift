
// Num.swift

class Num : Token {

	let value:Int

	// Além da tag, guarda o valor numérico
	init(withValue v:Int) {
		value = v
		super.init(withTag: Tag.NUM)
	}

	override func toString() -> String {
		return "\(value)"
	}

}