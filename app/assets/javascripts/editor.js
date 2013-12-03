//= require wmd/wmd
//= require wmd/showdown
//= require jquery.tagEditor

$(function(){
  new WMDEditor({
    input: "editor-input",
    button_bar: "editor-button-bar",
    preview: "editor-preview",
    helpLink: "http://daringfireball.net/projects/markdown/syntax"
  });

  $('#editor :input[name*=tag_string]').tagEditor();
  $('#editor input.tag-input').attr('placeholder', $('#editor :input[name*=tag_string]').attr('placeholder'))

  var $form = $('#editor form[data-validate]');
  if ($form.length > 0) {
    var setting = window.ClientSideValidations.forms[$form.attr('id')];
    $('#editor :input[name*=tag_string][data-validate]').change(function(){
      $(this).isValid(setting.validators);
    });
  };
})
