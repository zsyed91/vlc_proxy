lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vlc_proxy/version'

Gem::Specification.new do |spec|
  spec.name          = 'vlc_proxy'
  spec.version       = VlcProxy::VERSION
  spec.authors       = ['Zshawn Syed']
  spec.email         = ['zsyed91@gmail.com']

  spec.summary       = 'Simple Ruby wrapper around the HTTP server VLC exposes'
  spec.description   = 'Simple Ruby wrapper around the HTTP server VLC exposes'
  spec.homepage      = 'https://github.com/zsyed91/vlc_proxy'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'simplecov'
end
