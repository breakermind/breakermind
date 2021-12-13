### Get from js fetch
```html
<meta name="csrf" content="{{ csrf_token() }}">

<script type="text/javascript">
	window.onload = () => {
		// Get token from meta tag
		let csrf = document.querySelector('meta[name=csrf]').content;
		console.log(csrf)

		data = {
			"name": "Webi",
			"email": "",
			"password": "",
		}

		fetch('/web/api/register', {
			method: 'POST',
			credentials: 'include', // include, *same-origin, omit
			headers: {
				'Content-Type': 'application/json',
				'X-Csrf-Token': '{{ csrf_token() }}'
				// 'Content-Type': 'application/json',
				// 'Content-Type': 'application/x-www-form-urlencoded',
			},
			body: JSON.stringify(data),
		})
		.then(response => response.json())
		.then(data => console.log(data));
	}
</script>
```

### Get data with axios
```html
<!-- Axios -->
<script defer src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script type="text/javascript">
	window.onload = () => {
		let csrf = document.querySelector('meta[name=csrf]').content;
		console.log(csrf)

		let data = {
			"name": "Webi",
			"email": "yo3@app.do",
			"password": "12345",
			"password_confirmation": "12345",
		}

		axios.defaults.withCredentials = true
				
		axios.get('/web/api/csrf').then(async () => {
			try {
				let r = await axios.post('/web/api/register', data)
				console.log(r)
			} catch(e) {
				console.log(e.response.data)
				console.log(e.response.status);
				console.log(e.response.headers);
			}
		})
	
		// Or just	
		axios.post('/web/api/register', data).then((r) => {
			console.log(r)
		}).catch((e) => {
			console.log(e.response.data)
		})
	}
</script>
```

### Exclude route from csrf protection
```php
<?php

namespace Webi\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;

class VerifyCsrfToken extends Middleware
{
	/**
	 * The URIs that should be excluded from CSRF verification.
	 *
	 * @var array
	 */
	protected $except = [
		// Disable csrf
		'/web/api/*'
	];
}
```
