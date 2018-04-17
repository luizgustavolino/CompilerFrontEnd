
// Type.swift

class Type : Word {

	// Declarando os tipos primitivos
	static let `Int`   = Type(withLexeme: "int", tag: Tag.BASIC, width:4)
	static let `Float` = Type(withLexeme: "float", tag: Tag.BASIC, width:8)
	static let `Char`  = Type(withLexeme: "char", tag: Tag.BASIC, width:1)
	static let `Bool`  = Type(withLexeme: "bool", tag: Tag.BASIC, width:1)

	let width:Int

	init(withLexeme s:String, tag:Int, width w:Int) {
		width = w
		super.init(withLexeme: s, tag: tag)
	}

	// Função de apoio: verifica se é um tipo numérico
	static func numeric(_ p:Type) -> Bool{
		switch p.lexeme {
		case "char", "int", "float": return true
		default: return false
		}
	}

	// Função de apoio: encontra o tipo mais abrangente
	static func max(_ p1:Type, _ p2:Type) -> Type? {

		// para bool e int   -> null
		// para int[] e int  -> null
		if !Type.numeric(p1) || !Type.numeric(p2){
			return nil
		}

		// para float e int  -> float
		// para char e int   -> int
		// para char e float -> float 
		switch (p1.lexeme, p2.lexeme) {
			case ("float", _), (_, "float"): return Type.Float
			case ("int", _), (_, "int"): return Type.Int
			default: return Type.Char
		}

	}

}