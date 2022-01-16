<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;

class Handler extends ExceptionHandler
{
	/**
	 * A list of the exception types that are not reported.
	 *
	 * @var array<int, class-string<Throwable>>
	 */
	protected $dontReport = [
		// InvalidOrderException::class,
	];

	/**
	 * A list of the inputs that are never flashed for validation exceptions.
	 *
	 * @var array<int, string>
	 */
	protected $dontFlash = [
		'current_password',
		'password',
		'password_confirmation',
	];

	/**
	 * Register the exception handling callbacks for the application.
	 *
	 * @return void
	 */
	public function register()
	{
		$this->renderable(function (Throwable $e, $request) {
			// Json response
			if (
				$request->is('web/*') ||
				$request->is('api/*') ||
				$request->wantsJson()
			) {
				return response()->json([
					'message' => 'Some api errors occurred.',
					'ex' => [
						'message' => empty($e->getMessage()) ? 'Not Found.' : $e->getMessage(),
						'code' => empty($e->getCode()) ? 404 : $e->getCode(),
						'name' => $this->getClassName(get_class($e)),
						'namespace' => get_class($e),
					]
				], 404);
			}
		});

		$this->reportable(function (Throwable $e) {
			// Stop logging to lavavel logs
			return false;
		});
	}

	/**
	 * Get exception class name without namespace.
	 *
	 * @return string
	 */
	static function getClassName($e) {
		$path = explode('\\', $e);
		return array_pop($path);
	}
}
