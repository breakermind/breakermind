# Vue + Laravel

## Install packages
```sh
sudo apt install composer npm nodejs
```

## Install laravel
```sh
composer create-project laravel/laravel vue

cd vue

composer require laravel/ui

php artisan ui vue

npm install vue-loader@^15.9.7 --save-dev --legacy-peer-deps

# install dependencies
npm install

# webpack compile after js, css update
npm run dev

# run local www server
php artisan serv

# optional link storage (php)
php artisan storage:link
```

## Welcomepage
```html
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<meta name="csrf-token" content="{{ csrf_token() }}">

		<title>{{ config('app.name') }}</title>

		<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

		<style>
			body {font-family: 'Nunito', sans-serif;}
		</style>

		<!-- Import from public -->
		<link href="/css/app.css" rel="stylesheet">

		<!-- import vue scripts -->
		<script defer src="{{ mix('/js/app.js') }}"></script>
	</head>
	<body>
		<!-- <div class="card-body-resources"> Hello from Vue.js! </div> -->
		<div id="app">
			<example-component></example-component>
		</div>
	</body>
</html>
```

## Component
resources/js/components/ExampleComponent.vue
```html
<template>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<div class="card-header">Example Component</div>

					<div class="card-body">
						I'm an example component.
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		mounted() {
			console.log('Component mounted.')
		}
	}
</script>

/* Import from resources/css/app.css */
<style lang="css" scoped>
	@import "../../css/app.css";
</style>
```

## Webpack
webpack.mix.js
```js
const mix = require('laravel-mix');

mix.js('resources/js/app.js', 'public/js')
    .vue({ extractStyles: true })
    .sass('resources/sass/app.scss', 'public/css');

// mix.styles([
// 	'public/css/vendor/var.css',
// ], 'public/css/all.css');
```

### Remove bootstrap css
resources/sass/app.scss
```
// Fonts
@import url('https://fonts.googleapis.com/css?family=Nunito');

// Variables
@import 'variables';

// Bootstrap remove
// @import '~bootstrap/scss/bootstrap';
```

## Read
```
https://levelup.gitconnected.com/how-to-set-up-and-use-vue-in-your-laravel-8-app-2dd0f174e1f8
https://dev.to/wanjema/getting-started-with-laravel-and-vue-js-2hc6
https://laravel.com/docs/7.x/frontend
https://laravel.com/docs/7.x/mix
```
