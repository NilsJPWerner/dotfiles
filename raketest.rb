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

install_iterm_settings if RUBY_PLATFORM.downcase.include?("darwin")