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
           	var t_init=false;
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_car2');
                $('#cartax').hide();
                $('#carnotice').hide();
          
                q_cmbParse("combTax", ('').concat(new Array( '01@上期牌照稅','02@下期牌照稅','03@春季燃料稅','04@夏季燃料稅','05@秋季燃料稅','06@冬季燃料稅')));
                
                $('#btnWebPrint').click(function(e) {
					var t_index = $('#q_report').data('info').radioIndex;
                    var txtreport = $('#q_report').data('info').reportData[t_index].report;
                    
                    if(txtreport=='z_cara1' || txtreport=='z_cara3' || txtreport=='z_cara4'){
                    	var bmon=!emp($('#txtMon1').val())?$('#txtMon1').val():'#non';
		                var emon=!emp($('#txtMon2').val())?$('#txtMon2').val():'#non';
		                var bcarowner=!emp($('#txtCarowner1a').val())?$('#txtCarowner1a').val():'#non';
		                var ecarowner=!emp($('#txtCarowner2a').val())?$('#txtCarowner2a').val():'#non';
						var bcarno=!emp($('#txtTcarno1').val())?$('#txtTcarno1').val():'#non';
		                var ecarno=!emp($('#txtTcarno2').val())?$('#txtTcarno2').val():'#non';
		                var xcarno=!emp($('#txtXcarnos').val())?$('#txtXcarnos').val():'#non';
		                	
						var t_where = bmon+ ';' + emon+ ';' + bcarowner+ ';' + ecarowner+ ';' + bcarno+ ';' + ecarno+ ';' + xcarno;
                    	q_func('qtxt.query', 'caraprint.txt,print,' + t_where);
                    }
                    
				});
                		
                $('#btnMontax').click(function() {
                	if(!emp($('#textYear').val())){
                		var montaxhtml='1=1';
                		//1030924 避免早期資料出現的問題 當年度102以上101之前的資料不顯示
                		var notyear=dec($('#textYear').val())>=102?" and a.mon >='102/01' ":'';
                		switch ($('#combTax').val()) {
                			case '01':
                				//montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('上',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='501' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('上',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and CHARINDEX('"+$('#textYear').val()+"',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and caritemno='501' and b.cardealno='"+$('#combCardealno').val()+"'"+notyear+" order by a.carno;"+r_accy;
                			break;
                			case '02':
                				//montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('下',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='501' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('下',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and CHARINDEX('"+$('#textYear').val()+"',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and caritemno='501' and b.cardealno='"+$('#combCardealno').val()+"'"+notyear+" order by a.carno;"+r_accy;
                			break;
                			case '03':
                				//montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('春',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('春',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and CHARINDEX('"+$('#textYear').val()+"',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"'"+notyear+" order by a.carno;"+r_accy;
                			break;
                			case '04':
                				//montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('夏',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('夏',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and CHARINDEX('"+$('#textYear').val()+"',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"'"+notyear+" order by a.carno;"+r_accy;
                			break;
                			case '05':
                				//montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('秋',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('秋',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and CHARINDEX('"+$('#textYear').val()+"',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"'"+notyear+" order by a.carno;"+r_accy;
                			break;
                			case '06':
                				//montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('冬',a.memo)>0 and CHARINDEX('"+$('#textYear').val()+"',a.memo)>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"' order by a.carno;"+r_accy;
                				montaxhtml="cartax_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";CHARINDEX('冬',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and CHARINDEX('"+$('#textYear').val()+"',left(a.memo,case when CHARINDEX('#',a.memo)>0 then CHARINDEX('#',a.memo)-1 else len(a.memo) end))>0 and caritemno='502' and b.cardealno='"+$('#combCardealno').val()+"'"+notyear+" order by a.carno;"+r_accy;
                			break;
                		}
                		q_box((montaxhtml), 'cartax', "90%", "600px", $('#btnMontax').val());
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
                		 'car2', "90%", "600px", $('#btnNotice').val());
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
                	
                	now_report=$('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report;
					if(now_report=='z_car27'){
						$('#lblXmon').text('截止月份');
					}else{
						$('#lblXmon').text(q_getMsg("lblXmon"));
						if(emp($('#txtXmon').val()))
							$('#txtXmon').val(q_date().substr(0,6));
					}
					
					if(window.parent.q_name!='z_anacara' && now_report=='z_car27'){
						$('#Xmon').hide();
					}
					
					var t_proj=q_getPara('sys.project').toUpperCase();
					
					 if(t_proj!='DC' && t_proj!='EFB' && t_proj!='SH'){
                        for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
                            if(
                            	$('#q_report').data().info.reportData[i].report=='z_cara1' //車主欠款明細
	                            || $('#q_report').data().info.reportData[i].report=='z_cara3' //車主欠款明細(含信封)
	                            || $('#q_report').data().info.reportData[i].report=='z_cara4' //車主欠款明細(A4)
	                            || $('#q_report').data().info.reportData[i].report=='z_car25' //高額欠款追蹤依車號
	                            || $('#q_report').data().info.reportData[i].report=='z_car26' //高額欠款追蹤依車主
	                            || $('#q_report').data().info.reportData[i].report=='z_car22' //貸款查詢依車行
	                            || $('#q_report').data().info.reportData[i].report=='z_car24' //貸款查詢依車主
	                            || $('#q_report').data().info.reportData[i].report=='z_car30' //車行欠款總表
	                            || $('#q_report').data().info.reportData[i].report=='z_backup1' //車主勞健保費用明細
	                            || $('#q_report').data().info.reportData[i].report=='z_car33' //車主資產負債估算表
	                            || $('#q_report').data().info.reportData[i].report=='z_car37' //監理稅金收單表
	                            || $('#q_report').data().info.reportData[i].report=='z_car39' //車牌投保薪資表
	                            || ($('#q_report').data().info.reportData[i].report=='z_car2_22') //通行證查詢
	                            || $('#q_report').data().info.reportData[i].report=='z_carpack' //車輛車位數量統計表
	                            || $('#q_report').data().info.reportData[i].report=='z_car35' //收支日報明細表
	                            || $('#q_report').data().info.reportData[i].report=='z_car38' //車主未兌現票據
	                            || $('#q_report').data().info.reportData[i].report=='z_car38' //車主未兌現票據
	                            || $('#q_report').data().info.reportData[i].report=='z_car34' //標誌申請表
                            ){ 
                                $('#q_report div div').eq(i).hide();
							}
                        }
                        
                        $('#q_report div div .radio').first().removeClass('nonselect').addClass('select');
                    }else{
                    	if(t_proj=='DC'){
                    		 for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
	                            if($('#q_report').data().info.reportData[i].report=='z_car2_22'){
	                                 $('#q_report div div').eq(i).hide();
	                                 break;
								}
	                        }
	                        $('#q_report div div .radio').first().removeClass('nonselect').addClass('select');
	                        $('#Xinsuresheet').hide();
                    	}
                    }
                });
            });
            
            function q_gfPost() {
                 q_gt('carteam', '', 0, 0, 0, "");
                 q_gt('sss', "where=^^ partno='07'^^" , 0, 0, 0, "", r_accy);
                 q_gt('cardeal', '', 0, 0, 0, "");
                 q_gt('carspec', '', 0, 0, 0, "");
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
					case 'carbrand':
						ret = getb_ret();
                        if(ret==null)
                        	return;
                        var xcarbrand='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xcarbrand+=ret[i].noa+'.'
                        	}
                        }
                        xcarbrand=xcarbrand.substr(0,xcarbrand.length-1);
                        $('#txtXcarbrand').val(xcarbrand);
						break;
                }   /// end Switch
				b_pop = '';
            }
            var iscarno=0;
			var sssno='',xcardealno='',carspec_arr=[],xcarspec='';
			var x_t_item=false,x_xcardealno=false,x_sssno=false,x_xcarspec=false;
            function q_gtPost(t_name) {
            	  switch (t_name) {
            	  	case 'carspec':
            	  		carspec_arr = _q_appendData("carspec", "", true);
            	  		xcarspec='.';
            	  		x_xcarspec=true;
            	  		break;
            	  	case 'sss':
            			var as = _q_appendData("sss", "", true);
            			for (var i = 0; i < as.length; i++) {
            				sssno+=as[i].noa+'.';
            			}
            			sssno=sssno.substr(0,sssno.length-1);
            			$('#textSSSno').val(sssno);
            			x_sssno=true;
            		break;
            		case 'cardeal':
                        var as = _q_appendData("cardeal", "", true);
                        for( i = 0; i < as.length; i++) {
                            xcardealno = xcardealno + (xcardealno.length>0?',':'') + as[i].noa +'@' + as[i].comp;
                        }
                        if(xcardealno.length>0)
                        	q_cmbParse("combCardealno", xcardealno);
                        x_xcardealno=true;
                        break;
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }
                        x_t_item=true;
                        break;
                  }
                     if(!t_init && x_t_item && x_xcardealno && x_sssno && x_xcarspec){
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
                    	}, {/*22 -[32][33]-科目名稱*/
                            type : '2',
                            name : 'caritemno',
                            dbf : 'caritem',
                            index : 'noa,item',
                            src : 'caritem_b.aspx'
                        }, {/*23-[34]-排序依車牌、車行、車主*/
	                        type : '5', //select
	                        name : 'worder',
	                        value : ('車牌,車行,車主').split(',')
                    	}, {/*24-[35]-年度*/
                            type : '6',
                            name : 'xyear'
                        }, {/*25-[36]稅金*/
                            type : '5',
                            name : 'cartax',
                            value : ('全部,上期牌照稅,下期牌照稅,春季燃料費,夏季燃料費,秋季燃料費,冬季燃料費').split(',')
                        }, {/*26-[37]已收單、未收單*/
	                        type : '5', //select
	                        name : 'sheetyn',
	                        value : ('已收單,未收單').split(',')
	                    },{/*-[38]*/
							type : '0',
							name : 'xaccy',
							value : r_accy
						}, {/*27-[39]內帳*/
	                        type : '5', //select
	                        name : 'iacc',
	                        value : ('顯示,不顯示').split(',')
	                    }, {/*28-[40]車種種類*/
                            type : '6',
                            name : 'xspecno'
                        }, {/*29-[41]未付立帳*/
	                        type : '8', //select
	                        name : 'carc',
	                        value : ('未付立帳').split('.')
	                    }, {/*30-[42]-列印*/
	                        type : '8', //select
	                        name : 'prdate',
	                        value : ('遷入,遷出,報廢,繳銷,報停').split(',')
	                    }, {/*31-[43][44]-年份*/
                            type : '1',
                            name : 'xcaryear'
                        }, {/*32-[45]廠牌多選*/
                            type : '6',
                            name : 'xcarbrand'
                        }, {/*33-[46]-排序*/
	                        type : '5', //select
	                        name : 'vorder',
	                        value : ('車行,年份,廠牌').split(',')
                    	},{/*-[47]*/
							type : '0',
							name : 'xproj',
							value : q_getPara('sys.project').toUpperCase()
						},{/*-[48]-保單號碼*/
                            type : '6',
                            name : 'xinsuresheet'
                        }, {/*[49]-檢驗日期*/
                            type : '5', //select
                            name : 'checktype',
                            value : ('驗車,黑煙,行車紀錄器').split(',')
                        }]
                    });
                    t_init=true;
                    q_getFormat();
	                q_langShow();
	                q_popAssign();
	                $('#textYear').mask(r_pic);
	            	$('#textBdate').mask(r_picd);
	                $('#textEdate').mask(r_picd);
					$('#txtMon1').mask(r_picm);
	                $('#txtMon2').mask(r_picm);
	                $('#txtXmon').mask(r_picm);
	                $('#txtDate1').mask(r_picd);
	                $('#txtDate1').datepicker();
	                $('#txtDate2').mask(r_picd);
	                $('#txtDate2').datepicker(); 
	                t_item = "";
	                $('#chkXcarteamno').children('input').attr('checked','checked')
	                $('#txtEnddate').mask(r_picd);
	                $('#txtEnddate').datepicker(); 
	                $('#txtEnddate').val(q_date());
	                $('#txtXmoney1').val(-99999999);
	                $('#txtXmoney2').val(99999999);
	                $('#txtXyear').mask(r_pic);
					$('#txtXyear').val(q_date().substr(0,r_len));
	                $('#txtMon1').val(q_date().substr(0,r_lenm));
	                $('#txtMon2').val(q_date().substr(0,r_lenm));
	                $('#txtXmon').val(q_date().substr(0,r_lenm));
	                
	                $('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
	                $('#textBdate').val(q_date().substr(0,r_lenm)+'/01');
	                
	                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
	                $('#textEdate').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
	                
	                //$('#chkSssno').children('input').attr('checked', 'checked');
	                
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
            	$('#txtXcarnos').css("width","300px");
            	$('#txtXcarnos').focus(function() {
            		q_msg( $(this), '輸入格式為：車牌.車牌.車牌.......');
                }).blur(function () {
					q_msg();
	        	});
            	//----------------------------------
            	//---------------結尾欄位設定-------------------
            	$('#Xmemo').css("width","410px");
            	$('#txtXmemo').css("width","300px");
            	$('#txtXmemo').focus(function() {
            		q_msg( $(this), '使用【單引號】請使用【兩個單引號】；使用【雙引號】請此用【\\"】');
                }).blur(function () {
					q_msg();
	        	});
            	//-----------------------------
            	}
            	
                $('#textYear').val(q_date().substr(0,r_len));
                $('#btnMontax').val('監理稅金收單作業');
                
                $('#btnNotice').val('驗車通知作業');
                if(iscarno<4){
	                if(window.parent.q_name=='cara' || window.parent.q_name=='car2'){
	                	var wParent = window.parent.document;
						$('#txtTcarno1').val(wParent.getElementById("txtCarno").value);
						$('#txtTcarno2').val(wParent.getElementById("txtCarno").value);
						iscarno++;
					}
				}
				$('#Xspecno').css("width","410px");
				$('#txtXspecno').css("width","300px");
				$('#lblXspecno').css("color","#0000ff");
				$('#lblXspecno').click(function(e) {
                	q_box("carspec_b2.aspx?;;;;", 'carspec', "90%", "600px", q_getMsg("popCarspec"));
                });
                
                $('#lblXcarbrand').css("color","#0000ff");
                $('#lblXcarbrand').click(function(e) {
                	q_box("carbrand_b2.aspx?;;;;", 'carbrand', "90%", "600px", q_getMsg("popCarbrand"));
                });
                
                if(window.parent.q_name=='carpack')
                	$('#q_report').find('span.radio').eq(13).parent().click();
                	
                if(window.parent.q_name=='z_anacara' &&$('#q_report').data().info!=undefined){
                	var t_para=q_getId()[3].split(' and ');
                	//[0]報表[1]月份[2]員工[3...]其他參數
                	var t_report=replaceAll(t_para[0],"report='","");
                	t_report=t_report.substr(0,t_report.length-1);
                	var t_mon=replaceAll(t_para[1],"mon='","");
                	t_mon=t_mon.substr(0,t_mon.length-1);
                	var t_sssno=replaceAll(t_para[2],"sssno='","");
                	t_sssno=t_sssno.substr(0,t_sssno.length-1);
					var wParent = window.parent.document;
	                $('#txtCardeal1a').val(wParent.getElementById("txtCardeal1a").value);
					$('#txtCardeal1b').val(wParent.getElementById("txtCardeal1b").value);
					$('#txtCardeal2a').val(wParent.getElementById("txtCardeal2a").value);
					$('#txtCardeal2b').val(wParent.getElementById("txtCardeal2b").value);
					
					var t_index=0;
					for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
						if($('#q_report').data('info').reportData[i].report==t_report){
							t_index=i;
							break;	
						}
					}
					$('#q_report').find('span.radio').eq(t_index).parent().click();
					
					$('#chkSssno input').each(function(index) {
						if(t_sssno.indexOf($(this).val())>-1)
							$(this).prop('checked',true);
						else
							$(this).prop('checked',false);
					});
					
                	if(t_report=='z_car27'){
						$('#txtXmon').val(t_mon);
						$('#txtEnddate').val('');
						
						var t_specno=replaceAll(t_para[3],"specno='","");
                		t_specno=t_specno.substr(0,t_specno.length-1);
                		xcarspec='';
						for (var i = 0; i < carspec_arr.length; i++) {
							if(t_specno=='B'){
								if(carspec_arr[i].noa.substr(0,1)=='B')
									xcarspec+=carspec_arr[i].noa+'.';	
							}else{
								if(carspec_arr[i].noa.substr(0,1)=='A' || carspec_arr[i].noa.substr(0,1)=='C')
									xcarspec+=carspec_arr[i].noa+'.';
							}
            			}
            			xcarspec=xcarspec.substr(0,xcarspec.length-1);
						$('#txtXspecno').val(xcarspec);
						
						var t_diff=replaceAll(t_para[4],"diff='","");
                		t_diff=t_diff.substr(0,t_diff.length-1);
						if(t_diff=='Y' || t_diff=='X'){
							var t_bmon=replaceAll(t_para[5],"bmon='","");
                			t_bmon=t_bmon.substr(0,t_bmon.length-1);
							
							$('#txtDate1').val(t_bmon+'/01');
							$('#txtDate2').val(q_cdn(q_cdn(t_mon+'01',45).substr(0,r_lem)+'/01',-1));
							
							$("#chkPrdate input").prop('checked',true)	
						}
						if(t_diff=='X'){
							xcarspec='';
							for (var i = 0; i < carspec_arr.length; i++) {
								if(carspec_arr[i].noa.substr(0,1)=='A' || carspec_arr[i].noa.substr(0,1)=='B' || carspec_arr[i].noa.substr(0,1)=='C')
									xcarspec+=carspec_arr[i].noa+'.';
	            			}
	            			xcarspec=xcarspec.substr(0,xcarspec.length-1);
							$('#txtXspecno').val(xcarspec);
						}
						
                	}
                	if(t_report=='z_car35'){						
						var t_caritemno=replaceAll(t_para[3],"caritemno='","");
                		t_caritemno=t_caritemno.substr(0,t_caritemno.length-1);
                		var t_caritem=replaceAll(t_para[4],"caritem='","");
                		t_caritem=t_caritem.substr(0,t_caritem.length-1);
                		var t_isdate=replaceAll(t_para[5],"isdate='","");
                		t_isdate=t_isdate.substr(0,t_isdate.length-1);
                		
                		$('#txtCaritemno1a').val(t_caritemno);
                		$('#txtCaritemno1b').val(t_caritem);
                		$('#txtCaritemno2a').val(t_caritemno);
                		$('#txtCaritemno2b').val(t_caritem);
                		
                		if(t_isdate=='N'){
	                		$('#txtDate1').val('');
							$('#txtDate2').val('');
							$('#txtMon1').val(t_mon);
							$('#txtMon2').val(t_mon);
						}else{
							$('#txtDate1').val(wParent.getElementById("txtDate1").value);
							$('#txtDate2').val(wParent.getElementById("txtDate2").value);
							$('#txtMon1').val('');
							$('#txtMon2').val('');	
						}
                	}
                	
                	if(t_report=='z_car26'){
						$('#txtXmon').val(t_mon);
                	}
                	
                	if(t_report=='z_cara1'){
                		var t_carno=replaceAll(t_para[3],"carno='","");
                		t_carno=t_carno.substr(0,t_carno.length-1);
						$('#txtMon1').val(t_mon);
						$('#txtMon2').val(t_mon);
						$('#txtTcarno1').val(t_carno);
						$('#txtTcarno2').val(t_carno);
                	}
                	
                	$('#btnOk').click();
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