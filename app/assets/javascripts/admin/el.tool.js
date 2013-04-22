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
    }
};