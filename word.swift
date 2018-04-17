
// Word.swift

class Word : Token {

	static let and 		= Word(withLexeme: "&&", tag: Tag.AND)
	static let or 		= Word(withLexeme: "||", tag: Tag.OR)
	static let eq 		= Word(withLexeme: "==", tag: Tag.EQ)
	static let ne 		= Word(withLexeme: "!=", tag: Tag.NE)
	static let le 		= Word(withLexeme: "<=", tag: Tag.LE)
	static let ge 		= Word(withLexeme: ">=", tag: Tag.GE)

	static let True 	= Word(withLexeme: "true", tag: Tag.TRUE)
	static let False 	= Word(withLexeme: "false", tag: Tag.FALSE)

	// Utilizado internamente para armazenar valores temporários,
	// por ex: 3 + 4 + 2 , ondex temp = 3 + 4 / resultado = temp + 2
	static let temp 	= Word(withLexeme: "t", tag: Tag.TEMP)

	// Minus é o sinal de menos num número negativo
	static let minus 	= Word(withLexeme: "minus", tag: Tag.MINUS)
	
	let lexeme:String

	// Além de tag, armazena uma string lexema 
	init(withLexeme s:String, tag:Int) {
		lexeme = s
		super.init(withTag: tag)
	}

	override func toString() -> String {
		return lexeme
	}

}

