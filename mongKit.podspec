Pod::Spec.new do |spec|
    spec.name                   = 'mongKit'
    spec.version                = '0.1.4'
    spec.homepage               = 'https://www.noname.com'
    spec.source                 = { :git => "https://github.com/mongindustries/mongkit.git", :tag => spec.version }
    spec.authors                = { 'Michael Ong' => 'michaelong18@gmail.com' }
    spec.license                = { :type => 'MIT' }
    spec.summary                = 'Boilerplate code for iOS projects.'

    spec.swift_version          = "5.3"
    spec.ios.deployment_target  = "12.0"

    spec.dependency 'ReactiveSwift'
    spec.dependency 'ReactiveCocoa'

    spec.subspec 'Core' do |cspec|
        cspec.source_files = "mongKit/mongKit.core/**/*.swift"
    end

    spec.subspec 'View' do |cspec|
        cspec.source_files = "mongKit/mongKit.view/**/*.swift"
        cspec.dependency 'mongKit/Core'
        cspec.dependency 'mongKit/Structure'
    end

    spec.subspec 'Structure' do |cspec|
        cspec.source_files = "mongKit/mongKit.structure/**/*.swift"
        cspec.dependency 'mongKit/Core'
    end

    spec.subspec 'Networking' do |cspec|
        cspec.source_files = "mongKit/mongKit.networking/**/*.swift"
        cspec.dependency 'mongKit/Core'
    end
end
