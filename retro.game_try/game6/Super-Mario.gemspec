Gem::Specification.new do |game|
  game.name     = 'Super-Mario'
  game.version  = '0.2'
  game.authors  = ['Aizawa Hidetaka']
  game.email    = ['sansanhidetaka@gmail.com']
  game.homepage = 'https://github.com/H-hidetaka/Retro.game_try/tree/master/retro.game_try/game6'
  game.summary  = 'My Super Mario Ruby project'
  game.description = 'My purpose is what makes  game for PortFolio '
  game.files    = `git ls-files`.split("\n")
  game.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  game.executables = `git ls-files -- bin/*`.split("\n")
    .map { |f| File.basename(f) }
  game.require_paths = ['lib']
  game.license = 'GPLv3'
  game.add_runtime_dependency 'gosu', '~>1.14.20'
  game.add_development_dependency 'rspec', '~>3.10'
end
