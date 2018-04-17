
// Main.swift

class Main {

	// Cria um lexer e usa ele no Parser
	// Parser em program pede tokens pro lexer
	// enquanto monta a árvore sintática
	static func main(_ args:[String] = []) {
		let lexer = Lexer()
		let parser = Parser(withLexer: lexer)
		try? parser.program()
	}
}

Main.main()