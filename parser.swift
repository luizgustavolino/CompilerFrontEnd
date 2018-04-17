
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

	func ahead(_ s:String) -> Bool {
		return look?.tag == s.unicodeScalarCodePoint
	}

	func ahead(_ i:Int) -> Bool {
		return look?.tag == i
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

		if !ahead("[") {
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

		if ahead("[") {
			pp = try dims(p)
		}

		return Arrayy(withSize: tok.value, type: pp)
	}

	func stmts() throws -> Stmt {
		if ahead("}") {
			return Stmt.null
		} else {
			return try Seq(stmt(), stmts())
		}
	}

	func stmt() throws -> Stmt {
		
		let x:Expr?
		let s:Stmt?
		let s1:Stmt?
		let s2:Stmt?
		let savedStmt:Stmt?

		guard let look = look else{
			fatalError()
		}

		switch (look.tag, look.tag.stringFromUnicodeScalarCodePoint ) {
			case (_, ";"):
				move()
				return Stmt.null
			case (Tag.IF, _):

				try match(Tag.IF);
				try match("(");
				x = try bool();
				try match(")")

				s1 = try stmt()
				if !ahead(Tag.ELSE){
					return try If(x!, s1!)
				}

				try match(Tag.ELSE)
				s2 = try stmt()
				return try Else(x!, s1!, s2!)

			default:
				return Stmt.null
		}
	}

	func assign() throws -> Stmt {

		let stmt:Stmt?
		let t = look!

		try match(Tag.ID)

		guard let id = top.get(t) else{
			error(t.toString() + " undeclared!")
		}

		if ahead("=") {
			move()
			stmt = Set(id, bool())
		}else{
			let x = offset(id)
			try match("=")
			stmt = SetElem(x, try bool())
		}

		match(";")
		return stmt!
	}

	func bool() throws -> Expr {

		var x = try join()
		
		while ahead(Tag.OR) {
			let tok = look
			move()
			x = Or(withToken: tok!, x, try join())
		}

		return x
	}

	func join() throws -> Expr {

		var x = try equality()

		while ahead(Tag.AND) {
			let tok = look
			move()
			x = And(withToken: tok!, x, try equality())
		}

		return x
	}

	func equality() throws -> Expr {

		var x = try rel()

		while ahead(Tag.EQ) || ahead(Tag.NE) {
			let tok = look
			move()
			x = Rel(withToken: tok!, x, try rel())
		}

		return x
	}

	func rel()  throws -> Expr {

		let x = try expr()
		
		guard let look = look else {
			fatalError("look is missing")
		}

		switch (look.tag, look.tag.stringFromUnicodeScalarCodePoint ) {
		case (_, "<"), (Tag.LE, _), (Tag.GE, _), (_, ">"):
			let tok = look
			move()
			return Rel(withToken: tok, x, try expr())			
		default:
			return x
		}
	}

	func expr() throws -> Expr {

		var x = try term()

		while ahead("+") || ahead("-") {
			let tok = look
			move()
			x = Arith(withToken: tok!, x, try term())
		}

		return x
	}

	func term() throws -> Expr {

		var x = try unary()

		while ahead("*") || ahead("/") {
			let tok = look
			move()
			x = Arith(withToken: tok!, x, try unary())
		}
		
		return x
	}

	func unary() throws -> Expr {

		if ahead("-") {
			move()
			return Unary(withToken: Word.minus, try unary())
		} else if ahead("!") {
			let tok = look
			move()
			return Not(withToken: tok!, try unary())
		}

		return try factor()
	}

	func factor() throws -> Expr{
		let x:Expr? = nil
		switch (look.tag, look.tag.stringFromUnicodeScalarCodePoint ) {
			case "(":
				move()
				x = try bool()
				try match(")")
				return x
			default:
				return Expr.null
		}
	}

}

