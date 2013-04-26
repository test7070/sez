<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript">
            window.onresize = function(event) {

            }
            $(document).ready(function() {

                Lock();

                /*$('#txtA').change(function(e){

                var patt = /^(?:[0-1][0-9]|2[0-3])\:([0-5][0-9])$/g;
                alert(patt.test($(this).val()));
                var re = /(\d{4})([^\.,.]*)$/g;
                alert($(this).val().replace(re,"$1.$2"));
                });*/

                //(?:0?[1-9]|1[0-2])$

            });
            function Lock() {
                var t_width = document.body.offsetWidth > document.body.scrollWidth ? document.body.offsetWidth : document.body.scrollWidth;
                var t_height = document.body.offsetHeight > document.body.scrollHeight ? document.body.offsetHeight : document.body.scrollHeight;
                if ($('#divLock').length == 0)
                    $('body').append('<div id="divLock"> </div>');
                $('#divLock').css('width', t_width).css('height', t_height);
                $('#divLock').css('background', 'black').css('opacity', 0.2);
                $('#divLock').css('display', '').css('position', 'absolute').css('top', 0).css('left', 0).focus();
            	addResizeEvent(function(){
            		if($('#divLock').css('display')!='none')
            			return;
            		var t_width = document.body.offsetWidth > document.body.scrollWidth ? document.body.offsetWidth : document.body.scrollWidth;
                	var t_height = document.body.offsetHeight > document.body.scrollHeight ? document.body.offsetHeight : document.body.scrollHeight;
            		$('#divLock').css('width', t_width).css('height', t_height);
            	});
            }
			function Unlock() {
				$('#divLock').css('display', 'none');
			}		
            function addResizeEvent(func) {
                var oldonresize = window.onresize;
                if ( typeof window.onresize != 'function') {
                    window.onresize = func;
                } else {
                    window.onresize = function() {
                        if (oldonresize) {
                            oldonresize();
                        }
                        func();
                    }
                }
            }

            function addRefreshEvent(func) {
                var oldonrefresh = window.onrefresh;
                if ( typeof window.onrefresh != 'function') {
                    window.onrefresh = func;
                } else {
                    window.onrefresh = function() {
                        if (oldonrefresh) {
                            oldonrefresh();
                        }
                        func();
                    }
                }
            }
		</script>
		<style type="text/css">
            aa {
                position: absolute;
            }
		</style>
	</head>
	<body>
		<input id="txtA" style="width:200px;"/>
		
	</body>
</html>