<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            function z_accc() {
            }
            z_accc.prototype = {
                data : {
                    part : null
                },
                keyup : null
            };
            t_data = new z_accc();

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_accc');
            });

            function q_gfPost() {
                q_gt('acpart', '', 0, 0, 0, "init1", r_accy+'_'+r_cno);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'init1':
                        t_data.data['part'] = '';
                        var as = _q_appendData("acpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['part'] += (t_data.data['part'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        initfinish();
                        break;
                }
            }
            function initfinish(){
            	$('#q_report').q_report({
                    fileName : 'z_accc',
                    options : [{/*  [1]*/
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    },{/*  [2]*/
                        type : '0',
                        name : 'xrank',
                        value : r_rank
                    }, {/*1 [3],[4]*/
                        type : '1',
                        name : 'date'
                    }, {/*2 [5][6] 含子科目*/
                        type : '2',
                        name : 'xacc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*3 [7][8] 不含子科目*/
                        type : '2',
                        name : 'yacc',
                        dbf : 'view_acc',
                        index : 'acc1,acc2',
                        src : "view_acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*4 [9]*/
                        type : '8',
                        name : 'xpart',
                        value : ('zzzzz@無部門,'+t_data.data['part']).split(',')
                    }, {/*5 [10]*/
                        type : '8',
                        name : 'xoption03',
                        value : q_getMsg('toption03').split('&')
                    }, {/* [11][12]*/
                        type : '1',
                        name : 'xproject'
                    }]
                });
                
                $('#txtDate1').mask('999/99/99');
           //     $('#txtDate1').datepicker(); 打完日期按ENTER會變成當天日期
                $('#txtDate2').mask('999/99/99');
           //     $('#txtDate2').datepicker();
				$('#chkXpart').children('input').attr('checked', 'checked');
				if(q_getPara('accc.proj').length==0){
					$('#txtXproject1').attr('disabled','disabled');
					$('#txtXproject2').attr('disabled','disabled');
					$('#Xproject').css('height','0px');
				}
				
				$('#txtXacc1a').change(function(e) {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                	if(patt.test($(this).val()))
                    	$(this).val($(this).val().replace(patt,"$1.$2"));
                    else if((/^(\d{4})$/).test($(this).val())){
                    	$(this).val($(this).val()+'.');
                    }
        		});
        		$('#txtXacc2a').change(function(e) {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                	if(patt.test($(this).val()))
                    	$(this).val($(this).val().replace(patt,"$1.$2"));
                    else if((/^(\d{4})$/).test($(this).val())){
                    	$(this).val($(this).val()+'.');
                    }
        		});
        		$('#txtYacc1a').change(function(e) {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                	if(patt.test($(this).val()))
                    	$(this).val($(this).val().replace(patt,"$1.$2"));
                    else if((/^(\d{4})$/).test($(this).val())){
                    	$(this).val($(this).val()+'.');
                    }
        		});
        		$('#txtYacc2a').change(function(e) {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                	if(patt.test($(this).val()))
                    	$(this).val($(this).val().replace(patt,"$1.$2"));
                    else if((/^(\d{4})$/).test($(this).val())){
                    	$(this).val($(this).val()+'.');
                    }
        		});
        		$('#btnOk').hide();
        		$('#btnOk2').click(function(e){
        			var patt = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
        			var t_date1 = $.trim($('#txtDate1').val());
        			var t_date2 = $.trim($('#txtDate2').val());
        			
        			string = (parseInt(t_date1.substring(0,3))+1911)+t_date1.substring(3);
               		if(t_date1.length==0){
               			alert('請輸入起始日期。');
               			return;
               		}
               		else if(!patt.test(string)){
               			alert(t_date1+' 日期異常。');
               			return;
               		}
               		string = (parseInt(t_date2.substring(0,3))+1911)+t_date2.substring(3);
               		if(t_date2.length==0){
               			alert('請輸入終止日期。');
               			return;
               		}
               		else if(!patt.test(string)){
               			alert(t_date2+' 日期異常。');
               			return;
               		}
               		var d1 = new Date(parseInt(t_date1.substr(0, 3)) + 1911, parseInt(t_date1.substring(4, 6)) - 1, parseInt(t_date1.substring(7, 9)));
               		var d2 = new Date(parseInt(t_date2.substr(0, 3)) + 1911, parseInt(t_date2.substring(4, 6)) - 1, parseInt(t_date2.substring(7, 9)));
               		if(d2 < d1){
               			alert('日期異常：終止日期<起始日期。');
               			return;
               		}
               		if((Math.abs(d2 - d1) / (1000 * 60 * 60 * 24) + 1)>366){
               			alert('查詢日數不得大於３６６天。');
               			return;
               		}	
        			$('#btnOk').click();
        		});
        		q_popAssign();
        		q_langShow();
        		
        		if(q_getPara('acc.lockPart')=='1' && r_rank<8){
		        	$("#chkXpart").children('input').attr('Disabled','Disabled');
		        	$("#chkXpart").children('input')[0].disabled=false;
		        	$('#chkXpart').children('input').prop('checked',false);
		        	for(var i=0;i<$('#chkXpart').children('input').length;i++){
		        		if ($('#chkXpart').children('input')[i].value==r_partno || i==0){
		        			$('#chkXpart').children('input')[i].checked=true;
		        		}
		        	}
		        }
            }
            function q_boxClose(t_name) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;width:50px;height:30px;" value="查詢"/>
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>