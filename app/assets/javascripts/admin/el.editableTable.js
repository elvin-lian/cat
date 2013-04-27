el.EditableTable = (function () {

    var bind = function (url) {
        $('.editable-blk').click(
            function () {
                $(this).find('span').hide();
                $(this).find('.edit-input').show();
                $(this).find('i').hide();
            }).change(function () {

                $(this).append('<span class="edit-loading"></span>');

                var id = $(this).attr('iid');
                var $text = $(this).find('.edit-text');
                var $i_ele = $(this).find('i');
                var $input = $(this).find('.edit-input');

                $.ajax({
                    type:"POST",
                    url:url + id.toString(),
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
                    }
                });

            });

//        $('body').mouseup(function () {
//            $('.editable-blk .edit-input').hide();
//            $('.editable-blk .edit-loading').remove();
//            $(".editable-blk .edit-text").show();
//            $(".editable-blk i").show();
//        });
    };

    return {init:bind}
})();