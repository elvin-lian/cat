el.Product = (function () {
    var init = function () {
        bindBatchOperation();
        el.Tool.bindSelectAllOrCancel();
    };

    var bindBatchOperation = function () {
        $('.batch_destroy').click(function () {
            if (confirm('你确定要删除？')) {
                batchOperation('/admin/products/batch_destroy');
            }
        });

        $('.batch_listed').click(function () {
            batchOperation('/admin/products/batch_listed');
        });

        $('.batch_unlisted').click(function () {
            batchOperation('/admin/products/batch_unlisted');
        });

        $('.batch_same_section').click(function () {
            batchOperation('/admin/products/batch_same_section');
        });
    };

    var batchOperation = function (url) {
        var ids = el.Tool.getAllSelectedIds();
        if (ids == '') {
            alert('请至少选择一样单品');
            return false;
        }
        $.ajax({
            type:'post',
            url:url,
            data:{ids:ids},
            success:function (data) {
                if (1 == data.status) {
                    alert(data.message);
                    location.reload();
                } else {
                    alert('操作失败！' + data.message)
                }
            }
        });
    };

    return {init:init}
})();
