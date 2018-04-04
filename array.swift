
// Array.swift

class Arrayy : Type {
	
	let of:Type
	let size:Int

	init(withSize s:Int, type p:Type) {
		size = s
		of = p
		super.init(withLexeme: "[]", tag: Tag.INDEX, width: s*p.width)
	}

	override func toString() -> String {
		return "[\(size)] + \(of.toString)"
	}
}