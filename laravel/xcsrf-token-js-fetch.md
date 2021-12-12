### Get Csrf/Xsrf token from js fetch
```html
<script type="text/javascript">
	var xsrfToken = null

	function getCookie(name) {
		if (!document.cookie) {
			return null;
		}

		const xsrfCookies = document.cookie.split(';')
			.map(c => c.trim())
			.filter(c => c.startsWith(name + '='))

		if (xsrfCookies.length === 0) {
			return null
		}
		return decodeURIComponent(xsrfCookies[0].split('=')[1])
	}

	window.onload = () => {

		fetch('/web/api/csrf', {
			method: 'GET',
			credentials: 'include',
		})
		.then(response => response.json())
		.then(data => {
			console.log(data)
		});

		xsrfToken = getCookie('XSRF-TOKEN');

		data = {
			"name": "Webi",
			// "email": "",
			// "password": "",
		}

		fetch('/web/api/register', {
			method: 'POST',
			credentials: 'include', // include, *same-origin, omit
			headers: {
				'Content-Type': 'application/json',
				'X-Xsrf-Token': xsrfToken,
				// 'X-Csrf-Token': '{{ csrf_token() }}'
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
