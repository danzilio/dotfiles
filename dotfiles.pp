# Sets up my dotfiles. Requires the future parser.
#
class dotfiles {
  $home = inline_template('<%= Dir.home %>')

  vcsrepo { "${home}/.oh-my-zsh":
    ensure     => present,
    provider   => git,
    submodules => true,
    source     => 'https://github.com/robbyrussell/oh-my-zsh.git',
  }

  vcsrepo { "${home}/.dotfiles":
    ensure     => present,
    provider   => git,
    submodules => true,
    source     => 'https://github.com/danzilio/dotfiles.git',
  }

  $links = {
    "${home}/.gitconfig"   => "${home}/.dotfiles/gitconfig",
    "${home}/.vim"         => "${home}/.dotfiles/vim",
    "${home}/.vimrc"       => "${home}/.vim/vimrc",
    "${home}/.zsh_aliases" => "${home}/.dotfiles/aliases",
    "${home}/.zshrc"       => "${home}/.dotfiles/zshrc",
    "${home}/.atom"        => "${home}/.dotfiles/atom",
    "${home}/.gemrc"       => "${home}/.dotfiles/gemrc",
  }

  $links.each |$link,$target| {
    file { $link:
      ensure => link,
      target => $target
    }
  }
}
