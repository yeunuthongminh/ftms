$(document).on('turbolinks:load', function() {
  var arr_add_evaluation = [];
  var arr_remove_evaluation = [];
  reload_index($('.index-select'));
  reload_index($('.index-nonselect'));
  load_all_item();

  // Set reponsive form
  function setMaxHeight() {
    var height = $(window).height();
    maxheight = height - 340;
    minheight = height - 340;
    margin = height/2 - 260;
    $('.list-group').css('max-height', maxheight);
    $('.list-group').css('min-height', minheight);
    $('.div-button-center').css("margin-top", margin);
  }

  if ($('#evaluation_templates').length > 0 ) {
    setMaxHeight();
    $(window).on('resize', function(){
      setMaxHeight();
    });
  }

  //Select items in form left
  $('.noneselected-evaluation-standards').on('click', '.content_item', function () {
    if ($(this).parent().hasClass("select-item-evaluation-templates")) {
      $(this).parent().removeClass("select-item-evaluation-templates");
      for(var i = 0; i< arr_add_evaluation.length; i++){
        if(arr_add_evaluation[i].data("id") == $(this).data("id") &&
          arr_add_evaluation[i].data("name") == $(this).data("name"))
        {
          arr_add_evaluation.splice(i, 1);
        }
      }
    } else {
      $(this).parent().addClass("select-item-evaluation-templates");
      arr_add_evaluation.push($(this));
    }
  });

  //Button move items in from left to right
  $('.add-evaluation').on('click', function () {
    for(var i = 0; i< arr_add_evaluation.length; i++){
      arr_add_evaluation[i].parent().remove();

      var item = "<div class='one-item'><div class='col-md-1 index-select'></div>" +
        "<div class='col-md-11 content_item' data-id='"
        + arr_add_evaluation[i].data("id")+"' data-name='"
        + arr_add_evaluation[i].data("name")+"'>"
        + arr_add_evaluation[i].data("name")
        + "<input class='hidden' type='checkbox' value='"
        + arr_add_evaluation[i].data("id")
        + "' checked='checked' name='evaluation_template[evaluation_standard_ids][]'"
        + " id='evaluation_template_evaluation_standard_ids_"
        + arr_add_evaluation[i].data("id") + "'/></div></div>";
      $(".selected-evaluation-standards").append(item);
    }
    arr_add_evaluation = [];
    reload_index($('.index-select'));
    reload_index($('.index-nonselect'));
    load_all_item();
  });

  //ADD all item from left to right
  $('.add-all-evaluation').on('click', function () {
    all_items_nonselect.each(function () {
      var item = "<div class='one-item'><div class='col-md-1 index-select'></div>" +
        "<div class='col-md-11 content_item' data-id='"
        + $(this).data("id")+"' data-name='"
        + $(this).data("name")+"'>"
        + $(this).data("name")
        + "<input class='hidden' type='checkbox' value='"
        + $(this).data("id")
        + "' checked='checked' name='evaluation_template[evaluation_standard_ids][]' "
        + "id='evaluation_template_evaluation_standard_ids_"
        + $(this).data("id") + "'/></div></div>";
      $(this).parent().remove();
      $(".selected-evaluation-standards").append(item);
    });
    arr_add_evaluation = [];
    reload_index($('.index-select'));
    load_all_item();
  });

  //Select items in form right
  $('.selected-evaluation-standards').on('click', '.content_item', function () {
    if ($(this).parent().hasClass("select-item-evaluation-templates")) {
      $(this).parent().removeClass("select-item-evaluation-templates");
      for (var i = 0; i < arr_remove_evaluation.length; i++) {
        if (arr_remove_evaluation[i].data("id") == $(this).data("id")) {
          arr_remove_evaluation.splice(i, 1);
        }
      }
    } else {
      $(this).parent().addClass("select-item-evaluation-templates");
      arr_remove_evaluation.push($(this));
    }
  });

  //Button move items in from right to left
  $('.remove-evaluation').on('click', function () {
    for(var i = 0; i< arr_remove_evaluation.length; i++) {
      var item = "<div class='one-item'><div class='col-md-1 index-nonselect'></div>" +
        "<div class='col-md-11 content_item' data-id='"
        + arr_remove_evaluation[i].data("id")+"' data-name='"
        + arr_remove_evaluation[i].data("name")+"'>"
        + arr_remove_evaluation[i].data("name") + "</div></div>";
      arr_remove_evaluation[i].parent().find('.index-select').remove();
      arr_remove_evaluation[i].parent().remove();
      $(".noneselected-evaluation-standards").append(item);
    }
    arr_remove_evaluation = [];
    reload_index($('.index-nonselect'));
    reload_index($('.index-select'));
    load_all_item();
  });

  //ADD all items form right to left
  $('.remove-all-evaluation').on('click', function () {
    all_items_select.each(function () {
      var item = "<div class='one-item'><div class='col-md-1 index-nonselect'></div>" +
        "<div class='col-md-11 content_item' data-id='"
        + $(this).data("id")+"' data-name='"
        + $(this).data("name")+"'>"
        + $(this).data("name") + "</div></div>";
      $(this).parent().remove();
      $(".noneselected-evaluation-standards").append(item);
    });
    arr_remove_evaluation = [];
    reload_index($('.index-nonselect'));
    load_all_item();
  });

  function  load_all_item() {
    all_items_select = $('div.selected-evaluation-standards div.content_item');
    all_items_nonselect = $('div.noneselected-evaluation-standards div.content_item');
    $('.size-nonselect').html(I18n.t("evaluation_templates.standards.standards" ,
      {size: all_items_nonselect.length}));
    $('.size-select').html(I18n.t("evaluation_templates.standards.standards",
      {size: all_items_select.length}));
  }


  function reload_index(arr_index) {
    var i = 1;
    arr_index.each(function () {
      $(this).html(i);
      i++;
    });
  }

  // Filter left
  $('input#filter-nonselected').on('input', function () {
    var value_input = $(this).val();
    var arr_filter = [];
    if(value_input.length >= 1 && value_input != " "){
      all_items_nonselect.each(function () {
        if((($(this).data("name")+"").indexOf(value_input)) > -1){
          var item = "<div class='one-item'><div class='col-md-1 index-nonselect'></div></div>";
          arr_filter.push($(item).append($(this)));
        }
      });
      $(".noneselected-evaluation-standards").html(arr_filter);
      $('.size-nonselect').html(I18n.t("evaluation_templates.standards.standards",
        {size: arr_filter.length}));
    }else{
      var all_item = [];
      all_items_nonselect.each(function () {
        var item = "<div class='one-item'><div class='col-md-1 index-nonselect'></div></div>";
        all_item.push($(item).append($(this)));
      });
      $(".noneselected-evaluation-standards").html(all_item);
      $('.size-nonselect').html(I18n.t("evaluation_templates.standards.standards",
        {size: all_items_nonselect.length}));
    }
    reload_index($('.index-nonselect'));
  });

  // Filter right
  $('input#filter-selected').on('input', function () {
    var value_input = $(this).val();
    var arr_filter = [];
    if(value_input.length >= 1 && value_input != " "){
      all_items_select.each(function () {
        if((($(this).data("name")+"").indexOf(value_input)) > -1){
          var item = "<div class='one-item'><div class='col-md-1 index-select'></div></div>";
          arr_filter.push($(item).append($(this)));
        }
      });
      $(".selected-evaluation-standards").html(arr_filter);
      $('.size-select').html(I18n.t("evaluation_templates.standards.standards",
        {size: arr_filter.length}));
    }else{

      var all_item = [];
      all_items_select.each(function () {
        var item = "<div class='one-item'><div class='col-md-1 index-select'></div></div>";
        all_item.push($(item).append($(this)));
      });
      $(".selected-evaluation-standards").html(all_item);
      $('.size-select').html(I18n.t("evaluation_templates.standards.standards",
        {size: all_items_select.length}));
    }
    reload_index($('.index-select'));
  });

  $('.noneselected-list-standards').on('click', '.new-evaluation-standard', function() {
    $('#new-evaluation-standard-modal #selected').val(false);
  });

  $('.selected-list-standards').on('click', '.new-evaluation-standard', function() {
    $('#new-evaluation-standard-modal #selected').val(true);
  });

  $('#new-evaluation-standard-modal').on('show.bs.modal', function (e) {
    $('#new_evaluation_standard')[0].reset();
  });
});
