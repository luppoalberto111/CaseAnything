import Foundation

/// # 🐪 camelCase
/// converts a string to camelCase
/// - first lowercase then all capitalised
/// - *strips away* special characters by default
///
/// @example
///   camelCase("$catDog") == "catDog"
/// @example
///   camelCase("$catDog", keepSpecialCharacters: true) == "$catDog"
public func camelCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "", keep: keep)
		.enumerated().reduce("") { result, part in
			let (index, word) = part
			if index == 0 {
				return result + word.lowercased()
			}
			if magicSplit().firstMatch(in: firstCharacter(word), range: NSRange(location: 0, length: firstCharacter(word).utf16.count)) == nil {
				return result + word.lowercased()
			}
			return result + capitaliseWord(word)
		}
}

/// # 🐫 PascalCase
/// converts a string to PascalCase (also called UpperCamelCase)
/// - all capitalised
/// - *strips away* special characters by default
///
/// @example
///   pascalCase("$catDog") == "CatDog"
/// @example
///   pascalCase("$catDog", keepSpecialCharacters: true) == "$CatDog"
public func pascalCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "", keep: keep)
		.reduce("") { result, word in
			result + capitaliseWord(word)
		}
}

/// # 🐫 UpperCamelCase
/// converts a string to UpperCamelCase (also called PascalCase)
/// - all capitalised
/// - *strips away* special characters by default
///
/// @example
///   upperCamelCase("$catDog") == "CatDog"
/// @example
///   upperCamelCase("$catDog", keepSpecialCharacters: true) == "$CatDog"
public let upperCamelCase = pascalCase

/// # 🥙 kebab-case
/// converts a string to kebab-case
/// - hyphenated lowercase
/// - *strips away* special characters by default
///
/// @example
///   kebabCase("$catDog") == "cat-dog"
/// @example
///   kebabCase("$catDog", keepSpecialCharacters: true) == "$cat-dog"
public func kebabCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "-", keep: keep)
		.joined()
		.lowercased()
}

/// # 🐍 snake_case
/// converts a string to snake_case
/// - underscored lowercase
/// - *strips away* special characters by default
///
/// @example
///   snakeCase("$catDog") == "cat_dog"
/// @example
///   snakeCase("$catDog", keepSpecialCharacters: true) == "$cat_dog"
public func snakeCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "_", keep: keep)
		.joined()
		.lowercased()
}

/// # 📣 CONSTANT_CASE
/// converts a string to CONSTANT_CASE
/// - underscored uppercase
/// - *strips away* special characters by default
///
/// @example
///   constantCase("$catDog") == "CAT_DOG"
/// @example
///   constantCase("$catDog", keepSpecialCharacters: true) == "$CAT_DOG"
public func constantCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "_", keep: keep)
		.joined()
		.uppercased()
}

/// # 🚂 Train-Case
/// converts strings to Train-Case
/// - hyphenated & capitalised
/// - *strips away* special characters by default
///
/// @example
///   trainCase("$catDog") == "Cat-Dog"
/// @example
///   trainCase("$catDog", keepSpecialCharacters: true) == "$Cat-Dog"
public func trainCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "-", keep: keep)
		.map { word in capitaliseWord(word) }
		.joined()
}

/// # 🕊 Ada_Case
/// converts a string to Ada_Case
/// - underscored & capitalised
/// - *strips away* special characters by default
///
/// @example
///   adaCase("$catDog") == "Cat_Dog"
/// @example
///   adaCase("$catDog", keepSpecialCharacters: true) == "$Cat_Dog"
public func adaCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "_", keep: keep)
		.map { word in capitaliseWord(word) }
		.joined()
}

/// # 👔 COBOL-CASE
/// converts a string to COBOL-CASE
/// - hyphenated uppercase
/// - *strips away* special characters by default
///
/// @example
///   cobolCase("$catDog") == "CAT-DOG"
/// @example
///   cobolCase("$catDog", keepSpecialCharacters: true) == "$CAT-DOG"
public func cobolCase(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "-", keep: keep)
		.joined()
		.uppercased()
}

/// # 📍 Dot.notation
/// converts a string to dot.notation
/// - adds dots, does not change casing
/// - *strips away* special characters by default
///
/// @example
///   dotNotation("$catDog") == "cat.Dog"
/// @example
///   dotNotation("$catDog", keepSpecialCharacters: true) == "$cat.Dog"
public func dotNotation(_ string: String, keepSpecialCharacters: Bool = false, keep: [String] = []) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: ".", keep: keep).joined()
}

/// # 📂 Path/case
/// converts a string to path/case
/// - adds slashes, does not change casing
/// - *keeps* special characters by default
///
/// @example
///   pathCase("$catDog") == "$cat/Dog"
/// @example
///   pathCase("$catDog", keepSpecialCharacters: false) == "cat/Dog"
public func pathCase(
	_ string: String,
	keepSpecialCharacters: Bool = true, keep: [String] = []
) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: "", keep: keep)
		.enumerated().reduce("") { result, part in
			let (index, word) = part
			let prefix = (index == 0 || word.first == "/") ? "" : "/"
			return result + prefix + word
		}
}

/// # 🛰 Space case
/// converts a string to space case
/// - adds spaces, does not change casing
/// - *keeps* special characters by default
///
/// @example
///   spaceCase("$catDog") == "$cat Dog"
/// @example
///   spaceCase("$catDog", keepSpecialCharacters: false) == "cat Dog"
public func spaceCase(
	_ string: String,
	keepSpecialCharacters: Bool = true, keep: [String] = []
) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: " ", keep: keep).joined()
}

/// # 🏛 Capital Case
/// converts a string to Capital Case
/// - capitalizes words and adds spaces
/// - *keeps* special characters by default
///
/// @example
///   capitalCase("$catDog") == "$Cat Dog"
/// @example
///   capitalCase("$catDog", keepSpecialCharacters: false) == "Cat Dog"
///
/// ⟪ if you do not want to add spaces, use `pascalCase()` ⟫
public func capitalCase(
	_ string: String,
	keepSpecialCharacters: Bool = true, keep: [String] = []
) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: " ", keep: keep)
		.reduce("") { result, word in result + capitaliseWord(word) }
}

/// # 🔡 lower case
/// converts a string to lower case
/// - makes words lowercase and adds spaces
/// - *keeps* special characters by default
///
/// @example
///   lowerCase("$catDog") == "$cat dog"
/// @example
///   lowerCase("$catDog", keepSpecialCharacters: false) == "cat dog"
///
/// ⟪ if you do not want to add spaces, use the native JS `toLowerCase()` ⟫
public func lowerCase(
	_ string: String,
	keepSpecialCharacters: Bool = true, keep: [String] = []
) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: " ", keep: keep)
		.joined()
		.lowercased()
}

/// # 🔠 UPPER CASE
/// converts a string to UPPER CASE
/// - makes words upper case and adds spaces
/// - *keeps* special characters by default
///
/// @example
///   upperCase("$catDog") == "$CAT DOG"
/// @example
///   upperCase("$catDog", keepSpecialCharacters: false) == "CAT DOG"
///
/// ⟪ if you do not want to add spaces, use the native JS `toUpperCase()` ⟫
public func upperCase(
	_ string: String,
	keepSpecialCharacters: Bool = true, keep: [String] = []
) -> String {
	return splitAndPrefix(string, keepSpecialCharacters: keepSpecialCharacters, prefix: " ", keep: keep)
		.joined()
		.uppercased()
}
