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
		aPop = new Array(['txtTcarno1', '', 'car2', 'a.noa,carownerno,carowner', 'txtTcarno1', 'car2_b.aspx'],
						 ['txtTcarno2', '', 'car2', 'a.noa,carownerno,carowner', 'txtTcarno2', 'car2_b.aspx']
		);
            t_item = "";
           	
           	var chg_report='';
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_anacara');
                
                $('#q_report').click(function(e) {
					//客戶請款單與應收對帳簡要表>>正常隱藏業務選項>>>不然會造成金額問題
					now_report=$('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report;
					if(now_report=='z_anacara02'){
						$('#lblMon').text('比較月份');
						$('#lblDate').text('收款日期');
						$('#Mon .dash').text('-');
					}else{
						$('#lblMon').text(q_getMsg("lblMon"));
						$('#lblDate').text(q_getMsg("lblDate"));
						$('#Mon .dash').text('~');
					}
					
					
					if(chg_report!=now_report){
						if(now_report=='z_anacara02'){
							if(!emp($('#txtMon2').val()))
								$('#txtMon1').val(('000'+(dec($('#txtMon2').val().substr(0,3))-1)).substr(-3)+$('#txtMon2').val().substr(-3));
						}else if(now_report=='z_anacara03'){
							$('#txtMon1').val(q_date().substr(0,3)+'/01');
							$('#txtMon2').val(q_date().substr(0,3)+'/12');
						}else{
							if(!emp($('#txtDate1').val()))
								$('#txtMon1').val($('#txtDate1').val().substr(0,6));
						}
					}
					chg_report=now_report;
                });
            });
            
            function q_gfPost() {
                 q_gt('sss', "where=^^ partno='07'^^" , 0, 0, 0, "", r_accy);
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	
                }   /// end Switch
				b_pop = '';
            }
            var iscarno=0;
			var sssno='',xcardealno='';
			var init_report=false;
            function q_gtPost(t_name) {
				switch (t_name) {
            	  	case 'sss':
            			var as = _q_appendData("sss", "", true);
            			for (var i = 0; i < as.length; i++) {
            				sssno+=as[i].noa+'.';
            			}
            			sssno=sssno.substr(0,sssno.length-1);
            			$('#textSSSno').val(sssno);
            		break;
				}
				if(sssno.length>0 && !init_report){
	                $('#q_report').q_report({
	                    fileName : 'z_anacara',
                        options : [{/*1-[1][2]-月份*/
                            type : '1',
                            name : 'mon'
                        }, {/*2-[3][4]-日期*/
                            type : '1',
                            name : 'date'
                        }, {/*3-[5][6]-車行*/
                            type : '2',
                            name : 'cardeal',
                            dbf : 'cardeal',
                            index : 'noa,comp',
                            src : 'cardeal_b.aspx'
                        }, {/*4-[7][8]-車主*/
                            type : '2',
                            name : 'carowner',
                            dbf : 'carowner',
                            index : 'noa,namea',
                            src : 'carowner_b.aspx'
                        }, {/*10-[9][10]-車牌號碼*/
                            type : '1',
                            name : 'tcarno'
                        }, {/*15-[11]-管理帳號*/
	                        type : '8', //select
	                        name : 'sssno',
	                        value : (sssno).split('.')
	                    }, {/*17-[12][13]-金額範圍*/
                            type : '1',
                            name : 'xmoney'
                        }, {/*23-[14]-排序依車牌、車行、車主*/
	                        type : '5', //select
	                        name : 'xorder',
	                        value : ('車牌,車行,車主').split(',')
                    	}]
                    });
                    
                    init_report=true;
                    q_getFormat();
	                q_langShow();
	                q_popAssign();
	            	$('#txtDate1').mask('999/99/99');
	                $('#txtDate2').mask('999/99/99');
					$('#txtMon1').mask('999/99');
	                $('#txtMon2').mask('999/99');
	                
	                $('#txtXmoney1').val(-99999999);
	                $('#txtXmoney2').val(99999999);
					
	                var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtMon1').val(t_year+'/'+t_month);
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
	                $('#txtMon2').val(t_year+'/'+t_month);
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
	                
	                $('.report').css('width','480px');
	                $('.report div').css('width','230px');
	                
	                $('#chkSssno').children('input').attr('checked', 'checked');
	                
	                //---------------------------車行
	                $('#txtCardeal1a').blur(function() {
                    	if(emp($('#txtCardeal1a').val())){
                    		$('#txtCardeal1b').val('');
                    	}
                    	//if(emp($('#txtCardeal2a').val())&&!emp($('#txtCardeal1a').val())){
                    		$('#txtCardeal2a').val($('#txtCardeal1a').val());
                    		$('#txtCardeal2b').val($('#txtCardeal1b').val());
                    	//}
                	});
                	$('#txtCardeal2a').blur(function() {
                    	if(emp($('#txtCardeal2a').val())){
                    		$('#txtCardeal2b').val('');
                    	}
                	});
                	//---------------------------
                	//---------------------------車主
                	$('#txtCarowner1a').blur(function() {
                    	if(emp($('#txtCarowner1a').val())){
                    		$('#txtCarowner1b').val('');
                    	}
                    	//if(!emp($('#txtCarowner1a').val())){
                    		$('#txtCarowner2a').val($('#txtCarowner1a').val());
                    		$('#txtCarowner2b').val($('#txtCarowner1b').val());
                    	//}
                	});
                	$('#txtCarowner2a').blur(function() {
                    	if(emp($('#txtCarowner2a').val())){
                    		$('#txtCarowner2b').val('');
                    	}
                	});
                }
            }
		</script>
		<style type="text/css">
			#frameReport table{
					border-collapse: collapse;
				}
		</style>
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