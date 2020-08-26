Pod::Spec.new do |spec|
    spec.name                   = 'mongKit'
    spec.version                = '0.0.30'
    spec.homepage               = 'https://www.whitecloak.com'
    spec.source                 = { :git => "https://gitlab.whitecloak.io/michael.ong/mongkit.git", :tag => "0.0.30" }
    spec.authors                = { 'Michael Ong' => 'michael.ong@whitecloak.com' }
    spec.license                = { :type => 'MIT' }
    spec.summary                = 'Boilerplate code for iOS projects.'

    spec.module_name            = "mongKit"

    spec.swift_version          = "5.2"
    spec.ios.deployment_target  = "12.0"

    spec.source_files           = "mongKit/**/*.swift"

    spec.dependency 'ReactiveSwift', '~> 6.3.0'
    spec.dependency 'ReactiveCocoa', '~> 11.0.0'

end
