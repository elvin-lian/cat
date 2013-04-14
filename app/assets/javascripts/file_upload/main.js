/*
 * jQuery File Upload Plugin JS Example 7.1.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

var fileUploadErrors = {
        maxFileSize:'文件不能超过10M',
        minFileSize:'文件太小',
        acceptFileTypes:'只能允许上传.jpg, .jpeg, .png格式图片',
        maxNumberOfFiles:'最大同时上传文件数超出',
        uploadedBytes:'最大同时上传文件超出大小',
        emptyResult:'上传出错'
    };

$(function () {
    //  'use strict';


    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload();

// Enable iframe cross-domain access via redirect option:
//    $('#fileupload').fileupload(
//        'option',
//        'redirect',
//        window.location.href.replace(
//            /\/[^\/]*$/,
//            '/cors/result.html?%s'
//        )
//    );

//    if (window.location.hostname === 'blueimp.github.com' ||
//            window.location.hostname === 'blueimp.github.io') {
//        // Demo settings:
//        $('#fileupload').fileupload('option', {
//            url: '//jquery-file-upload.appspot.com/',
//            maxFileSize: 5000000,
//            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
//            process: [
//                {
//                    action: 'load',
//                    fileTypes: /^image\/(gif|jpeg|png)$/,
//                    maxFileSize: 20000000 // 20MB
//                },
//                {
//                    action: 'resize',
//                    maxWidth: 1440,
//                    maxHeight: 900
//                },
//                {
//                    action: 'save'
//                }
//            ]
//        });
//        // Upload server status check for browsers with CORS support:
//        if ($.support.cors) {
//            $.ajax({
//                url: '//jquery-file-upload.appspot.com/',
//                type: 'HEAD'
//            }).fail(function () {
//                $('<span class="alert alert-error"/>')
//                    .text('Upload server currently unavailable - ' +
//                            new Date())
//                    .appendTo('#fileupload');
//            });
//        }
//    } else {
    // Load existing files:
    //$('#fileupload').addClass('fileupload-processing');

    $('#fileupload').fileupload('option', {
        maxFileSize:1000000, // 10M
        acceptFileTypes:/(\.|\/)(jpe?g|png)$/i
    });

    if ($.support.cors) {
        $.ajax({
            maxChunkSize:1000000, // 10 MB
            url:$('#fileupload').fileupload('option', 'url'),
            dataType:'json',
            context:$('#fileupload')[0]
        }).always(function (result) {
                $(this).removeClass('fileupload-processing');
            }).done(function (result) {
                $(this).fileupload('option', 'done').call(this, null, {result:result});
            });
    }
//    }

});
