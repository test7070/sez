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
				alert(38.660*83.000);
				alert(Math.round(38.660*83.000,0));
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
			
			Number.prototype.round = function(arg) {
			    return Math.round(accDiv(accMul(this, Math.pow(10,arg)), Math.pow(10,arg)));
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
			    return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(arg, this);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return ((arg1 * m - arg2 * m) / m).toFixed(n);
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