
// Token.swift

class Token {

	let tag:Int

	init(withTag t:Int) {
		tag = t
	}

	init(withASCII str:String) {
		tag = str.unicodeScalarCodePoint
	}

	func toString() -> String {
		return tag.stringFromUnicodeScalarCodePoint
	}

}