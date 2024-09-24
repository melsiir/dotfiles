function gyp -d "init and install gyp dependencies"
    apt install clang python libsqlite pkg-config binutils -y
    mkdir -p ~/.gyp
    echo -e "{
	'variables': {
		'android_ndk_path': ''
	}
}" >~/.gyp/include.gypi
    ls ~/.gyp
    cat ~/.gyp/include.gypi
    echo "file created successfully"
end
