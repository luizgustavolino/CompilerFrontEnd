
// Lexer.swift

class Lexer {

	// Listagem de erros
	enum Errors : Error {
		case eof // fim do buffer de chars
	}

	static var line:Int = 1

	var programInput:[String] = []
	var peek:String = ""
	var words = [String:Word]()

	init() {

		// Reservando os comandos da linguagem
		reserve( Word(withLexeme: "if", tag: Tag.IF) )
		reserve( Word(withLexeme: "else", tag: Tag.ELSE) )
		reserve( Word(withLexeme: "while", tag: Tag.WHILE) )
		reserve( Word(withLexeme: "do", tag: Tag.DO) )
		reserve( Word(withLexeme: "break", tag: Tag.BREAK) )

		// Os lexemas foram definidos nestas
		// variáveis static em sua criação
		reserve( Word.True )
		reserve( Word.False )
		reserve( Type.Int )
		reserve( Type.Char )
		reserve( Type.Bool )
		reserve( Type.Float )

		// Converte para uma lista, ex: [" ", "{", " ", "i", "n", "t", ""]
		programInput = """
		{
			int i; int j; float v; float x; float[100] a;
			while( true ) {
				do i = i+1; while( a[i] < v);
				do j = j-1; while( a[j] > v); if( i >= j ) break;
				x = a[i]; a[i] = a[j]; a[j] = x;
			}
		}
		""".map{ String($0) } 

	}

	func reserve(_ w:Word){
		words[w.lexeme] = w
	}

	// Puxa o próximo char do buffer
	func readch() throws {
		
		if programInput.isEmpty {
			throw Errors.eof
		}
		
		print("lendo \(peek)")
		peek = programInput.removeFirst()

	}

	// Além de puxar o próximo char do buffer
	// compara com o desejado
	func readch(_ char:String) throws -> Bool {

		try readch()

		if peek != char {
			// char não confere com peek
			return false
		}else{
			// peek == "" marca que o programa
			// deve buscar o próximo char do buffer
			peek = ""
			return true
		}
	}

	func scan() throws -> Token {

		// Busca o próximo char que não
		// seja pula linha ou tab ou espaço
		var keepReading = true
		while (keepReading) {
			switch peek {
				case "", " ", "\t":
					try readch()
				case "\n":
					Lexer.line += 1
					try readch()
				default:
					keepReading = false
			}
		}

		// Analisa o peek, procura operadores
		switch peek {
			case "&": return try readch("&") ? Word.and : Token(withASCII: "&")
			case "|": return try readch("|") ? Word.or  : Token(withASCII: "|")
			case "=": return try readch("=") ? Word.eq  : Token(withASCII: "=")
			case "!": return try readch("=") ? Word.ne  : Token(withASCII: "!")
			case "<": return try readch("=") ? Word.le  : Token(withASCII: "<")
			case ">": return try readch("=") ? Word.ge  : Token(withASCII: ">")
			default : break
		}

		// Se não era um operador, tenta
		// encontrar um número
		if peek.isDigit {

			// exemplo, ler: 125
			// 1) 1
			// 2) 1 * 10 + 2   = 12
			// 3) 12 * 10 + 5  = 125 

			var v = 0

			repeat {
				v = 10*v + Int(peek)!
				try readch()
			} while (peek.isDigit)

			// Aqui o peek já não é digit 
			// se for '.' é um decimal
			// do contrário é um inteiro
			// e já pode retornar 
			if peek != "." {
				return Num(withValue:v)
			} 

			var keepRunning = true 
			var x = Float(v)
			var d = Float(10.0)

			// Processa as decimais
			repeat {

				// exemplo, ler: 1.23
				// 1) 1.0 + 2 / 10  = 1.2
				// 2) 1.2 + 3 / 100 = 1.23
				
				try readch()

				if !peek.isDigit {
					keepRunning = false
				}else{
					x = x + Float(Int(peek)!) / d
					d = d * 10
				}

			} while (keepRunning)

			// Termina o buffer de digit
			// criar e retorna um Real
			return Real(withValue:x)
		}

		// Se a linguagem aceitasse strings, poderia 
		// aqui ver se o o peek é aspas duplas e casar
		// com uma string até fechar outra aspas duplas

		// Se o peek é letter
		if peek.isLetter {

			// aceita: a1
			// isLetter / isLetterOrDigit
			// primeiro sempre letra
			
			var b = ""
			repeat {
				b += peek
				try readch()
			} while (peek.isLetterOrDigit)

			// Verifica se a Word já foi usada antes
			// ou se é preciso fazer uma nova
			if let word = words[b] {
				return word
			}else{
				let w = Word(withLexeme:b, tag: Tag.ID)
				words[b] = w
				return w
			}
		}


		// Se não é operador, digit ou letter:
		// então gera um Token ASCII
		let tok = Token(withASCII: peek)
		
		// Libera a leitura do próximo, quando
		// scan() for chamada
		peek = ""

		return tok
	}

}