
// Main.swift

class Main {

	static func main(_ args:[String] = []) {
		let lexer = Lexer()
		let parser = Parser(withLexer: lexer)
		parser.program()
	}
}

Main.main()