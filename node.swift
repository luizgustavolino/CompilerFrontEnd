
// Node.swift

class Node {

	// A linha que lexer estava quando
	// consumiu o(s) token(s) que gerou este nó
	let lexline:Int

	// Incrementador para gerar labels únicas
	static var labels = 0

	init(){
		lexline = Lexer.line
	}

	// Erro primitivo: generic
	enum Errors : Error {
		case generic 
	} 

	// Função de apoio para interromper 
	// o parser e subir um erro
	func error(_ s:String) throws {
		throw Errors.generic
	}

	// Gera um label novo, único para
	// possibilitar demarcações nas 
	// construções 
	func newlabel() -> Int {
		Node.labels += 1
		return Node.labels
	}

	// Imprime um label no código intermediário
	func emitlabel(_ i:Int) {
		print("L\(i):")
	}

	// Imprime no código intermediário
	// Utilizado pelas subclasses 
	func emit(_ s:String) {
		print("\t\(s)")
	}

}