<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
		aPop = new Array(['txtTcarno1', '', 'car2', 'a.noa,driverno,driver', 'txtTcarno1', 'car2_b.aspx'],
						 ['txtTcarno2', '', 'car2', 'a.noa,driverno,driver', 'txtTcarno2', 'car2_b.aspx']
		);
            t_item = "";
           	
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_car2');
            });
            function q_gfPost() {
                 q_gt('carteam', '', 0, 1, 0, "");
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
            	  switch (t_name) {
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }    
                        break;
                  }
                     if(t_item.length>0 ){
	                $('#q_report').q_report({
	                    fileName : 'z_car2',
                        options : [{
                            type : '1',
                            name : 'mon'
                        }, {
                            type : '1',
                            name : 'date'
                        }, {
                            type : '2',
                            name : 'cardeal',
                            dbf : 'cardeal',
                            index : 'noa,comp',
                            src : 'cardeal_b.aspx'
                        }, {
                            type : '2',
                            name : 'carowner',
                            dbf : 'carowner',
                            index : 'noa,namea',
                            src : 'carowner_b.aspx'
                        }, {
                            type : '2',
                            name : 'driver',
                            dbf : 'driver',
                            index : 'noa,namea',
                            src : 'driver_b.aspx'
                        }, {
                            type : '2',
                            name : 'sss',
                            dbf : 'sss',
                            index : 'noa,namea',
                            src : 'sss_b.aspx'
                        }, {
	                        type : '8', //select
	                        name : 'xcarteamno',
	                        value : t_item.split(',')
	                    }, {
                            type : '6',
                            name : 'xcarno'
                        }, {
                            type : '6',
                            name : 'enddate'
                        }, {
                            type : '1',
                            name : 'Tcarno'
                        }, {
                            type : '6',
                            name : 'xmon'
                        },{
                            type : '2',
                            name : 'carinsurer',
                            dbf : 'insurer',
                            index : 'noa,comp',
                            src : 'insurer_b.aspx'
                        },{
                            type : '2',
                            name : 'carspec',
                            dbf : 'carspec',
                            index : 'noa,spec',
                            src : 'carspec_b.aspx'
                        }, {
	                        type : '8', //select
	                        name : 'pdate',
	                        value : ('遷出,報廢,繳銷,報停').split(',')
	                    }, {
	                        type : '8', //select
	                        name : 'sssno',
	                        value : ('070120,070121,070122').split(',')
	                    }, {
	                        type : '6',
	                        name : 'xcarnos'
	                    }, {
                            type : '1',
                            name : 'xmoney'
                        }, {
	                        type : '5', //select
	                        name : 'xorder',
	                        value : ('車號,金額').split(',')
                    	}, {
	                        type : '5', //select
	                        name : 'zorder',
	                        value : ('車主,金額').split(',')
                    	}, {
	                        type : '6',
	                        name : 'xmemo'
	                    }, {
	                        type : '5', //select
	                        name : 'yorder',
	                        value : ('車行,車主,驗車日期').split(',')
                    	}, {
                            type : '2',
                            name : 'caritemno',
                            dbf : 'caritem',
                            index : 'noa,item',
                            src : 'caritem_b.aspx'
                        }, {
	                        type : '5', //select
	                        name : 'worder',
	                        value : ('車牌,車行,車主').split(',')
                    	}]
                    });
                    q_getFormat();
	                q_langShow();
	                q_popAssign();
					$('#txtMon1').mask('999/99');
	                $('#txtMon2').mask('999/99');
	                $('#txtXmon').mask('999/99');
	                $('#txtDate1').mask('999/99/99');
	                $('#txtDate1').datepicker();
	                $('#txtDate2').mask('999/99/99');
	                $('#txtDate2').datepicker(); 
	                t_item = "";
	                $('#chkXcarteamno').children('input').attr('checked','checked')
	                $('#txtEnddate').mask('999/99/99');
	                $('#txtEnddate').datepicker(); 
	                $('#txtEnddate').val(q_date());
	                $('#txtXmoney1').val(-99999999);
	                $('#txtXmoney2').val(99999999);

	                var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                $('#txtMon1').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                $('#txtMon2').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                $('#txtXmon').val(t_year+'/'+t_month);
	                
	                
	                var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
	                
	                $('#chkSssno').children('input').attr('checked', 'checked');
	                
	                //---------------------------車行
	                $('#txtCardeal1a').blur(function() {
                    	if(emp($('#txtCardeal1a').val())){
                    		$('#txtCardeal1b').val('');
                    	}
                    	if(emp($('#txtCardeal2a').val())&&!emp($('#txtCardeal1a').val())){
                    		$('#txtCardeal2a').val($('#txtCardeal1a').val());
                    		$('#txtCardeal2b').val($('#txtCardeal1b').val());
                    	}
                    	$('#btnOk').click()
                	});
                	$('#txtCardeal2a').blur(function() {
                    	if(emp($('#txtCardeal2a').val())){
                    		$('#txtCardeal2b').val('');
                    	}
                    	$('#btnOk').click()
                	});
                	//---------------------------
                	//---------------------------車主
                	$('#txtCarowner1a').blur(function() {
                    	if(emp($('#txtCarowner1a').val())){
                    		$('#txtCarowner1b').val('');
                    	}
                    	if(emp($('#txtCarowner2a').val())&&!emp($('#txtCarowner1a').val())){
                    		$('#txtCarowner2a').val($('#txtCarowner1a').val());
                    		$('#txtCarowner2b').val($('#txtCarowner1b').val());
                    	}
                    	$('#btnOk').click()
                	});
                	$('#txtCarowner2a').blur(function() {
                    	if(emp($('#txtCarowner2a').val())){
                    		$('#txtCarowner2b').val('');
                    	}
                    	$('#btnOk').click()
                	});
                	//---------------------------
                	//---------------------------車種樣式
                	$('#txtCarspec1a').blur(function() {
                    	if(emp($('#txtCarspec1a').val())){
                    		$('#txtCarspec1b').val('');
                    	}
                    	if(emp($('#txtCarspec2a').val())&&!emp($('#txtCarspec1a').val())){
                    		$('#txtCarspec2a').val($('#txtCarspec1a').val());
                    		$('#txtCarspec2b').val($('#txtCarspec1b').val());
                    	}
                    	$('#btnOk').click()
                	});
                	$('#txtCarspec2a').blur(function() {
                    	if(emp($('#txtCarspec2a').val())){
                    		$('#txtCarspec2b').val('');
                    	}
                    	$('#btnOk').click()
                	});
                	//---------------------------
                	//---------------------------保險公司
                	$('#txtCarinsurer1a').blur(function() {
                    	if(emp($('#txtCarinsurer1a').val())){
                    		$('#txtCarinsurer1b').val('');
                    	}
                    	if(emp($('#txtCarinsurer2a').val())&&!emp($('#txtCarinsurer1a').val())){
                    		$('#txtCarinsurer2a').val($('#txtCarinsurer1a').val());
                    		$('#txtCarinsurer2b').val($('#txtCarinsurer1b').val());
                    	}
                    	$('#btnOk').click()
                	});
                	$('#txtCarinsurer2a').blur(function() {
                    	if(emp($('#txtCarinsurer2a').val())){
                    		$('#txtCarinsurer2b').val('');
                    	}
                    	$('#btnOk').click()
                	});
                	$('#txtTcarno1').blur(function() {
                    	if(emp($('#txtTcarno2').val())){
                    		$('#txtTcarno2').val($('#txtTcarno1').val());
                    	}
                    	$('#btnOk').click()
                	});
					//---------------------------
            	//----------------多車欄位設定----------------
            	$('#Xcarnos').css("width","410px");
            	$('#txtXcarnos').css("width","320px");
            	$('#txtXcarnos').focus(function() {
            		q_msg( $(this), '輸入格式為：車牌.車牌.車牌.......');
                }).blur(function () {
					q_msg();
					$('#btnOk').click()
	        	});
            	//----------------------------------
            	//---------------結尾欄位設定-------------------
            	$('#Xmemo').css("width","410px");
            	$('#txtXmemo').css("width","320px");
            	$('#txtXmemo').blur(function() {
                    	$('#btnOk').click()
               	});
            	//-----------------------------
            	}
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>