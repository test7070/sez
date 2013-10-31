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
                $('#cartax').hide();
                $('#carnotice').hide();
                
                q_cmbParse("combTax", ('').concat(new Array( '01@上期牌照稅','02@下期牌照稅','03@春季燃料稅','04@夏季燃料稅','05@秋季燃料稅','06@冬季燃料稅')));
                		
                $('#btnMontax').click(function() {
                	if(!emp($('#textYear').val())){
                		var montaxhtml='1=1';
                		switch ($('#combTax').val()) {
                			case '01':
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('上',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='501' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                			break;
                			case '02':
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('下',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='501' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                			break;
                			case '03':
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('春',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                			break;
                			case '04':
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('夏',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                			break;
                			case '05':
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('秋',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                			break;
                			case '06':
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('冬',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                			break;
                		}
                		q_box((montaxhtml), 'cartax', "90%", "600px", q_getMsg("popCartax"));
                	}
                });
                
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
		            	
					//婉容說不要顯示報停20130603
                	q_box("carnotice.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";(a.checkdate between '"+xbdate+"' and '"+xedate+"' ) "+sss_sql+" and (a.enddate='' or a.enddate is null) and (a.outdate='' or a.outdate is null) and (a.wastedate='' or a.wastedate is null) and (a.suspdate='' or a.suspdate is null);"+r_accy,
                		 'car2', "90%", "600px", q_getMsg("popNotice"));
                });
                
                $('#q_report').click(function(e) {
                	if($(".select")[0].nextSibling.innerText=='監理稅金收單表'){
                		$('#cartax').show();
                	}else{
                		$('#cartax').hide();
                	}
                	if($(".select")[0].nextSibling.innerText=='驗車查詢'){
                		$('#carnotice').show();
                	}else{
                		$('#carnotice').hide();
                	}
                	
                });
            });
            
            function q_gfPost() {
                 q_gt('carteam', '', 0, 1, 0, "");
                 q_gt('sss', "where=^^ partno='07'^^" , 0, 0, 0, "", r_accy);
                 q_gt('cardeal', '', 0, 1, 0, "");
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
			var sssno='',xcardealno='';
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
            		case 'cardeal':
                        var as = _q_appendData("cardeal", "", true);
                        for( i = 0; i < as.length; i++) {
                            xcardealno = xcardealno + (xcardealno.length>0?',':'') + as[i].noa +'@' + as[i].comp;
                        }
                        q_cmbParse("combCardealno", xcardealno);
                        break;
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }    
                        break;
                  }
                     if(t_item.length>0 &&xcardealno.length>0&&sssno.length>0){
	                $('#q_report').q_report({
	                    fileName : 'z_car2',
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
                        }, {/*6-[11][12]-管理人員*/
                            type : '2',
                            name : 'sss',
                            dbf : 'sss',
                            index : 'noa,namea',
                            src : 'sss_b.aspx'
                        }, {/*7-[13]-車隊*/
	                        type : '8', //select
	                        name : 'xcarteamno',
	                        value : t_item.split(',')
	                    }, {/*8-[14]-車牌*/
                            type : '6',
                            name : 'xcarno'
                        }, {/*9-[15]-截止日期*/
                            type : '6',
                            name : 'enddate'
                        }, {/*10-[16][17]-車牌號碼*/
                            type : '1',
                            name : 'Tcarno'
                        }, {/*11-[18]-月份*/
                            type : '6',
                            name : 'xmon'
                        },{/*12-[19][20]-保險公司*/
                            type : '2',
                            name : 'carinsurer',
                            dbf : 'insurer',
                            index : 'noa,comp',
                            src : 'insurer_b.aspx'
                        },{/*13-[21][22]-車種樣式*/
                            type : '2',
                            name : 'carspec',
                            dbf : 'carspec',
                            index : 'noa,spec',
                            src : 'carspec_b.aspx'
                        }, {/*14-[23]-列印*/
	                        type : '8', //select
	                        name : 'pdate',
	                        value : ('遷出,報廢,繳銷,報停').split(',')
	                    }, {/*15-[24]-管理帳號*/
	                        type : '8', //select
	                        name : 'sssno',
	                        value : (sssno).split('.')
	                    }, {/*16-[25]-多車*/
	                        type : '6',
	                        name : 'xcarnos'
	                    }, {/*17-[26][27]-金額範圍*/
                            type : '1',
                            name : 'xmoney'
                        }, {/*18-[28]-排序依車號、金額*/
	                        type : '5', //select
	                        name : 'xorder',
	                        value : ('車號,金額').split(',')
                    	}, {/*19-[29]-排序依車主、金額*/
	                        type : '5', //select
	                        name : 'zorder',
	                        value : ('車主,金額').split(',')
                    	}, {/*20-[30]結尾*/
	                        type : '6',
	                        name : 'xmemo'
	                    }, {/*21-[31]-排序依車行、車主、驗車日期*/
	                        type : '5', //select
	                        name : 'yorder',
	                        value : ('車行,車主,驗車日期').split(',')
                    	}, {/*22 -[32]-科目名稱*/
                            type : '2',
                            name : 'caritemno',
                            dbf : 'caritem',
                            index : 'noa,item',
                            src : 'caritem_b.aspx'
                        }, {/*23-[33]-排序依車牌、車行、車主*/
	                        type : '5', //select
	                        name : 'worder',
	                        value : ('車牌,車行,車主').split(',')
                    	}, {/*24-[34]-年度*/
                            type : '6',
                            name : 'xyear'
                        }, {/*25-[35]稅金*/
                            type : '5',
                            name : 'cartax',
                            value : ('全部,上期牌照稅,下期牌照稅,春季燃料費,夏季燃料費,秋季燃料費,冬季燃料費').split(',')
                        }, {/*26-[36]已收單、未收單*/
	                        type : '5', //select
	                        name : 'sheetyn',
	                        value : ('已收單,未收單').split(',')
	                    },{/*27-[37]*/
							type : '0',
							name : 'xaccy',
							value : r_accy
						}, {/*28-[37]內帳*/
	                        type : '5', //select
	                        name : 'iacc',
	                        value : ('顯示,不顯示').split(',')
	                    }, {/*29-[38]車種種類*/
                            type : '6',
                            name : 'xspecno'
                        }, {/*30-[39]未付立帳*/
	                        type : '8', //select
	                        name : 'carc',
	                        value : ('未付立帳').split('.')
	                    }]
                    });
                    q_getFormat();
	                q_langShow();
	                q_popAssign();
	                $('#textYear').mask('999');
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
	                $('#chkXcarteamno').children('input').attr('checked','checked')
	                $('#txtEnddate').mask('999/99/99');
	                $('#txtEnddate').datepicker(); 
	                $('#txtEnddate').val(q_date());
	                $('#txtXmoney1').val(-99999999);
	                $('#txtXmoney2').val(99999999);
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
                	//---------------------------
                	//---------------------------車種樣式
                	$('#txtCarspec1a').blur(function() {
                    	if(emp($('#txtCarspec1a').val())){
                    		$('#txtCarspec1b').val('');
                    	}
                    	//if(emp($('#txtCarspec2a').val())&&!emp($('#txtCarspec1a').val())){
                    		$('#txtCarspec2a').val($('#txtCarspec1a').val());
                    		$('#txtCarspec2b').val($('#txtCarspec1b').val());
                    	//}
                	});
                	$('#txtCarspec2a').blur(function() {
                    	if(emp($('#txtCarspec2a').val())){
                    		$('#txtCarspec2b').val('');
                    	}
                	});
                	//---------------------------
                	//---------------------------保險公司
                	$('#txtCarinsurer1a').blur(function() {
                    	if(emp($('#txtCarinsurer1a').val())){
                    		$('#txtCarinsurer1b').val('');
                    	}
                    	//if(emp($('#txtCarinsurer2a').val())&&!emp($('#txtCarinsurer1a').val())){
                    		$('#txtCarinsurer2a').val($('#txtCarinsurer1a').val());
                    		$('#txtCarinsurer2b').val($('#txtCarinsurer1b').val());
                    	//}
                	});
                	$('#txtCarinsurer2a').blur(function() {
                    	if(emp($('#txtCarinsurer2a').val())){
                    		$('#txtCarinsurer2b').val('');
                    	}
                	});
                	$('#txtTcarno1').blur(function() {
                    	//if(emp($('#txtTcarno2').val())){
                    		$('#txtTcarno2').val($('#txtTcarno1').val());
                    	//}
                	});
					//---------------------------
					//---------------------------科目名稱
                	$('#txtCaritemno1a').blur(function() {
                    	if(emp($('#txtCaritemno1a').val())){
                    		$('#txtCaritemno1b').val('');
                    	}
                    	//if(emp($('#txtCarspec2a').val())&&!emp($('#txtCarspec1a').val())){
                    		$('#txtCaritemno2a').val($('#txtCaritemno1a').val());
                    		$('#txtCaritemno2b').val($('#txtCaritemno1b').val());
                    	//}
                	});
                	$('#txtCaritemno2a').blur(function() {
                    	if(emp($('#txtCaritemno2a').val())){
                    		$('#txtCaritemnosb').val('');
                    	}
                	});
                	//---------------------------
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
            	
                $('#textYear').val(q_date().substr(0,3));
                $('#btnMontax').val('監理稅金收單作業');
                
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
			<div id="cartax">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:300px">
					<tr>
						<td align="center" style="width:35%"><a id="lblxYear" class="lbl">年度</a></td>
						<td align="left" style="width:65%"><input id="textYear"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td align="center" style="width:35%"><a id="lblxTax" class="lbl">稅金</a></td>
						<td align="left" style="width:65%"><select id="combTax" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td align="center" style="width:35%"><a id="lblxCardealno" class="lbl">車行</a></td>
						<td align="left" style="width:65%"><select id="combCardealno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input id="btnMontax" type="button" />
						</td>
					</tr>
				</table>
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