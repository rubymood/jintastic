(function($){
  $(function(){
		$.inPlaceEditor = {
      toggle: function() {
        $([this.attribute, this.form]).toggle()

        if (this.form.is(':visible'))
          $.inPlaceEditor.form.find('fieldset li:nth-child(1)')
      }
    }

    $('.in_place_attribute').live('click', function() {
      $.inPlaceEditor.attribute = $(this)
      $.inPlaceEditor.form = $.inPlaceEditor.attribute.next()
      $.inPlaceEditor.toggle() 
    })

    $('.in_place_save').live('click', function() {
      $.inPlaceEditor.form = $(this).parent('form')
      $.inPlaceEditor.attribute = $.inPlaceEditor.form.prev()
      $.ajax({
        url: $.inPlaceEditor.form[0].action,
        type: "POST",
        dataType: "script",
        data: $.inPlaceEditor.form.serializeArray()
      })
      return false
    })

    $('.in_place_cancel').live('click', function() {
      $.inPlaceEditor.form = $(this).parent('form')
      $.inPlaceEditor.attribute = $.inPlaceEditor.form.prev()
      $.inPlaceEditor.toggle()
    })
  })
})(jQuery)
