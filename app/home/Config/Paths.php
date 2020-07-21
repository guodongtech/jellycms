<?php namespace config;
use \Config;
/**
 * Holds the paths that are used by the system to
 * locate the main directories, app, system, etc.
 * Modifying these allows you to re-structure your application,
 * share a system folder between multiple applications, and more.
 *
 * All paths are relative to the project's root folder.
 */

class Paths
{
	/*
	 *---------------------------------------------------------------
	 * SYSTEM FOLDER NAME
	 *---------------------------------------------------------------
	 *
	 * This variable must contain the name of your "system" folder.
	 * Include the path if the folder is not in the same directory
	 * as this file.
	 */
	public $systemDirectory = __DIR__ . '/../../../system';

	/*
	 *---------------------------------------------------------------
	 * APPLICATION FOLDER NAME
	 *---------------------------------------------------------------
	 *
	 * If you want this front controller to use a different "app"
	 * folder than the default one you can set its name here. The folder
	 * can also be renamed or relocated anywhere on your getServer. If
	 * you do, use a full getServer path. For more info please see the user guide:
	 * http://codeigniter.com/user_guide/general/managing_apps.html
	 *
	 * NO TRAILING SLASH!
	 */
	public $appDirectory = __DIR__ . '/..';

	/*
	 * ---------------------------------------------------------------
	 * WRITABLE DIRECTORY NAME
	 * ---------------------------------------------------------------
	 *
	 * This variable must contain the name of your "writable" directory.
	 * The writable directory allows you to group all directories that
	 * need write permission to a single place that can be tucked away
	 * for maximum security, keeping it out of the app and/or
	 * system directories.
	 */
	public $writableDirectory = __DIR__ . '/../../../runtime';

	/*
	 * ---------------------------------------------------------------
	 * TESTS DIRECTORY NAME
	 * ---------------------------------------------------------------
	 *
	 * This variable must contain the name of your "tests" directory.
	 */
	public $testsDirectory = __DIR__ . '/../../tests';

	/*
	 * ---------------------------------------------------------------
	 * VIEW DIRECTORY NAME
	 * ---------------------------------------------------------------
	 *
	 * This variable must contain the name of the directory that
	 * contains the view files used by your application. By
	 * default this is in `app/Views`. This value
	 * is used when no value is provided to `Services::renderer()`.
	 */
	public $viewDirectory = __DIR__ . '/../../../template/';
	public $mobiles = [
		// legacy array, old values commented out
		'mobileexplorer'       => 'Mobile Explorer',
		// 'openwave'             => 'Open Wave',
		// 'opera mini'           => 'Opera Mini',
		// 'operamini'            => 'Opera Mini',
		// 'elaine'               => 'Palm',
		'palmsource'           => 'Palm',
		// 'digital paths'        => 'Palm',
		// 'avantgo'              => 'Avantgo',
		// 'xiino'                => 'Xiino',
		'palmscape'            => 'Palmscape',
		// 'nokia'                => 'Nokia',
		// 'ericsson'             => 'Ericsson',
		// 'blackberry'           => 'BlackBerry',
		// 'motorola'             => 'Motorola'

		// Phones and Manufacturers
		'motorola'             => 'Motorola',
		'nokia'                => 'Nokia',
		'palm'                 => 'Palm',
		'iphone'               => 'Apple iPhone',
		'ipad'                 => 'iPad',
		'ipod'                 => 'Apple iPod Touch',
		'sony'                 => 'Sony Ericsson',
		'ericsson'             => 'Sony Ericsson',
		'blackberry'           => 'BlackBerry',
		'cocoon'               => 'O2 Cocoon',
		'blazer'               => 'Treo',
		'lg'                   => 'LG',
		'amoi'                 => 'Amoi',
		'xda'                  => 'XDA',
		'mda'                  => 'MDA',
		'vario'                => 'Vario',
		'htc'                  => 'HTC',
		'samsung'              => 'Samsung',
		'sharp'                => 'Sharp',
		'sie-'                 => 'Siemens',
		'alcatel'              => 'Alcatel',
		'benq'                 => 'BenQ',
		'ipaq'                 => 'HP iPaq',
		'mot-'                 => 'Motorola',
		'playstation portable' => 'PlayStation Portable',
		'playstation 3'        => 'PlayStation 3',
		'playstation vita'     => 'PlayStation Vita',
		'hiptop'               => 'Danger Hiptop',
		'nec-'                 => 'NEC',
		'panasonic'            => 'Panasonic',
		'philips'              => 'Philips',
		'sagem'                => 'Sagem',
		'sanyo'                => 'Sanyo',
		'spv'                  => 'SPV',
		'zte'                  => 'ZTE',
		'sendo'                => 'Sendo',
		'nintendo dsi'         => 'Nintendo DSi',
		'nintendo ds'          => 'Nintendo DS',
		'nintendo 3ds'         => 'Nintendo 3DS',
		'wii'                  => 'Nintendo Wii',
		'open web'             => 'Open Web',
		'openweb'              => 'OpenWeb',

		// Operating Systems
		'android'              => 'Android',
		'symbian'              => 'Symbian',
		'SymbianOS'            => 'SymbianOS',
		'elaine'               => 'Palm',
		'series60'             => 'Symbian S60',
		'windows ce'           => 'Windows CE',

		// Browsers
		'obigo'                => 'Obigo',
		'netfront'             => 'Netfront Browser',
		'openwave'             => 'Openwave Browser',
		'mobilexplorer'        => 'Mobile Explorer',
		'operamini'            => 'Opera Mini',
		'opera mini'           => 'Opera Mini',
		'opera mobi'           => 'Opera Mobile',
		'fennec'               => 'Firefox Mobile',

		// Other
		'digital paths'        => 'Digital Paths',
		'avantgo'              => 'AvantGo',
		'xiino'                => 'Xiino',
		'novarra'              => 'Novarra Transcoder',
		'vodafone'             => 'Vodafone',
		'docomo'               => 'NTT DoCoMo',
		'o2'                   => 'O2',

		// Fallback
		'mobile'               => 'Generic Mobile',
		'wireless'             => 'Generic Mobile',
		'j2me'                 => 'Generic Mobile',
		'midp'                 => 'Generic Mobile',
		'cldc'                 => 'Generic Mobile',
		'up.link'              => 'Generic Mobile',
		'up.browser'           => 'Generic Mobile',
		'smartphone'           => 'Generic Mobile',
		'cellphone'            => 'Generic Mobile',
	];
	public function __construct()
	{
		if (isset($_SERVER['HTTP_USER_AGENT']))
		{
			//$_SERVER['HTTP_USER_AGENT'];
		}
		$config = new \config\config();
		$this->viewDirectory = $this->viewDirectory.$config->theme.'/'.$config->templateFolder;
	}
	
	
	
	
	
	
	
}
