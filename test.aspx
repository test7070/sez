<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
		
		<script type="text/javascript">

            $(document).ready(function() {
            	$('#txtA').change(function(){
            		//alert((/^([\w]+)$/g).test($(this).val()));
            		alert((/^(\w+|\w+\u002D\w+)$/g).test($(this).val()));
            		//$('#txtB').val($(this).val().replace( /^([[a-z,A-Z,0-9,_]*\^]*)([a-z,A-Z,0-9,_]*)$/g, "$2"));
            	});
			
				//alert(document.documentMode);
				//Unlock(100);
            });
        		
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
           
            function Lock(key,setting) {
            	var t_key = '';
            	var t_background = 'black';
            	var t_opacity = 0.2;
            	/*var t_width = Math.max(document.body.clientWidth, document.body.scrollWidth);
            	    t_height = Math.max(document.body.clientHeight, document.body.scrollHeight);*/
            	var t_width = $(document).width();
            	var t_height = $(document).height();
            		
            	if(arguments[0]!=undefined)
            		t_key = arguments[0];
            	if(arguments[1]!=undefined){
            		if(arguments[1].background!=undefined)
            			t_background=arguments[1].background;
            		if(arguments[1].opacity!=undefined)
            			t_opacity=arguments[1].opacity;
            	}	
            	
                if ($('#divLock'+t_key).length == 0)
                    $('body').append('<div id="divLock'+t_key+'"> </div>');
                $('#divLock'+t_key).css('width', $(document).width()).css('height', $(document).height());
                $('#divLock'+t_key).css('background', t_background).css('opacity', t_opacity);
                $('#divLock'+t_key).css('display', '').css('z-index', '999').css('position', 'absolute').css('top', 0).css('left', 0).focus();
            	addResizeEvent(
            		"if($('#divLock"+t_key+"').css('display')!='none')"+
            		"$('#divLock"+t_key+"').css('width', $(document).width()).css('height', $(document).height());"
            	);
            }
			function Unlock(key) {
				var t_key = '';
				if(arguments[0]!=undefined)
            		t_key = arguments[0];
				$('#divLock'+t_key).css('display', 'none');
			}		
            function addResizeEvent(func) {
                var oldonresize = window.onresize;
                if ( typeof window.onresize != 'function') {
                	if(typeof(func)=='string')
                    	eval('window.onresize = function(){'+func+'}');
                    else
                		window.onresize = func;
                } else {
                    window.onresize = function() {
                        if (oldonresize) {
                            oldonresize();
                        }
                        if(typeof(func)=='string')
                        	eval(func);
                        else
	                		func();
                    }
                }
            }
			
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
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
			    return accSub(this,arg);
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
		</style>
	</head>
	<body>
		<input id="txtA" style="width:200px;"/>
		<input id="txtB" style="width:200px;"/>
	</body>
</html>