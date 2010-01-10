require File.join File.dirname(__FILE__), *%w{vendor plugins formtastic rails init}
require 'jintastic'
I18n.load_path.unshift File.join File.dirname(__FILE__), 'config', 'locale', 'en.yml'
