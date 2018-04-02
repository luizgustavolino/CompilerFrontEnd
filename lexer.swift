
// Lexer.swift

class Lexer {

	static var line:Int = 1

	var programInput:[String] = []
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

		// testes
		programInput = " 6.9 foo bar ".map { String($0) }
		print(scan().toString())
		print(scan().toString())
		print(scan().toString())

	}

	func reserve(_ w:Word){
		words[w.lexeme] = w
	}

	func readch() {
		peek = programInput.removeFirst()
	}

	func readch(_ char:String) -> Bool {

		readch()

		if peek != char {
			return false
		}else{
			peek = ""
			return true
		}
	}

	func scan() -> Token {

		var keepReading = true
		while (keepReading) {
			readch()
			switch peek {
				case "", " ", "\t": continue
				case "\n": Lexer.line += 1
				default: keepReading = false
			}
		}

		switch peek {
			case "&": return readch("&") ? Word.and : Token(withASCII: "&")
			case "|": return readch("|") ? Word.or : Token(withASCII: "|")
			case "=": return readch("=") ? Word.eq : Token(withASCII: "=")
			case "!": return readch("=") ? Word.ne : Token(withASCII: "!")
			case "<": return readch("=") ? Word.le : Token(withASCII: "<")
			case ">": return readch("=") ? Word.ge : Token(withASCII: ">")
			default : break
		}

		if peek.isDigit {

			var v = 0

			repeat {
				v = 10*v + Int(peek)!
				readch()
			} while (peek.isDigit)

			if peek != "." {
				return Num(withValue:v)
			} 

			var keepRunning = true 
			var x = Float(v)
			var d = Float(10.0)

			repeat {
				
				readch()

				if !peek.isDigit {
					keepRunning = false
				}else{
					x = x + Float(Int(peek)!) / d
					d = d * 10
				}

			} while (keepRunning)

			return Real(withValue:x)
		}

		if peek.isLetter {
			
			var b = ""
			repeat {
				b += peek
				readch()
			} while (peek.isLetterOrDigit)

			if let word = words[b] {
				return word
			}else{
				let w = Word(withLexeme:b, tag: Tag.ID)
				words[b] = w
				return w
			}
		}

		let tok = Token(withASCII: peek)
		peek = ""
		return tok
	}

}