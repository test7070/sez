<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "cug";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtStation','txtProcess','txtGenorg','txtHours','txtKdate','txtSmount'];
            var q_readonlys = ['txtProductno','txtProduct','txtSpec','txtStyle','txtDays','txtMount','txtWorkno','txtOrgcuadate','txtOrguindate','txtOrdeno','txtWorkgno','txtThours'];
            var bbmNum = [['txtSmount', 10, 0, 1]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'uca', 'noa,product', 'txtProductno_,txtProduct_', 'uca_b.aspx']
            ,['txtStationno', 'lblStation', 'station', 'noa,station,mount,gen', 'txtStationno,txtStation,txtSmount,txtGenorg', 'station_b.aspx']
            ,['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
			
			var work_chk=false;
			var t_cugt=undefined;//儲存cugt的資料
            function mainPost() {
                bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd]];
                bbsMask = [['txtCuadate', r_picd],['txtUindate', r_picd],['txtNos', '9999']];
                q_getFormat();
                q_mask(bbmMask);
                
                $('#txtDatea').blur(function() {
					if(emp($('#txtBdate').val()) && (q_cur==1 || q_cur==2)){
						$('#txtBdate').val($('#txtDatea').val());
					}
				});
				
				$('#btnCugt').click(function() {
					q_box("cugt.aspx?;;;noa='" + $('#txtNoa').val() + "' and stationno='"+$('#txtStationno').val()+"'", 'cugt', "60%", "65%", q_getMsg("btnCugt"));
				});
				
                $('#btnWork').click(function() {
                	if(emp($('#txtDatea').val())){
                		alert(q_getMsg('lblDatea')+'請先填寫。');
                		return;
                	}
                	
                	if(emp($('#txtStationno').val())){
                		alert(q_getMsg('lblStation')+'請先填寫。');
                		return;
                	}
                	
                	if(work_chk){
                		var t_where = "where=^^ ";
                		if(!emp($('#txtProcessno').val()))
                			t_where=t_where+"a.processno='"+$('#txtProcessno').val()+"' and ";
                		if(!emp($('#txtOrdeno').val()))
                			t_where=t_where+"charindex('"+$('#txtOrdeno').val()+"',a.ordeno)>0 and ";
                		if(!emp($('#txtBdate').val()) || !emp($('#txtEdate').val())){
                			var t_bdate='',t_edate='';
                			t_bdate=$('#txtBdate').val();
                			t_edate=!emp($('#txtEdate').val())?$('#txtEdate').val():'999/99/99';
                			t_where=t_where+"(a.cuadate between '"+t_bdate+"' and '"+t_edate+"' ) and ";
                		}
                		t_where=t_where+"a.stationno='"+$('#txtStationno').val()+"' and isnull(a.enda,'0')!='1' and isnull(a.isfreeze,'0')!='1' and ";
                		t_where=t_where+"a.noa not in (select workno from view_cugs where noa !='"+$('#txtNoa').val()+"' and issel='1') ";
                		//排序
                		t_where=t_where+"order by noq,issel ^^";
                		
                		
                		var t_where1 = "where[1]=^^ ";
                		if(!emp($('#txtProcessno').val()))
                			t_where1=t_where1+"processno='"+$('#txtProcessno').val()+"' and ";
                		if(!emp($('#txtOrdeno').val()))
                			t_where1=t_where1+"charindex('"+$('#txtOrdeno').val()+"',ordeno)>0 and ";
                		if(!emp($('#txtBdate').val()) || !emp($('#txtEdate').val())){
                			var t_bdate='',t_edate='';
                			t_bdate=$('#txtBdate').val();
                			t_edate=!emp($('#txtEdate').val())?$('#txtEdate').val():'999/99/99';
                			t_where1=t_where1+"((cuadate between '"+t_bdate+"' and '"+t_edate+"' ) or uindate >='"+t_bdate+"') and ";
                		}
                		t_where1=t_where1+"stationno='"+$('#txtStationno').val()+"' and isnull(issel,'0')='1' ^^";
                		
						q_gt('cug_work', t_where+t_where1, 0, 0, 0, "", r_accy);
						
						$('#txtDatea').attr('disabled', 'disabled');
						$('#txtStationno').attr('disabled', 'disabled');
						$('#lblStationk').css('display', 'inline').text($('#lblStation').text());
						$('#lblStation').css('display', 'none');
						work_chk=false;
                	}else{
                		q_gt('cug', "where=^^datea='"+$('#txtDatea').val()+"' and stationno='"+$('#txtStationno').val()+"' and noa!='"+$('#txtNoa').val()+"'^^", 0, 0, 0, "cug_chk", r_accy);
                	}
                });
                
                //禮拜六是否要上班
                var issaturday=q_getPara('sys.saturday')=='1'?true:false;
                $('#btnCug').click(function() {
                	$('#btnCug').attr('disabled', 'disabled');
                	//一般產能時數//var t_gen=dec($('#txtGen').val())<=0?dec($('#txtGenorg').val()):dec($('#txtGen').val());
                	var t_genorg=dec($('#txtGenorg').val());
                	var t_gen=dec($('#txtGenorg').val());
                	
                	//取得上次的排程剩餘時數(計算已工作時數)與日期，排除工時
                	var dhours=0,ddate=$('#txtDatea').val(),tt_hours=0;
                	for (var i = 0; i < q_bbsCount; i++) {
                		//判斷非本次的noq
                		if($('#txtNos_'+i).attr('disabled') && $('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','')){
                			dhours=dec($('#txtDhours_'+i).val());
                			ddate=$('#txtUindate_'+i).val();
                			tt_hours=q_add(tt_hours,q_float('txtHours_'+i));
                			//累計工時
	                		$('#txtThours_'+i).val(tt_hours);
                		}
                	}
                	
                	//取得編制時數
                	if(t_cugt==undefined){
                		q_gt('view_cugt', "where=^^stationno='"+$('#txtStationno').val()+"' and datea>='"+ddate+"' ^^", 0, 0, 0, "cugt", r_accy);
                		return;
                	}
                	
                	//取得當天gen
                	for (var k = 0; k < t_cugt.length; k++) {
                		if(t_cugt[k].datea==ddate)
                			t_gen=dec(t_cugt[k].gen);
                	}
                	
                	dhours=q_sub(t_gen,dhours)%t_gen;//非本次排程已工作時數
                	
                	for (var i = 0; i < q_bbsCount; i++) {
                		var t_hours=0;//工作時數
                		//本次排程
                		if($('#chkIssel_'+i).prop('checked')&&!$('#txtNos_'+i).attr('disabled') && $('#txtNoq_'+i).val().substr(0,7)==replaceAll($('#txtDatea').val(), '/','')){
	                		for (var j = 0; j < q_bbsCount; j++) {	
	                			if($('#chkIssel_'+j).prop('checked') && $('#txtNoq_'+j).val().substr(0,7)==replaceAll($('#txtDatea').val(), '/','') && $('#txtNoq_'+i).val()>$('#txtNoq_'+j).val()){
			            				t_hours=q_add(t_hours,q_float('txtHours_'+j));//已工作時數(不含該行排程)
			            		}
	                		}
	                		
	                		var ttt_hours=q_add(t_hours,dhours);//暫存已工作時數
	                		var tt_ddate=ddate;//暫存開工日
	                		//開工日
	                		//固定產能//var days=Math.floor(q_div(q_add(t_hours,dhours),t_gen));//$('#txtCuadate_'+i).val(q_cdn(ddate,days));
	                		while(ttt_hours>=0){
	                			//取得當天gen
	                			t_gen=t_genorg;
                				for (var k = 0; k < t_cugt.length; k++) {
			                		if(t_cugt[k].datea==tt_ddate)
			                			t_gen=dec(t_cugt[k].gen);
			                	}
			                	ttt_hours=q_sub(ttt_hours,t_gen);
			                	if(ttt_hours>=0){
	                				tt_ddate=q_cdn(tt_ddate,1);
	                				//判斷一般禮拜六是不是不要上班
	                				if(!issaturday&&new Date(dec(tt_ddate.substr(0,3))+1911,dec(tt_ddate.substr(4,2))-1,dec(tt_ddate.substr(7,2))).getDay()==6){
	                					//判斷是否有加班
	                					var addwork=false;
	                					for (var k = 0; k < t_cugt.length; k++) {
					                		if(t_cugt[k].datea==tt_ddate)
					                			addwork=true;
					                	}
					                	if(!addwork)
	                						tt_ddate=q_cdn(tt_ddate,1);
	                				}
	                				//判斷日
	                				if(new Date(dec(tt_ddate.substr(0,3))+1911,dec(tt_ddate.substr(4,2))-1,dec(tt_ddate.substr(7,2))).getDay()==0){
	                					//判斷是否有加班
	                					var addwork=false;
	                					for (var k = 0; k < t_cugt.length; k++) {
					                		if(t_cugt[k].datea==tt_ddate)
					                			addwork=true;
					                	}
					                	if(!addwork)
	                						tt_ddate=q_cdn(tt_ddate,1);
	                				}
	                			}
	                		}
	                		$('#txtCuadate_'+i).val(tt_ddate);
	                		
	                		//完工日
	                		//固定產能//days=Math.floor(q_div(q_add(q_add(t_hours,dhours),dec($('#txtHours_'+i).val())),t_gen));//$('#txtUindate_'+i).val(q_cdn(ddate,days));
	                		ttt_hours=q_add(ttt_hours,dec($('#txtHours_'+i).val()))
	                		while(ttt_hours>0){
	                			if(ttt_hours>=0){
	                				tt_ddate=q_cdn(tt_ddate,1);
	                				//判斷一般禮拜六是不是不要上班
	                				if(!issaturday&&new Date(dec(tt_ddate.substr(0,3))+1911,dec(tt_ddate.substr(4,2))-1,dec(tt_ddate.substr(7,2))).getDay()==6){
	                					//判斷是否有加班
	                					var addwork=false;
	                					for (var k = 0; k < t_cugt.length; k++) {
					                		if(t_cugt[k].datea==tt_ddate)
					                			addwork=true;
					                	}
					                	if(!addwork)
	                						tt_ddate=q_cdn(tt_ddate,1);
	                				}
	                				//判斷日
	                				if(new Date(dec(tt_ddate.substr(0,3))+1911,dec(tt_ddate.substr(4,2))-1,dec(tt_ddate.substr(7,2))).getDay()==0){
	                					//判斷是否有加班
	                					var addwork=false;
	                					for (var k = 0; k < t_cugt.length; k++) {
					                		if(t_cugt[k].datea==tt_ddate)
					                			addwork=true;
					                	}
					                	if(!addwork)
	                						tt_ddate=q_cdn(tt_ddate,1);
	                				}
	                			}
	                			//取得當天gen
	                			t_gen=t_genorg;
                				for (var k = 0; k < t_cugt.length; k++) {
			                		if(t_cugt[k].datea==tt_ddate)
			                			t_gen=dec(t_cugt[k].gen);
			                	}
			                	ttt_hours=q_sub(ttt_hours,t_gen);
	                		}
	                		$('#txtUindate_'+i).val(tt_ddate);
	                		
	                		//剩餘時數
	                		//固定產能//$('#txtDhours_'+i).val(q_sub(t_gen,q_add(q_add(t_hours,dhours),dec($('#txtHours_'+i).val()))%t_gen));
	                		$('#txtDhours_'+i).val(Math.abs(ttt_hours));
	                		
	                		//累計工時
	                		$('#txtThours_'+i).val(q_add(q_add(t_hours,dec($('#txtHours_'+i).val())),tt_hours));
                		}
                	}
                	
                	//排序處理
                	//儲存有排序的資料,清除整個欄位
                	var t_bbs=new Array();
                	for (var i = 0; i < q_bbsCount; i++) {
                		if($('#chkIssel_'+i).prop('checked')){
                			var t_bbss=new Array();
                			for (var j = 0; j < fbbs.length; j++) {
                				t_bbss[fbbs[j]]=fbbs[j].substr(0,3)=='chk'?$('#'+fbbs[j]+'_'+i).prop('checked'):$('#'+fbbs[j]+'_'+i).val();
                			}
                			t_bbs.push(t_bbss);
                		}
						$('#btnMinus_'+i).click();
						//解除disabled
						for (var j = 0; j < fbbs.length; j++) {
							if($.inArray(fbbs[j],q_readonlys)==-1){
								$('#'+fbbs[j]+'_'+i).removeAttr('disabled');
							}
						}
					}
					
                	//最先做的放前面(依noq)
                	if(t_bbs.length!=0){
	                	for (var i = 0; i < q_bbsCount; i++) {
	                		var minnoq='',min_j=0;//目前最小noq,與資料位置
	                		for (var j = 0; j < t_bbs.length; j++) {
	                			if(minnoq==''){
	                				minnoq=t_bbs[j].txtNoq
	                				min_j=0;
	                			}else{
	                				if(minnoq>t_bbs[j].txtNoq){
	                					minnoq=t_bbs[j].txtNoq;
	                					min_j=j;
	                				}
	                			}
	                		}
	                		for (var j = 0; j < fbbs.length; j++) {
	                			if(fbbs[j].substr(0,3)=='chk')
	                				$('#'+fbbs[j]+'_'+i).prop('checked',t_bbs[min_j][fbbs[j]]);
	                			else
	                				$('#'+fbbs[j]+'_'+i).val(t_bbs[min_j][fbbs[j]]);
	                		}
	                		//移除最小資料
	                		t_bbs.splice(min_j, 1);
	                		//如果暫存沒資料就跳出
	                		if(t_bbs.length==0)
	                			break;
						}
					}
					//重新鎖定資料
                	for (var i = 0; i < q_bbsCount; i++) {
						if($('#chkIssel_'+i).prop('checked')){	//判斷是否被選取
							$('#trSel_'+ i).addClass('chkIssel');//變色
						}else{
							$('#trSel_'+i).removeClass('chkIssel');//取消變色
						}
								
						if($('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','') &&$('#txtNoq_'+i).val().substr(0,7)!=''){
							for(var j=0;j<fbbs.length;j++){
								$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
							}
							$('#btnMinus_'+i).attr('disabled', 'disabled');
						}
						$('#txtCuadate_'+i).attr('disabled', 'disabled');
						$('#txtUindate_'+i).attr('disabled', 'disabled');
						
						if(!emp($('#txtWorkno_'+i).val())){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						}else{
							$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
						}
					}
                	sum();
                	t_cugt=undefined;//計算完清除cugt的資料
                	$('#btnCug').removeAttr('disabled');
                });
                
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'cugt':
                		t_cugt = _q_appendData("view_cugt", "", true);
                		$('#btnCug').click();
                		break;
                	case 'cug_chk':
                		var as = _q_appendData("cug", "", true);
                		if(as[0]!=undefined){
                			alert("該工作中心【"+$('#txtDatea').val()+"】的排程已存在!!");
                		}else{
                			work_chk=true;
                			$('#btnWork').click();
                		}
                		break;
                	case 'cug_btnok':
                		var as = _q_appendData("cug", "", true);
                		if(as[0]!=undefined){
                			alert("該工作中心【"+$('#txtDatea').val()+"】的排程已存在!!");
                		}else{
                			cng_btnok=true;
                			$('#btnOk').click();
                		}
                		break;
                	case 'cug_work':
                		var as = _q_appendData("view_cugs", "", true);
                		if(as[0]!=undefined){
                			//0421因加訂單匯入 所以要判斷是否已被匯入
                			for (var i = 0; i < q_bbsCount; i++) {
								for (var j = 0; j < as.length; j++) {
									if($('#txtWorkno_' + i).val()==as[j].workno){
										as.splice(j, 1);
                                    	j--;
										break;	
									}
								}
							}
                			
                			/*for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_'+i).click();
							}*/
                			for ( var i = 0; i < as.length; i++) {
                				if(as[i].issel=='true')
                					q_bbs_addrow('bbs', q_bbsCount-1, 1);
                				if(as[i].noq=='99999999999')
                					as[i].noq='';
                			}
                			
                			q_gridAddRow(bbsHtm, 'tbbs'
							,'txtNos,txtNoq,chkIssel,txtProcessno,txtProcess,txtProductno,txtProduct,txtSpec,txtStyle,txtMount,txtHours,txtDays,txtCuadate,txtUindate,txtOrgcuadate,txtOrguindate,txtWorkno,txtWorkgno,txtOrdeno,txtDhours', as.length, as,
							'nos,noq,issel,processno,process,productno,product,spec,style,mount,hours,days,cuadate,uindate,orgcuadate,orguindate,workno,workgno,ordeno,dhours','txtProductno');
							for (var i = 0; i < q_bbsCount; i++) {
								if($('#chkIssel_'+i).prop('checked')){	//判斷是否被選取
					               	$('#trSel_'+ i).addClass('chkIssel');//變色
					            }else{
					            	$('#trSel_'+i).removeClass('chkIssel');//取消變色
								}
								
								if($('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','') &&$('#txtNoq_'+i).val().substr(0,7)!=''){
									for(var j=0;j<fbbs.length;j++){
										$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
									}
									$('#btnMinus_'+i).attr('disabled', 'disabled');
								}
								
								$('#txtCuadate_'+i).attr('disabled', 'disabled');
								$('#txtUindate_'+i).attr('disabled', 'disabled');
								
							}
							sum();
                		}
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
			
			var cng_btnok=false;
            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtStationno', q_getMsg('lblStation')], ['txtDatea', q_getMsg('lblDatea')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(!cng_btnok){
                	q_gt('cug', "where=^^datea='"+$('#txtDatea').val()+"' and stationno='"+$('#txtStationno').val()+"' and noa!='"+$('#txtNoa').val()+"'^^", 0, 0, 0, "cug_btnok", r_accy);
                	return;
                }
                
                //處理有排程但沒有nos的資料
                for (var i = 0; i < q_bbsCount; i++) {
                	if ($('#chkIssel_'+i).prop('checked')&&emp($('#txtNos_'+i).val())&&!emp($('#txtWorkno_'+i).val())){
                		$('#txtNos_'+i).val(('000'+(dec(getmaxnos(i).substr(0,3))+1)).substr(-3)+'0');
                		$('#txtNoq_'+i).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+i).val());
                	}
                }
                
                //處理有排程但沒有noq的資料
                for (var i = 0; i < q_bbsCount; i++) {
                	if ($('#chkIssel_'+i).prop('checked')&&emp($('#txtNoq_'+i).val())&&!emp($('#txtNos_'+i).val())&&!emp($('#txtWorkno_'+i).val())){
                		$('#txtNoq_'+i).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+i).val());
                	}
                }
                
                //檢查排程序號是否重複
                for (var i = 0; i < q_bbsCount; i++) {
                	for (var j = i+1; j < q_bbsCount; j++) {
                		if (i!=j &&$('#chkIssel_'+i).prop('checked')&&$('#chkIssel_'+j).prop('checked')&&$('#txtNoq_'+i).val()==$('#txtNoq_'+j).val()){
                			alert(q_getMsg('lblNoq_s')+'['+$('#txtNos_'+i).val()+']重覆')
                			return;
                		}
                	}
                }
                
                $('#btnCug').click();
                
                sum();
                
                cng_btnok=false;
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cug') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cug_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtKdate').val(q_date());
                $('#txtDatea').focus();
                
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').attr('disabled', 'disabled');
				$('#txtStationno').attr('disabled', 'disabled');
				$('#lblStationk').css('display', 'inline').text($('#lblStation').text());
				$('#lblStation').css('display', 'none');
				for (var i = 0; i < q_bbsCount; i++) {
					if($('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','') &&$('#txtNoq_'+i).val().substr(0,7)!=''){
						for(var j=0;j<fbbs.length;j++){
							$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
						}
						$('#btnMinus_'+i).attr('disabled', 'disabled');
					}
				}
            }

            function btnPrint() {
                q_box('z_cugp.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }
			
			var issave=false;
            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
                issave=true;
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtWorkno_'+i).click(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtWorkno_' + b_seq).val())){
								t_where = "noa='"+$('#txtWorkno_' + b_seq).val()+"'";
								q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
							}
		                });
		                $('#txtCuadate_'+i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtCuadate_' + b_seq).val()) && !emp($('#txtUindate_' + b_seq).val()) && (q_cur == 1 || q_cur == 2)){
								if($('#txtCuadate_' + b_seq).val()>$('#txtUindate_' + b_seq).val()){
									alert(q_getMsg('lblWorkdate_s')+'大於'+q_getMsg('lblEnddate_s'));
									$('#txtCuadate_' + b_seq).val('').focusin();
									return;
								}
								
								$('#txtDays_' + b_seq).val(DateDiff($('#txtCuadate_' + b_seq).val(),$('#txtUindate_' + b_seq).val())+1);
							}
		                });
		                $('#txtUindate_'+i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtCuadate_' + b_seq).val()) && !emp($('#txtUindate_' + b_seq).val()) && (q_cur == 1 || q_cur == 2)){
								if($('#txtCuadate_' + b_seq).val()>$('#txtUindate_' + b_seq).val()){
									alert(q_getMsg('lblWorkdate_s')+'大於'+q_getMsg('lblEnddate_s'));
									$('#txtUindate_' + b_seq).val('').focusin();
									return;
								}
								
								$('#txtDays_' + b_seq).val(DateDiff($('#txtCuadate_' + b_seq).val(),$('#txtUindate_' + b_seq).val())+1);
							}
		                });
		                
		                $('#txtNos_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                	if(q_cur==1 || q_cur==2){
		                		if($('#chkIssel_'+b_seq).prop('checked') && (!emp($('#txtProcess_'+b_seq).val()) || !emp($('#txtWorkno_'+b_seq).val()))){
		                			//處理noq的資料
		                			if(emp($('#txtNos_'+b_seq).val())){
		                				$('#txtNos_'+b_seq).val(('000'+(dec(getmaxnos(b_seq).substr(0,3))+1)).substr(-3)+'0');
		                				$('#txtNoq_'+b_seq).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+b_seq).val());
		                			}else{
						                $('#txtNoq_'+b_seq).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+b_seq).val());
						                //檢查排程序號是否重複
						                for (var j = 0; j < q_bbsCount; j++) {
						                	if (b_seq!=j &&$('#chkIssel_'+j).prop('checked')&&$('#txtNoq_'+b_seq).val()==$('#txtNoq_'+j).val()){
						                		alert(q_getMsg('lblNoq_s')+'['+$('#txtNos_'+b_seq).val()+']重覆')
						                		$('#txtNos_'+b_seq).val(('000'+(dec(getmaxnos(b_seq).substr(0,3))+1)).substr(-3)+'0');
							               		$('#txtNoq_'+b_seq).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+b_seq).val());
						                		break;
						                	}
						                }
					                }
		                		}else{
		                			 $('#txtNoq_'+b_seq).val('');
		                		}
		                	}
						});
						
						$('#txtProcess_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                	if(q_cur==1 || q_cur==2){
		                		if($('#chkIssel_'+b_seq).prop('checked') && (!emp($('#txtProcess_'+b_seq).val()) || !emp($('#txtWorkno_'+b_seq).val()))){
		                			//檢查nos 有沒有資料
		                			if(emp($('#txtNos_'+b_seq).val())){
		                				$('#txtNos_'+b_seq).val(('000'+(dec(getmaxnos(b_seq).substr(0,3))+1)).substr(-3)+'0');
		                				$('#txtNoq_'+b_seq).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+b_seq).val());
		                			}else{
		                				//處理noq的資料
					                	$('#txtNoq_'+b_seq).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+b_seq).val());
					                	
					                	//檢查排程序號是否重複
						                for (var j = 0; j < q_bbsCount; j++) {
						                	if (b_seq!=j &&$('#chkIssel_'+j).prop('checked')&&$('#txtNoq_'+b_seq).val()==$('#txtNoq_'+j).val()){
						                		alert(q_getMsg('lblNoq_s')+'['+$('#txtNos_'+b_seq).val()+']重覆')
						                		$('#txtNos_'+b_seq).val(('000'+(dec(getmaxnos(b_seq).substr(0,3))+1)).substr(-3)+'0');
							               		$('#txtNoq_'+b_seq).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+b_seq).val());
						                		break;
						                	}
						                }
		                			}
		                			$('#trSel_'+ b_seq).addClass('chkIssel');//變色
		                		}else{
		                			 $('#txtNoq_'+b_seq).val('');
		                		}
		                	}
						});
		                
		                $('#chkIssel_' + i).click(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#chkIssel_'+b_seq).prop('checked')&&(!emp($('#txtWorkno_'+b_seq).val()) || !emp($('#txtProcess_'+b_seq).val()))){	//判斷是否被選取
								$('#trSel_'+ b_seq).addClass('chkIssel');//變色
								//判斷是否是當天排程的資料
								if($('#txtNoq_'+ b_seq).val()=='' || $('#txtNoq_'+ b_seq).val().substr(0,7)==replaceAll($('#txtDatea').val(), '/','')){
									$('#txtNos_'+ b_seq).val(('000'+(dec(getmaxnos(b_seq).substr(0,3))+1)).substr(-3)+'0');
									$('#txtNoq_'+ b_seq).val(replaceAll($('#txtDatea').val(), '/','')+$('#txtNos_'+ b_seq).val());
								}
							}else{
				                $('#trSel_'+b_seq).removeClass('chkIssel');//取消變色
				                $('#txtCuadate_'+b_seq).val('');
				                $('#txtUindate_'+b_seq).val('');
				                $('#txtThours_'+b_seq).val('');
							}
							sum();
						});
                    }
                }
                _bbsAssign();
				
				for (var i = 0; i < q_bbsCount; i++) {
					if($('#chkIssel_'+i).prop('checked') && (!emp($('#txtWorkno_'+i).val()) || !emp($('#txtProcess_'+i).val()))){	//判斷是否被選取
						$('#trSel_'+ i).addClass('chkIssel');//變色
					}else{
						$('#trSel_'+i).removeClass('chkIssel');//取消變色
					}
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					$('#txtUindate_'+i).attr('disabled', 'disabled');
					
					if(!emp($('#txtWorkno_'+i).val())){
						$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
					}else{
						$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
						$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
					}
					
					if($('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','') &&$('#txtNoq_'+i).val().substr(0,7)!=''){
						for(var j=0;j<fbbs.length;j++){
							$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
						}
						$('#btnMinus_'+i).attr('disabled', 'disabled');
					}
				}
            }
            
            function getmaxnos(seq) {//seq 表示排除的noq
            	var maxnos='0000';
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($('#chkIssel_'+i).prop('checked')&&$('#txtNoq_'+i).val().substr(0,7)==replaceAll($('#txtDatea').val(), '/','')&&i!=dec(seq)&&$('#txtNos_' +i).val()>maxnos){
            			maxnos=$('#txtNos_' +i).val();
            		}
            	}
            	return maxnos;
            }

            function bbsSave(as) {
                if (as['issel']=="false" || !as['noq'] ) {//不存檔條件
                    as[bbsKey[1]] = '';
                    return;
                }
				
				as['stationno'] = abbm2['stationno'];
				as['station'] = abbm2['station'];
                q_nowf();

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount;
                for (var j = 0; j < q_bbsCount; j++) {
					if($('#chkIssel_'+j).prop('checked')){
						t1=q_add(t1,q_float('txtHours_'+j));
					}
                } // j
                $('#txtHours').val(t1);
            }

            function refresh(recno) {
            	if(issave){
            		var s2=new Array('cug_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
					q_boxClose2(s2);
					issave=false;
				}
                _refresh(recno);
                for (var i = 0; i < q_bbsCount; i++) {
		        	if($('#chkIssel_'+i).prop('checked')){	//判斷是否被選取
		               	$('#trSel_'+ i).addClass('chkIssel');//變色
		            }else{
		            	$('#trSel_'+i).removeClass('chkIssel');//取消變色
					}
					if(!emp($('#txtWorkno_'+i).val())){
						$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
					}else{
						$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
						$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
					}
					if($('#txtNoq_'+i).val()!=undefined){
						if($('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','') &&$('#txtNoq_'+i).val().substr(0,7)!=''){
							for(var j=0;j<fbbs.length;j++){
								$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
							}
							$('#btnMinus_'+i).attr('disabled', 'disabled');
						}
					}
				}
				$('#lblStation').css('display', 'inline');
				$('#lblStationk').css('display', 'none');
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(t_para){
	            	$('#btnWork').attr('disabled', 'disabled');
	            	$('#btnCug').attr('disabled', 'disabled');
	            	$('#btnCugt').attr('disabled', 'disabled');
	            }else{
	            	$('#btnWork').removeAttr('disabled');
	            	$('#btnCug').removeAttr('disabled');
	            	$('#btnCugt').removeAttr('disabled');
	            }
                
                if(q_getPara('sys.isstyle')=='1'){
                	$('.isstyle').show();
                	$('.dbbs').css('width','1910px');
                }else{
                	$('.isstyle').hide();
                	$('.dbbs').css('width','1810px');
                }
                
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					$('#txtUindate_'+i).attr('disabled', 'disabled');
					
					if(!emp($('#txtWorkno_'+i).val())){
						$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
					}else{
						if(!t_para){
							$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
						}
					}
					
					if($('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','') &&$('#txtNoq_'+i).val().substr(0,7)!=''){
						for(var j=0;j<fbbs.length;j++){
							$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
						}
						$('#btnMinus_'+i).attr('disabled', 'disabled');
					}
				}
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
            function  DateDiff(beginDate,  endDate){    //beginDate和endDate都是2007-8-10格式
		       var  arrbeginDate,  Date1,  Date2, arrendDate,  iDays  
		       arrbeginDate=  beginDate.split("/")  
		       Date1=  new  Date( arrbeginDate[1]+  '-'  +  arrbeginDate[2]  +  '-'  +  (dec(arrbeginDate[0])+1911))    //轉換為2007-8-10格式
		       arrendDate=  endDate.split("/")  
		       Date2=  new  Date(arrendDate[1]  +  '-'  +  arrendDate[2]  +  '-'  +  (dec(arrendDate[0])+1911))  
		       iDays  =  parseInt(Math.abs(Date1-  Date2)  /  1000  /  60  /  60  /24)    //轉換為天數 
		       return  iDays  
		   }

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
                width: 1280px;
            }
            .dview {
                float: left;
                width: 30%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 875px;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                /*width: 9%;*/
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 48%;
                float: right;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 100%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
                width: 95%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm select {
                font-size: medium;
            }
            .dbbs {
                width: 1900px;
                background:#cad3ff;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs tr.chkIssel { background:bisque;} 
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:30%"><a id='vewStation'> </a></td>
						<td align="center" style="width:30%"><a id='vewProcess'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='station'>~station</td>
						<td align="center" id='process'>~process</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1" style="width: 105px;"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2" style="width: 206px;"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td3" style="width: 105px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4" style="width: 176px;"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td5" style="width: 105px;"><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td class="td6" style="width: 176px;"><input id="txtKdate"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStation' class="lbl btn"> </a><a id='lblStationk' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtStationno"  type="text" class="txt c2"/>
							<input id="txtStation"  type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id='lblGenorg' class="lbl"> </a></td>
						<td class="td4"><input id="txtGenorg"  type="text" class="txt num c1"/></td>
						<!--<td class="td5"><span> </span><a id='lblGen' class="lbl"> </a></td>
						<td class="td6"><input id="txtGen"  type="text" class="txt num c1"/></td>-->
						<td class="td3"><span> </span><a id='lblSmount' class="lbl"> </a></td>
						<td class="td4"><input id="txtSmount"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblProcess' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtProcessno"  type="text" class="txt c2"/>
							<input id="txtProcess"  type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
						<td class="td4"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorkgno' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorkgno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCuadate' class="lbl"> </a></td>
						<td class="td2">
							<input id="txtBdate"  type="text" class="txt c2" style="width: 46%;"/><a style="float: left;">~</a>
							<input id="txtEdate"  type="text" class="txt c2" style="width: 46%;"/>
						</td>
						<td class="td3" ><span> </span><a id='lblHours' class="lbl"> </a></td>
						<td class="td4"><input id="txtHours"  type="text" class="txt num c1"/></td>
						<td class="td5"><input id="btnWork" type="button" style="float: right;"/></td>
						<td class="td5">
							<input id="btnCug" type="button" style="float: center;"/>
							<input id="btnCugt" type="button" style="float: center;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input id="txtMemo"  type="text" class="txt c5"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<!--<td class="td3"><span> </span><a id="lblIsset"> </a></td>
						<td class="td4"><input id="chkIsset" type="checkbox" /></td>-->
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:31px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />	</td>
					<td align="center" style="width:36px;"><a id='lblIssel_s'> </a></td>
					<td align="center" style="width:75px;"><a id='lblNoq_s'> </a></td>
					<td align="center" style="width:145px;"><a id='lblProductno_s'> </a>/<a id='lblProcess_s'> </a></td>
					<td align="center" style="width:275px;"><a id='lblProduct_s'> </a>/<a id='lblSpec_s'> </a></td>
					<td align="center" class="isstyle" style="width:100px;"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblHours_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblDays_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblOrgcuadate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblOrguindate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblCuadate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblUindate_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblThours_s'> </a></td>
					<td align="center" style="width:160px;"><a id='lblWorkno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblOrdeno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblWorkgno_s'> </a></td>
					<!--<td align="center"><a id='lblMemo_s'> </a></td>-->
				</tr>
				<tr id="trSel.*">
					<td align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td align="center"><input id="chkIssel.*" type="checkbox"/></td>
					<td>
						<input id="txtNos.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" class="txt c1"/>
						<input id="txtStationno.*" type="hidden" class="txt c1"/>
						<input id="txtStation.*" type="hidden" class="txt c1"/>
					</td>
					<td>
						<input id="txtProductno.*" type="text" class="txt c1"/>
						<input id="txtProcess.*" type="text" class="txt c1"/>
						<input id="txtProcessno.*" type="hidden" class="txt c1"/>
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1"/>
					</td>
					<td class="isstyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtHours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDays.*" type="text" class="txt num c1"/></td>
					<td><input id="txtOrgcuadate.*" type="text" class="txt c1"/></td>
					<td><input id="txtOrguindate.*" type="text" class="txt c1"/></td>
					<td><input id="txtCuadate.*" type="text" class="txt c1" style="color: red;"/></td>
					<td><input id="txtUindate.*" type="text" class="txt c1" style="color: red;"/></td>
					<td>
						<input id="txtThours.*" type="text" class="txt c1"/>
						<input id="txtDhours.*" type="hidden" class="txt c1"/>
					</td>
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
					<td><input id="txtWorkgno.*" type="text" class="txt c1"/></td>
					<!--<td><input id="txtMemo.*" type="text" class="txt c1"/></td>-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
