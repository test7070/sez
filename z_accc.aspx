<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
                isInit : false,
                data : {
                    balacc1 : null
                },
                isLoad : function() {
                    var isLoad = true;
                    for (var x in this.data) {
                        isLoad = isLoad && (this.data[x] != null);
                    }
                    return isLoad;
                }
            };
            t_data = new z_accc();

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_accc');
            });

            function q_gfPost() {
                q_gt('balacc1', '', 0, 0, 0, "");
            }

            function q_gtPost(t_name) {

                switch (t_name) {
                    case 'balacc1':
                        t_data.data['balacc1'] = '';
                        var as = _q_appendData("balacc1", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['balacc1'] += (t_data.data['balacc1'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].balacc1;
                        }
                        break;
                }
                if (t_data.isLoad() && !t_data.isInit) {
                    t_data.isInit = true;
                    $('#q_report').q_report({
                        fileName : 'z_accc',
                        options : [{
                            type : '0',
                            name : 'accy',
                            value : r_accy + "_" + r_cno
                        }, {
                            type : '1',
                            name : 'date'
                        }, {
                            type : '2',
                            name : 'acc',
                            dbf : 'acc',
                            index : 'acc1,acc2',
                            src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                        }, {
                            type : '2',
                            name : 'part',
                            dbf : 'part',
                            index : 'noa,part',
                            src : 'part_b.aspx'
                        }, {
                            type : '1',
                            name : 'xaccc3'
                        }, {
                            type : '6',
                            name : 'xbal'
                        }, {
                            type : '8', //checkbox
                            name : 'xaccc5',
                            value : t_data.data['balacc1'].split(',')
                        }, {
                            type : '8', //checkbox
                            name : 'balance',
                            value : (('').concat(new Array("餘額"))).split(',')
                        },{
                            type : '0',
                            name : 'accty',
                            value : r_accy 
                        }]
                    });
                    q_popAssign();
                    q_langShow();
                    $('#txtDate1').mask('99/99');
                    $('#txtDate2').mask('99/99');
					
					$('#txtAcc1a').change(function(e) {
	                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
	                    	$(this).val($(this).val()+'.');	
	                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
	                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
	                    }
            		});
            		$('#txtAcc2a').change(function(e) {
	                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
	                    	$(this).val($(this).val()+'.');	
	                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
	                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
	                    }
            		});
					/*$('#txtAcc1a').change(function(e) {
						var patt = /(\d{4})([^\.,.]*)$/g;
						$(this).val($(this).val().replace(patt,"$1.$2"));
            		});
            		$('#txtAcc2a').change(function(e) {
	                    var patt = /(\d{4})([^\.,.]*)$/g;
	                    $(this).val($(this).val().replace(patt,"$1.$2"));
            		});*/
                		
                    $('#chkXbalacc1').children('input').attr('checked', 'checked');
                    var t_date, t_year, t_month, t_day;
                    t_date = new Date();
                    t_date.setDate(1);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate1').val(t_month + '/' + t_day);

                    t_date = new Date();
                    t_date.setDate(35);
                    t_date.setDate(0);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate2').val(t_month + '/' + t_day);

                }
            }
			/*function q_popPost(id) {
                switch(id) {
                    case 'txtAcc1a':
                        var patt = /(\d{4})([^\.,.]*)$/g;
						$('#txtAcc1a').val($(this).val().replace(patt,"$1.$2"));
                        break;
                    case 'txtAcc2a':
                        var patt = /(\d{4})([^\.,.]*)$/g;
						$('#txtAcc2a').val($(this).val().replace(patt,"$1.$2"));
                        break;
                }
            }*/
            
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
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>