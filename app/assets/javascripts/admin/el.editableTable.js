el.EditableTable = (function () {

    var bind = function (url) {
        $('.edit_td').click(
            function () {
                $('#modify_message').hide();
                var id = $(this).attr('iid');
                var $span = $(this).find('span');
                var $input = $(this).find('input');
                $input.val($span.html());
                $span.hide();
                $input.show();
            }).change(function () {

                $(this).append('<span class="edit-loading"></span>');

                var id = $(this).attr('iid');
                var $span = $(this).find('span');
                var $input = $(this).find('input');
                var value = $input.val();
                var name = $input.attr('name');

                $.ajax({
                    type:"POST",
                    url:url + id.toString(),
                    data:'name=' + name + '&value=' + value,
                    cache:false,
                    success:function (data) {
                        $('.edit-loading').remove();
                        if (data.res) {
                            $span.html(value);
                            $input.hide();
                            $span.show();
                        } else {
                            //$('#modify_message').removeClass('alert-success');
                            $('#modify_message').addClass('alert-error');
                            $('#modify_message').show();
                            $('#modify_message_body').html(data.message);
                        }
                    }
                });

            });

        $(document).mouseup(function () {
            $(".edit_input").hide();
            $(".edit_span").show();
            $('.edit-loading').remove();
        });
    };


    return {init: bind}

})();