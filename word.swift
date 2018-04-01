
// Word.swift

class Word : Token {

	static let and 		= Word(withLexeme: "&&", tag: Tag.AND)
	static let or 		= Word(withLexeme: "||", tag: Tag.OR)
	static let eq 		= Word(withLexeme: "==", tag: Tag.EQ)
	static let ne 		= Word(withLexeme: "!=", tag: Tag.NE)
	static let le 		= Word(withLexeme: "<=", tag: Tag.LE)
	static let ge 		= Word(withLexeme: ">=", tag: Tag.GE)
	static let minus 	= Word(withLexeme: "minus", tag: Tag.MINUS)
	static let True 	= Word(withLexeme: "true", tag: Tag.TRUE)
	static let False 	= Word(withLexeme: "false", tag: Tag.FALSE)
	
	let lexeme:String

	init(withLexeme s:String, tag:Int) {
		lexeme = s
		super.init(withTag: tag)
	}

	override func toString() -> String {
		return lexeme
	}

}

