require 'formtastic'

class ActionView::Base 
  def in_place_editor_for(path_spec_or_object, attributes)
    instance = case path_spec_or_object
      when ActiveRecord::Base: path_spec_or_object
      when Array: path_spec_or_object.last
    end
    
    if attributes.class==Symbol  
      #simple one attribute in place editor
      #in_place_editor_for @user, :name
      attribute = attributes
      input_attributes = Array(attribute)

    elsif attributes.values.first==:form
      #render default form partial
      #in_place_editor_for @user, :name=>:form 
      attribute = attributes.keys.first

    elsif attributes.values.first.class==String
      #render custom form partial
      #in_place_editor_for @user, :name=>'users/custom_form'
      attribute = attributes.keys.first
      form_partial = attributes[attribute]

    else
      #attribute is an array
      #in_place_editor_for @user, :name=>[:name,:address]
      attribute = attributes.keys.first
      input_attributes = attributes[attribute]
    end

    container_tag =  instance.column_for_attribute(attribute).type == :text ? :pre : :span

    form_tag_options = {:id=>dom_id(path_spec_or_object, attribute)}
    content_tag_options = {:class=>'in_place_attribute'}

    form_partial ||= "#{instance.class.to_s.downcase.pluralize}/form" unless input_attributes

    if instance.valid?
      form_tag_options.merge!({:html=>{:style=>"display: none"}}) 
    else
      content_tag_options.merge!({:style=>"display: none"})
    end

    render :partial => 'jintastic/in_place_editor', 
           :locals => {:container_tag=>container_tag,
                     :input_attributes=>input_attributes,
                     :attribute=>attribute,
                     :path_spec_or_object=>path_spec_or_object,
                     :instance=>instance,
                     :content_tag_options=>content_tag_options,
                     :form_tag_options=>form_tag_options,
                     :form_partial=>form_partial}
  end   
end

# hack for assets because gems hasn't got rake tasks 
#
# copy assets at every server start because after update maybe they have to update too
FileUtils.cp_r File.join(File.dirname(__FILE__), *%w{.. assets .}), Rails.root 
