require 'simplecov'
require 'simplecov-rcov'
require 'rspec-extra-formatters'

require 'bundler/setup'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
SimpleCov.start

require 'norwegian_phone'
