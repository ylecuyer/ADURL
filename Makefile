all: ADURL.xcworkspace
	xcodebuild

ADURL.xcworkspace:
	pod install

test: ADURL.xcworkspace
	xcodebuild test -scheme 'ADURL' -sdk iphonesimulator7.0 -workspace 'ADURL.xcworkspace' -configuration Debug

clean:
	rm -rf ADURL.xcworkspace
	rm -rf Pods
	rm -rf build