lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
    s.name = 'TeaLI'
    s.version = '0.1.1'
    s.date = '2019-11-01'
    s.summary = 'A simple scrape/search Tea CLI app'
    s.description = 'A simple CLI application to scrape and search for teas using the Adagio Teas website'
    s.authors = ['Emily Harber']
    s.email = 'theoriginalpixi@gmail.com'
    s.files = ["lib/scraper.rb", "lib/category.rb", "lib/tea.rb", "lib/teaLI.rb", "config/env.rb"]
    s.homepage = 'https://rubygems.org/profiles/TheCodePixi'
    s.license = 'MIT'
    s.executables << 'TeaLI'
end 
