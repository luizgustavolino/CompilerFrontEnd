// Num.swift

class Num : Token {

	let value:Int

	init(withValue v:Int) {
		value = v
		super.init(withTag: Tag.NUM)
	}

	override func toString() -> String {
		return "\(value)"
	}

}