
// Token.swift

class Token {

	let tag:Int

	init(withTag t:Int) {
		tag = t
	}

	func toString() -> String {
		return "\(tag)"
	}

}