
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

extension Token : Hashable, Equatable {
	var hashValue: Int {
		return tag
	}
}

func ==(l:Token, r:Token) -> Bool{
	return l.tag == r.tag
}

