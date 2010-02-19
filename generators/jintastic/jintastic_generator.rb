class JintasticGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory File.join(%w[app views jintastic])
      m.file "_in_place_editor.html.erb", File.join(%w[app views jintastic _in_place_editor.html.erb])
      m.file "jintastic.js", File.join(%w[public javascripts jintastic.js])
    end
  end

  protected

  def banner
    %{Usage: #{$0} #{spec.name}\nCopies jintastic.js to public/javascripts/ and a partial to app/views/jintastic/_in_place_editor.html.erb}
  end
end
