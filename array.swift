
// Array.swift

class Arrayy : Type {
	
	// 'of' é o tipo dos elementos
	// 'size' é o tamanho do vetor 
	let of:Type
	let size:Int

	// exemplo:
	//  int[100] a;
	// no lexer:
	//  BASIC(int) WORD([) NUM(100) WORD(]) ID(a) WORD(;)
	init(withSize s:Int, type p:Type) {
		size = s
		of = p
		super.init(withLexeme: "[]", tag: Tag.INDEX, width: s*p.width)
	}

	override func toString() -> String {
		return "[\(size)] + \(of.toString)"
	}
}