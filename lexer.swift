
// Lexer.swift

class Lexer {

	static var line:Int = 1
	var peek:String = ""
	var words = [String:Word]()

	init() {
		reserve( Word(withLexeme: "if", tag: Tag.IF) )
		reserve( Word(withLexeme: "else", tag: Tag.ELSE) )
		reserve( Word(withLexeme: "while", tag: Tag.WHILE) )
		reserve( Word(withLexeme: "do", tag: Tag.DO) )
		reserve( Word(withLexeme: "break", tag: Tag.BREAK) )

		reserve( Word.True )
		reserve( Word.False )
		reserve( Type.Int )
		reserve( Type.Char )
		reserve( Type.Bool )
		reserve( Type.Float )
	}

	func reserve(_ w:Word){
		words[w.lexeme] = w
	}

}