# Kolory skórek vscode

- Naciśnij: ctrl+k ctrl+s
- Wyszukaj: editor.action.inspectTMScopes
- Dodaj skrót klawiszy: shift+ctrl+alt+I
- Naciśnij: shift+ctrl+alt+I nad metodą klasy w edytorze i zobacz dostępne atrybuty "scopes"

### Zmiana ustawień
.vscode/settings.json
```json
{
	"editor.tokenColorCustomizations" : {
		// "numbers": "#d7eb22",
		// "comments": "#677ea8",
		// "functions": "#ff3300",
		"textMateRules": [
			{
				// Class definition methods color
				"scope":"entity.name.function",
				"settings": {
					"foreground": "#98d900",
					// "fontStyle": "bold"
				}
			},
			{
				// Class object methods color
				"scope": [
					"meta.method-call.php entity.name.function.php",
				],
				"settings": {
					"foreground": "#e36209",
					// "fontStyle": "bold",
				}
			},
			{
				// Comments
				"scope": [
					"comment",
					"comment.block",
					"punctuation.definition.comment",
					"punctuation.definition.comment.end",
					"punctuation.definition.comment.begin",
					"punctuation.definition.comment.begin.documentation",
					"punctuation.definition.comment.end.documentation",
					"comment.block.documentation"
				],
				"settings": {
					"fontStyle": "italic",
					"foreground": "#00339955",
				}
			}
		],
	}
}
```
