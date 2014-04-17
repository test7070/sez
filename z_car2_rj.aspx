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
           	
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_car2_rj');
                $('#carnotice').hide();
                                
                $('#btnNotice').click(function() {
                	var xbdate=!emp($('#textBdate').val())?$('#textBdate').val():'';
                	var xedate=!emp($('#textEdate').val())?$('#textEdate').val():'999/99/99';
                	var xsssno=!emp($('#textSSSno').val())?$('#textSSSno').val():sssno;
                	var sss_sql='';
                	var sssno_count=0;
                	//檢查最後一個是否有.
                	if(xsssno.substr(xsssno.length-1,xsssno.length)=='.')
                		xsssno=xsssno.substr(0,xsssno.length-1);
                		
                	while(xsssno.indexOf('.')>-1){
                		if(sssno_count==0)
			            	sss_sql+="and (sssno='"+xsssno.substr(0,xsssno.indexOf('.'))+"' "
			            else
			            	sss_sql+="or sssno='"+xsssno.substr(0,xsssno.indexOf('.'))+"' "
			            sssno_count++;
			            xsssno=xsssno.substr(xsssno.indexOf('.')+1,xsssno.length);
                	}
                	
                	if(sssno_count>0)
		            	sss_sql+="or sssno='"+xsssno+"')";
		            else
		            	sss_sql+="and sssno='"+xsssno+"'"
		            	
					//不顯示報停
                	q_box("carnotice.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";(a.checkdate between '"+xbdate+"' and '"+xedate+"' ) "+sss_sql+" and (a.enddate='' or a.enddate is null) and (a.outdate='' or a.outdate is null) and (a.wastedate='' or a.wastedate is null) and (a.suspdate='' or a.suspdate is null);"+r_accy,
                		 'car2', "90%", "600px", q_getMsg("popNotice"));
                });
                
                $('#q_report').click(function(e) {
                	if($(".select")[0].nextSibling.innerText=='驗車查詢'){
                		$('#carnotice').show();
                	}else{
                		$('#carnotice').hide();
                	}
                });
            });
            
            function q_gfPost() {
                 //q_gt('carteam', '', 0, 0, 0, "");
                 q_gt('sss', "where=^^ noa in (select sssno from car2) ^^" , 0, 0, 0, "", r_accy);
                 //q_gt('cardeal', '', 0, 0, 0, "");
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'carspec':
                        ret = getb_ret();
                        if(ret==null)
                        	return;
                        var xcarspec='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xcarspec+=ret[i].noa+'.'
                        	}
                        }
                        xcarspec=xcarspec.substr(0,xcarspec.length-1);
                        $('#txtXspecno').val(xcarspec);
                        break;	
                }   /// end Switch
				b_pop = '';
            }
            var iscarno=0;
			var sssno='';
            function q_gtPost(t_name) {
            	  switch (t_name) {
            	  	case 'sss':
            			var as = _q_appendData("sss", "", true);
            			if (as[0]!=undefined){
            				for (var i = 0; i < as.length; i++) {
            					sssno+=as[i].noa+'.';
	            			}
	            			sssno=sssno.substr(0,sssno.length-1);
            			}else{
            				sssno='無管理人員';
            			}
            			
            			$('#textSSSno').val(sssno);
            		break;
                  }
                  if(sssno.length>0){//
	                $('#q_report').q_report({
	                    fileName : 'z_car2_rj',
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
                        }, {/*5-[9][10]-司機*/
                            type : '2',
                            name : 'driver',
                            dbf : 'driver',
                            index : 'noa,namea',
                            src : 'driver_b.aspx'
                        }, {/*6-[11]-截止日期*/
                            type : '6',
                            name : 'enddate'
                        }, {/*7-[12][13]-車牌號碼*/
                            type : '1',
                            name : 'Tcarno'
                        },{/*8-[14][15]-保險公司*/
                            type : '2',
                            name : 'carinsurer',
                            dbf : 'insurer',
                            index : 'noa,comp',
                            src : 'insurer_b.aspx'
                        },{/*9-[16][17]-車種樣式*/
                            type : '2',
                            name : 'carspec',
                            dbf : 'carspec',
                            index : 'noa,spec',
                            src : 'carspec_b.aspx'
                        }, {/*10-[18]-列印*/
	                        type : '8', //select
	                        name : 'pdate',
	                        value : ('遷出,報廢,繳銷,報停').split(',')
	                    }, {/*11-[19]-管理帳號*/
	                        type : '8', //select
	                        name : 'sssno',
	                        value : (sssno).split('.')
	                    }, {/*12-[20]-多車*/
	                        type : '6',
	                        name : 'xcarnos'
	                    }, {/*13-[21]-排序依車行、車主、驗車日期*/
	                        type : '5', //select
	                        name : 'yorder',
	                        value : ('車行,車主,驗車日期').split(',')
                    	}, {/*14-[22]-年度*/
                            type : '6',
                            name : 'xyear'
                        }, {/*15-[23]車種種類*/
                            type : '6',
                            name : 'xspecno'
                        },{/*[24]*/
                            type : '0',
                            name : 'xcartype',
                            value : q_getPara('car2.cartype')
                        }]
                    });
                    q_getFormat();
	                q_langShow();
	                q_popAssign();
	            	$('#textBdate').mask('999/99/99');
	                $('#textEdate').mask('999/99/99');
					$('#txtMon1').mask('999/99');
	                $('#txtMon2').mask('999/99');
	                $('#txtXmon').mask('999/99');
	                $('#txtDate1').mask('999/99/99');
	                $('#txtDate1').datepicker();
	                $('#txtDate2').mask('999/99/99');
	                $('#txtDate2').datepicker(); 
	                t_item = "";
	                $('#txtEnddate').mask('999/99/99');
	                $('#txtEnddate').datepicker(); 
	                $('#txtEnddate').val(q_date());
	                $('#txtXyear').mask('999');
					$('#txtXyear').val(q_date().substr(0,3));
					
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
	                $('#textBdate').val(t_year+'/'+t_month+'/'+t_day);
	                
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
	                $('#textEdate').val(t_year+'/'+t_month+'/'+t_day);
	                
	                $('#chkSssno').children('input').attr('checked', 'checked');

            	//----------------多車欄位設定----------------
            	$('#Xcarnos').css("width","410px");
            	$('#txtXcarnos').css("width","320px");
            	$('#txtXcarnos').focus(function() {
            		q_msg( $(this), '輸入格式為：車牌.車牌.車牌.......');
                }).blur(function () {
					q_msg();
	        	});
            	//----------------------------------
            	//---------------結尾欄位設定-------------------
            	$('#Xmemo').css("width","410px");
            	$('#txtXmemo').css("width","320px");
            	//-----------------------------
            	}
                
                $('#btnNotice').val('驗車通知作業');
                if(iscarno<3){
	                if(window.parent.q_name=='cara' || window.parent.q_name=='car2'){
	                	var wParent = window.parent.document;
						$('#txtTcarno1').val(wParent.getElementById("txtCarno").value);
						$('#txtTcarno2').val(wParent.getElementById("txtCarno").value);
						iscarno++;
					}
				}
				$('#Xspecno').css("width","410px");
				$('#txtXspecno').css("width","320px");
				$('#lblXspecno').css("color","#0000ff");
				$('#lblXspecno').click(function(e) {
                	q_box("carspec_b2.aspx?;;;;", 'carspec', "90%", "600px", q_getMsg("popCarspec"));
                });
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
			<div id="carnotice">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:300px">
					<tr>
						<td align="center" style="width:35%"><a id="lblxDatea" class="lbl">日期</a></td>
						<td align="left" style="width:65%">
							<input id="textBdate"  type="text"  class="txt" style="width: 40%;"/>~
							<input id="textEdate"  type="text"  class="txt" style="width: 40%;"/>
						</td>
					</tr>
					<tr>
						<td align="center" style="width:35%"><a id="lblxSSSno" class="lbl">管理者</a></td>
						<td align="left" style="width:65%"><input id="textSSSno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input id="btnNotice" type="button" />
						</td>
					</tr>
				</table>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>