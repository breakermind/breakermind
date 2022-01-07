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
					// "foreground": "#648f00",
					// "fontStyle": "bold"
				}
			},
			{
				// Class object methods color
				"scope": [
					"meta.method-call.php entity.name.function.php",
				],
				"settings": {
					"foreground": "#f169a9",
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
					// "fontStyle": "italic",
					// "foreground": "#bfc9d6",
				}
			},			
			{
				// Php class: Request $req, Route::
				"scope": [
					"support.class.php",
				],
				"settings": {
					"foreground": "#e4c282",
					// "fontStyle": "bold"
				}
			},			
			{
				// Namespace and Use keywords
				"scope": [
					"keyword.other.namespace.php",
					"keyword.other.use.php",
				],
				"settings": {
					// "foreground": "#469092",
					// "fontStyle": "bold"
				}
			},			
			{
				// Namespace ClassName
				"scope": [
					"source.php meta.use support.class.php",
				],
				"settings": {
					"foreground": "#ffcb6b",
					"fontStyle": "bold"
				}
			}
		],
	}
}
```
