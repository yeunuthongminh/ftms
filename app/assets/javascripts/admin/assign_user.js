$(document).on("turbolinks:load", function() {
  $('#btn-assign-trainer').click(function (e) {
    e.preventDefault();
    list_items = $('#list-users li.list-group-item.active');
    destination = $('.list-group#list-trainers');
    move_selected_users(list_items, destination, "TrainerCourse");
    count_record($('#list-trainers'), 'li.list-group-item');
  });

  $('#btn-assign-trainee').click(function (e) {
    e.preventDefault();
    list_items = $('#list-users li.list-group-item.active');
    destination = $('.list-group#list-trainees');
    move_selected_users(list_items, destination, "TraineeCourse");
    count_record($('#list-trainees'), 'li.list-group-item');
  });

  $('#btn-remove-user').click(function (e) {
    e.preventDefault();
    list_items = $('#list-trainers li.list-group-item.active, #list-trainees li.list-group-item.active');
    destination = $('.list-group#list-users');
    move_selected_users(list_items, destination);
    count_record($('#list-users'), 'li.list-group-item');
  });

  $('#assign-user-submit').click(function () {
    $('#assign-user-form').trigger('submit');
    $(this).closest('.modal').modal('hide');
  });
});

function move_selected_users(list_items, destination, attr_type="") {
  var selected_users = list_items.detach();
  selected_users.each(function(){
    $('.input-user-type', this).each(function() {
      $(this).val(attr_type);
    });
    $(this).triggerHandler('click');
  });
  destination.prepend(selected_users);
  $(selected_users).effect('highlight', {}, 1000);
}

function build_list_user_selectbox (lists) {
  var i = 0;
  lists.each(function () {
    // Settings
    var id = $(this).attr('id') ? $(this).attr('id') : "";
    var type = $(this).data('type') ? $(this).data('type') : "";
    var $widget = $(this),
      $checkbox = $('<input type="checkbox" class="hidden"/>'),
      $id = $('<input name="course[user_courses_attributes][' + i
        + '][id]" value="' + id + '" type="hidden"/>'),
      $user_id = $('<input name="course[user_courses_attributes][' + i
        + '][user_id]" value="' + $(this).data('user') + '" type="hidden"/>'),
      $_deleted_at = $('<input name="course[user_courses_attributes][' + i
        + '][deleted_at]" value="" type="hidden"/>'),
      $type = $('<input name="course[user_courses_attributes][' + i
        + '][type]" value="'+ type +'" class="input-user-type" type="hidden"/>')
      color = ($widget.data('color') ? $widget.data('color') : "primary"),
      style = ($widget.data('style') == "button" ? "btn-" : "list-group-item-"),
      settings = {
        on: {
          icon: 'glyphicon glyphicon-check'
        },
        off: {
          icon: 'glyphicon glyphicon-unchecked'
        }
      };

    $widget.css('cursor', 'pointer');
    $widget.append($checkbox).append($id).append($user_id).append($type).append($_deleted_at);

    // Event Handlers
    $widget.on('click', function () {
      $checkbox.prop('checked', !$checkbox.is(':checked'));
      $checkbox.triggerHandler('change');
      updateDisplay();
    });

    $checkbox.on('change', function () {
      updateDisplay();
    });

    // Actions
    function updateDisplay() {
      var isChecked = $checkbox.is(':checked');

      // Set the button's state
      $widget.data('state', (isChecked) ? "on" : "off");

      // Set the button's icon
      $widget.find('.state-icon')
        .removeClass()
        .addClass('state-icon ' + settings[$widget.data('state')].icon);

      // Update the button's color
      if (isChecked) {
        $widget.addClass(style + color + ' active');
      } else {
        $widget.removeClass(style + color + ' active');
      }
    }

    // Initialization
    function init() {
      if ($widget.data('checked') == true) {
        $checkbox.prop('checked', !$checkbox.is(':checked'));
      }

      updateDisplay();

      // Inject the icon if applicable
      if ($widget.find('.state-icon').length == 0) {
        $widget.prepend('<span class="state-icon ' + settings[$widget.data('state')].icon + '"></span>');
      }
    }
    init();
    i++;
  });
}

function count_record(parent, element_type) {
  var count = $(element_type, parent).length;
  $(parent).closest('.panel').find('.count-member').text(I18n.t("count_records", {record: count}));
}
