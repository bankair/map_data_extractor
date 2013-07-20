Gem::Specification.new do |s|
  s.name        = 'map_data_extractor'
  s.version     = '0.4.0'
  s.date        = '2012-12-24'
  s.description = 'Tools to extract data from map descriptors.'
  s.summary     = 'Extract data from map descriptors.'
  s.author      = 'Romain Tribes'
  s.email       = 'tribes.romain@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/Sephi-Chan/map_data_extractor/'

  s.add_dependency('rmagick', '>= 2.13.1')
  s.add_dependency('rake', '>= 10.1.0')
end
