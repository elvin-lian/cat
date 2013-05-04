el.EditableTable = (function () {
    var __url = '';
    var clickEvent = function () {
        $('.editable-blk').click(
            function () {
                $(this).find('span').hide();
                $(this).find('i').hide();
                var $input = $(this).find('.edit-input');
                $input.show();
                $input.focus();
            }).change(function () {

                $(this).append('<span class="edit-loading"></span>');

                var id = $(this).attr('iid');
                var $text = $(this).find('.edit-text');
                var $i_ele = $(this).find('i');
                var $input = $(this).find('.edit-input');

                $.ajax({
                    type:"POST",
                    url:__url + id.toString(),
                    data:'name=' + $input.prop('name') + '&value=' + $input.val(),
                    cache:false,
                    success:function (data) {
                        $('.editable-blk .edit-loading').remove();
                        if (data.res) {
                            $input.hide();
                            $text.html($input.val());
                            $text.show();
                            $i_ele.show();
                        } else {
                            alert(data.message);
                        }
                    },
                    complete:function () {
                        $('.editable-blk .edit-loading').remove();
                    }
                });

            });

    };

    var blurEvent = function () {
        $('.edit-input').blur(function () {
            $('.editable-blk .edit-input').hide();
            $(".editable-blk .edit-text").show();
            $(".editable-blk i").show();
        });
    };

    var init = function (url) {
        __url = url;
        clickEvent();
        blurEvent();
    };

    return {init:init}
})();