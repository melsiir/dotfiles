First
apt install clang python libsqlite pkg-config binutils


Second
touch ~/.gyp/include.gypi

Inside it write

{
	'variables': {
		'android_ndk_path': ''
	}
}


Or

export GYP_DEFINES="android_ndk_path=''"


