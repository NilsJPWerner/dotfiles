require 'rake'
require 'fileutils'

BREW_PACKAGES = "bash cask coreutils ffmpeg gcc git p7zip postgresql"\
" python python3 rename the_silver_searcher thefuck tree wget zsh"

desc "Symlink dotfiles to root folder"
task :install => [] do
    puts "======================================================"
    puts "\t\tSetting up your computer"
    puts "======================================================"
    puts
    puts

    install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")

end



private

def install_homebrew
    puts "======================================================"
    puts "Setting up Homebrew."
    puts "======================================================"
    run %{which brew}
    unless $?.success?
        puts "======================================================"
        puts "Installing Homebrew, the OSX package manager...If it's"
        puts "already installed, this will do nothing."
        puts "======================================================"
        run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
    end
    run %{brew update}
    puts
    puts "======================================================"
    puts "Installing Homebrew packages...There may be some warnings."
    puts "======================================================"
    run %{brew install #{BREW_PACKAGES}}
    run %{brew install macvim --custom-icons --with-override-system-vim --with-lua --with-luajit}
    puts
    puts
end


def install_fonts
    puts "======================================================"
    puts "Installing fonts."
    puts "======================================================"
    run %{ cp -f $HOME/.dotfiles/fonts/* $HOME/Library/Fonts } if RUBY_PLATFORM.downcase.include?("darwin")
    run %{ mkdir -p ~/.fonts && cp ~/.dotfiles/fonts/* ~/.fonts && fc-cache -vf ~/.fonts } if RUBY_PLATFORM.downcase.include?("linux")
    puts
end


def install_iterm_settings
    puts "======================================================"
    puts "Installing iTerm2 solarized theme."
    puts "======================================================"
    run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
    run %{ /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Dark.itermcolors' :'Custom Color Presets':'Solarized Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist }


    puts "======================================================"
    puts "Installing iTerm2 theme and settings."
    puts "======================================================"
    run %{defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "$HOME/.dotfiles/iterm"}
    run %{defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true}
end

def run(cmd)
    puts "[Running] #{cmd}"
    `#{cmd}` unless ENV['DEBUG']
end

def install_files(files, method = :symlink)
    files.each do |f|
        file = f.split('/').last
        source = "#{ENV["PWD"]}/#{f}"
        target = "#{ENV["HOME"]}/.#{file}"

        puts "======================#{file}=============================="
        puts "Source: #{source}"
        puts "Target: #{target}"

        if File.exists?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
            puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
            run %{ mv "$HOME/.#{file}" "$HOME/.#{file}.backup" }
        end

        if method == :symlink
            run %{ ln -nfs "#{source}" "#{target}" }
        else
            run %{ cp -f "#{source}" "#{target}" }
        end

        # Temporary solution until we find a way to allow customization
        # This modifies zshrc to load all of yadr's zsh extensions.
        # Eventually yadr's zsh extensions should be ported to prezto modules.
        source_config_code = "for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file"
        if file == 'zshrc'
            File.open(target, 'a+') do |zshrc|
                if zshrc.readlines.grep(/#{Regexp.escape(source_config_code)}/).empty?
                    zshrc.puts(source_config_code)
                end
            end
        end

        puts "=========================================================="
        puts
    end
end