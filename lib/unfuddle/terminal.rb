module Unfuddle
  module Terminal
    # Prompt for input
    def ask(title, opts={})
      print("#{title}#{opts.key?(:default) ? " [#{opts[:default]}]" : ''}: ")
      result = gets.strip
      result = opts[:default] if result.empty? && opts.key?(:default)
      result = result.scan(/[a-z\d\_\-]{1,}/i) if opts.key?(:array)
      result.empty? && opts.key?(:required) ? ask(title, opts) : result
    end
    
    # Prompt for password
    def ask_password
      echo_off
      password = ask('Password', :required => true)
      puts
      echo_on
      return password
    end
    
    # Prompt for Y/N question
    def ask_yesno(title, required='y', opts={})
      answer = ask("#{title} (y/n)", opts).downcase
      answer == required
    end
    
    # Show success message
    def success(title)
      puts title.green
    end
    
    # Show error message
    def error(title)
      STDERR.puts(title.red)
      exit(1)
    end
    
    # Show warning message
    def warning(title)
      puts title.yellow
    end
    
    # Print message
    def display(msg, newline=true)
      if newline
        puts(msg)
      else
        print(msg)
        STDOUT.flush
      end
    end
    
    # Execure shell command
    def shell(cmd)
      FileUtils.cd(Dir.pwd) {|d| return `#{cmd}`}
    end
    
    # Disable terminal prompt
    def echo_off
      system "stty -echo"
    end

    # Enable terminal prompt
    def echo_on
      system "stty echo"
    end
  end
end