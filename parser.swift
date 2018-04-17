
// Parser.swift

class Parser {

	enum ParserError : Error {
		case lineError
	}

	let lexer:Lexer 	// analisador léxico
	var look:Token?  	// look ahead
	var top:Env? = nil 	// tabela de simbolos atual 
	var used = 0  		// memória usada pera declarações

	init(withLexer l:Lexer) {
		lexer = l
		move()
	}

	func move() {
		look = try? lexer.scan()
	}

	func error(_ s:String) throws {
		print("Error near line \(Lexer.line): \(s)")
		throw ParserError.lineError
	}

	func match(_ t:Int) throws {
		if look?.tag == t {
			move()
		}else{
			try error("syntax error, expecting \(t.stringFromUnicodeScalarCodePoint) but found \((look?.tag ?? 0).stringFromUnicodeScalarCodePoint)")
		}
	}

	func match(_ t:String) throws {
		try match(t.unicodeScalarCodePoint)
	}

	func program() throws {

		let s = try block()

		let begin = s.newlabel()
		let after = s.newlabel()

		s.emitlabel(begin)
		s.gen(begin, after)
		s.emitlabel(after)
	}

	func block() throws -> Stmt{

		try match("{")
		let savedEnv = top
		top = Env(withPrev: top)

		try decls()
		let s = try stmts()
		
		try match("}")
		top = savedEnv

		return s
	}

	func decls() throws {
		while look?.tag == Tag.BASIC {

			let p = try type()
			guard let tok = look as? Word else{
				fatalError("tok = look as? Word")
			}

			try match(Tag.ID)
			try match(";")

			let id = Id(withID:tok, type:p, offset:used)
			top?.put(tok, id)
			used = used + p.width
		}
	}

	func type() throws -> Type {
		
		let p = look! as! Type
		try match(Tag.BASIC)

		if look?.tag != "[".unicodeScalarCodePoint {
			return p
		} else {
			return try dims(p)
		}
	}

	func dims(_ p:Type) throws -> Type {

		var pp = p

		try match("[")
		let tok = look as! Num
		try match(Tag.NUM)
		try match("]")

		if look?.tag == "[".unicodeScalarCodePoint {
			pp = try dims(p)
		}

		return Arrayy(withSize: tok.value, type: pp)
	}

	func stmts() throws -> Stmt{
		
	}

	func stmt() throws -> Stmt {
		
	}
}
