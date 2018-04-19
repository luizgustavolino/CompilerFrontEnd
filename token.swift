
// Token.swift

class Token {

	let tag:Int

 	// Quando utilizando as constantes da
 	// classe Tag
	init(withTag t:Int) {
		tag = t
	}

	// Como strings são UTF-8 em swift
	// convertemos aqui para ASCII
	init(withASCII str:String) {
		tag = str.unicodeScalarCodePoint
	}

	func toString() -> String {
		return tag.stringFromUnicodeScalarCodePoint
	}

}


// Para adicionar em hashmap, implementamos 
// os protocolos necessário do swift
extension Token : Hashable, Equatable {
	var hashValue: Int {
		return tag
	}
}

// Quando comparando tokens, utilizamos 
// a tag para saber se são iguais
func ==(l:Token, r:Token) -> Bool{
    
    if let tl = l as? Type, let tr = r as? Type {
        return tl.tag == tr.tag
    }
    
    if let wl = l as? Word, let wr = r as? Word {
        return wl.lexeme == wr.lexeme
    }
    
	return l.tag == r.tag
}

