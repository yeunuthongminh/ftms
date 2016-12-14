$(document).on('turbolinks:load', function () {
  $('#btn-assign-project').click(function () {
    $('#course_subject_project_id').triggerHandler('change');
  });

  $('#course_subject_project_id').change(function () {
    if ($.trim(this.value)) {
      var arr_url = document.location.pathname.split('/');
      var _url = "/" + arr_url[1] +"/" + arr_url[2] + "/projects/" + $.trim(this.value)
        + "/project_requirements";
      var course_subject = $('#btn-assign-project').data('course-subject');
      $.ajax({
        url: _url,
        method: "GET",
        dataType: "json",
        data: {course_subject: course_subject},
        success: function (data) {
          var html = "";
          var subject_requirements = data.subject_requirements;
          if (data.requirement.length > 0) {
            for (var i = 0; i < data.requirement.length; i++) {
              var _rqm = data.requirement[i];
              var _checked = "";
              if (subject_requirements[_rqm.id]) {
                _checked = "data-checked='true' data-course-subject-requirement='"
                  + subject_requirements[_rqm.id] + "'";
              }

              html += "<li class='list-group-item' data-id='"+ _rqm.id
                + "' " + _checked + "data-color='info'>" + _rqm.name
                + "</li>";
            }
          } else {
            html = "<div class='empty' align='center'><h2>" + I18n.t("projects.label.empty")
              + "</h2></div>";
          }
          $('#list-rqms').html(html);
          var items = $('.list-group.checked-list-box .list-group-item');
          build_list_selectbox(items);
        },
        error: function() {
        }
      });
    } else {
      $('#list-rqms').html('');
    }
  });

  $(document).bind('ajaxStart', function(){
    $('#loading-project').show();
  }).bind('ajaxStop', function(){
    $('#loading-project').hide();
  });
});

function build_list_selectbox (lists) {
  var i = 0;
  lists.each(function () {
    // Settings
    var id;

    if ($(this).data('course-subject-requirement')) {
      id = $(this).data('course-subject-requirement');
    } else {
      id = "";
    }

    var $widget = $(this),
      $checkbox = $('<input type="checkbox" class="hidden"/>'),
      $id = $('<input name="course_subject[course_subject_requirements_attributes]['
        + i + '][id]" value="' + id + '" type="hidden"/>'),
      $project_requirement = $('<input name="course_subject[course_subject_requirements_attributes]['
        + i + '][project_requirement_id]" value="' + $(this).data('id') + '" type="hidden"/>'),
      $_destroy = $('<input class="_destroy" name="course_subject[course_subject_requirements_attributes]['
        + i + '][_destroy]" type="hidden"/>'),
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

    $widget.css('cursor', 'pointer')
    $widget.append($checkbox).append($id).append($project_requirement).append($_destroy);

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
      $('input._destroy', $widget).val(!isChecked);
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
