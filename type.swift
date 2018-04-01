
// Type.swift

class Type : Word {

	static let `Bool` = Word(withLexeme: "bool", tag: Tag.BASIC)
	static let `Int` = Word(withLexeme: "int", tag: Tag.BASIC)
	static let `Float` = Word(withLexeme: "float", tag: Tag.BASIC)
	static let Char = Word(withLexeme: "char", tag: Tag.BASIC)

}