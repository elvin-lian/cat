$.ajaxSetup({
    beforeSend:function (xhr) {
        var token = $('meta[name="csrf-token"]').attr('content');
        if (token) xhr.setRequestHeader('X-CSRF-Token', token);
    }
});

var el = {};

el.Tool = {

    bindSelectAllOrCancel:function () {
        var $selectAllOrCancel = $('.select_all_or_cancel');
        $selectAllOrCancel.click(function () {
            var isSelected = $(this).prop('checked');
            if (isSelected) {
                $selectAllOrCancel.prop('checked', true);
                $("input[name='ids[]']").each(function () {
                    $(this).prop('checked', true);
                });
            }
            else {
                $selectAllOrCancel.prop('checked', false);
                $("input[name='ids[]']").each(function () {
                    $(this).prop('checked', false)
                });
            }
        });
    },

    getAllSelectedIds:function () {
        var ids = '';
        $("input[name='ids[]']").each(function () {
            if ($(this).prop('checked')) {
                ids += $(this).val() + ',';
            }
        });
        return ids;
    },

    hideFlashMessage:function () {
        $('#flash-message').hide('slow');
    },

    datePicker:function () {
        $("#from").datepicker({
            dateFormat:"yy-mm-dd",
            defaultDate:"-1m",
            numberOfMonths:2,
            onClose:function (selectedDate) {
                $("#to").datepicker("option", "minDate", selectedDate);
            }
        });
        $("#to").datepicker({
            dateFormat:"yy-mm-dd",
            defaultDate:"-1d",
            numberOfMonths:1,
            onClose:function (selectedDate) {
                $("#from").datepicker("option", "maxDate", selectedDate);
            }
        });
    }

};

$(document).ready(function () {
    if ($('#flash-message').length > 0) {
        setTimeout(el.Tool.hideFlashMessage, '5000');
    }
});