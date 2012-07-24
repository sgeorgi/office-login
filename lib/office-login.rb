require "office-login/version"
require 'watir-webdriver'
require 'headless'
require 'optparse'
require 'yaml'

module Office
  module Login
    def self.login(args)

      options = Login::get_options(args)
      configuration = Login::get_configuration
      configuration.merge!(options)
      Login::store_configuration(configuration)

      Headless.ly do |headless|
        browser = Watir::Browser.new
        browser.goto configuration[:log_out]
        browser.goto configuration[:log_in]
        browser.text_field(:name => 'username').set(configuration[:username])
        browser.text_field(:name => 'password').set(configuration[:password])
        browser.button(:name => 'Submit').click
        browser.close
      end
    rescue => error
      puts "Something did not work: #{error.inspect}"
      exit 1
    end

    def self.get_configuration
      file = File.expand_path("~") + '/.office-login'
      if File.exists?(file)
        configuration = YAML.load_file file
      else
        configuration = {
          :log_in => 'https://host/login.html',
          :log_out => 'https://host/logout.html',
          :username => 'username',
          :password => 'password'
        }
      end

      configuration
    end

    def self.store_configuration configuration
      file_name = File.expand_path("~") + '/.office-login'
      File.open(file_name, 'w') { |file| file.puts(configuration.to_yaml) }
    end

    def self.get_options(args)
      options = { }
      OptionParser.new do |opts|
        opts.banner = "Usage: office-login [options]"

        opts.on("-a", "--log-in [STRING]", "URL for LOGIN-action") do |li|
          options[:log_in] = li
        end

        opts.on("-b", "--log-out [STRING]", "URL for LOGOUT-action") do |lo|
          options[:log_out] = lo
        end

        opts.on("-u", "--username [STRING]", "The username to be used") do |u|
          options[:username] = u
        end

        opts.on("-p", "--password [STRING]", "The password to be used") do |p|
          options[:password] = p
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!(args)

      options
    end

  end
end
