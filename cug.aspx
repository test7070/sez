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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "cug";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtStation','txtProcess','txtGenorg','txtHours','txtSmount','txtKdate'];
            var q_readonlys = ['txtProductno','txtProduct','txtSpec','txtStyle','txtMount','txtWorkno','txtOrgcuadate','txtOrguindate','txtOrdeno','txtWorkgno','txtThours','txtPretime'];
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
            })

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
			
			var t_cugt=undefined;//儲存cugt的資料
			var del_cugunoq='';//存檔時刪除已拆分的cugunoq
			//var station_chk=false;
            function mainPost() {
                bbmMask = [['txtBdate', r_picd],['txtEdate', r_picd]];
                bbsMask = [['txtCuadate', r_picd],['txtUindate', r_picd],['txtNos', '9999'],['textDatea', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                
				$('#btnCugt').click(function() {
					//後面針對stationno
					q_box("cugt.aspx?;;;noa='" + $('#txtStationno').val() + "' and stationno='"+$('#txtStationno').val()+"'", 'cugt', "60%", "65%", q_getMsg("btnCugt"));
				});
				
                $('#btnWork').click(function() {
                	if(emp($('#txtStationno').val())){
                		alert(q_getMsg('lblStation')+'請先填寫。');
                		return;
                	}
                	
                	if(emp($('#txtBdate').val())){
                		alert(q_getMsg('lblCuadate')+'請先填寫。');
                		return;
                	}
                	
                	if(emp($('#txtEdate').val())){
                		$('#txtEdate').val(q_cdn($('#txtBdate').val(),13));
                	}
                	
                	//0513 只要匯入bbs就全部砍
	                for (var i = 0; i < q_bbsCount; i++) {
						$('#btnMinus_'+i).click();
					}
					del_cugunoq='';
                		
                	$('#txtStationno').attr('disabled', 'disabled');
					$('#lblStationk').css('display', 'inline').text($('#lblStation').text());
					$('#lblStation').css('display', 'none');
					
					//只抓cugu資料
                	var t_where = "where=^^ ";
                	if(!emp($('#txtProcessno').val()))
                		t_where=t_where+"b.processno='"+$('#txtProcessno').val()+"' and ";
                	if(!emp($('#txtOrdeno').val()))
                		t_where=t_where+"charindex('"+$('#txtOrdeno').val()+"',b.ordeno)>0 and ";
                	if(!emp($('#txtWorkgno').val()))
                		t_where=t_where+"charindex('"+$('#txtWorkgno').val()+"',b.cuano)>0 and ";
                		
                	var t_bdate='',t_edate='';
                	t_bdate=$('#txtBdate').val();
                	t_edate=!emp($('#txtEdate').val())?$('#txtEdate').val():'999/99/99';
                	t_where=t_where+"(a.datea between '"+t_bdate+"' and '"+t_edate+"' ) and ";
                	t_where=t_where+"a.stationno='"+$('#txtStationno').val()+"' ";
                	//排序
                	t_where=t_where+"order by a.datea,a.nos,a.noq,b.rank desc,a.workno^^";
                	
                	q_gt('cug_work', t_where, 0, 0, 0, "", r_accy);
                });
                
                $('#btnCug').click(function() {
                	$('#btnCug').attr('disabled', 'disabled');
                	scheduling();
                });
                
                $('#txtBdate').blur(function() {
                	//後面在使用>>目前測試
					/*if($('#txtBdate').val()<q_date()&&(q_cur==1||q_cur==2)){
						alert(q_getMsg('lblCuadate')+'不得小於今天日期!!');
						$('#txtBdate').val(q_date());
					}*/
				});
				
				$('#btnWorkReal').click(function() {
					if (!confirm("確定要轉換嗎?")){
						return;
					}
					var workj='';
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtWorkno_'+i).val()) && workj.indexOf($('#txtWorkno_'+i).val())<0
						&&$('#txtWorkno_'+i).val().substr(1,1).replace(/[^\d]/g,'')==''){//表示模擬製令
							workj=workj+(workj.length>0?',':'')+$('#txtWorkno_'+i).val();
						}
					}
					
					if(workj.length>0){
						$('#btnWorkReal').attr('disabled', 'disabled');
						$('#btnWorkReal').val('轉換中....');
						q_func('qtxt.query.workreal', 'cug.txt,workreal,'+'cug'+';'+$('#txtNoa').val());
					}else
						alert("已轉過正式製令!!");
				});
				
				$('#btnWorkRealAll').click(function() {
					$('#textRealbdate').val('');
					$('#textRealedate').val('');
					
					$('#div_real').css('top', $('#btnWorkRealAll').offset().top+25);
					$('#div_real').css('left', $('#btnWorkRealAll').offset().left-$('#div_real').width()+$('#btnWorkRealAll').width()+10);
					$('#div_real').toggle();
				});
				
				$('#textRealbdate').mask('999/99/99');
				$('#textRealbdate').datepicker();
				$('#textRealedate').mask('999/99/99');
				$('#textRealedate').datepicker();
				
				//DIV事件---------------------------------------------------
				$('#btn_div_real').click(function() {
					var r_bdate=trim($('#textRealbdate').val())==''?'#non':trim($('#textRealbdate').val());
					var r_edate=trim($('#textRealedate').val())==''?'#non':trim($('#textRealedate').val());
					var r_bcuano=trim($('#textRealbcuano').val())==''?'#non':trim($('#textRealbcuano').val());
					var r_ecuano=trim($('#textRealecuano').val())==''?'#non':trim($('#textRealecuano').val());
					var r_bworkno=trim($('#textRealbworkno').val())==''?'#non':trim($('#textRealbworkno').val());
					var r_eworkno=trim($('#textRealeworkno').val())==''?'#non':trim($('#textRealeworkno').val());
					var r_tmp=trim($('#textRealbdate').val())+trim($('#textRealedate').val())+trim($('#textRealbcuano').val())
									+trim($('#textRealecuano').val())+trim($('#textRealbworkno').val())+trim($('#textRealeworkno').val());
					
					if(r_tmp.length>0){
						$('#btn_div_real').attr('disabled', 'disabled');
						$('#btn_div_real').val('轉換中....');
						q_func('qtxt.query.workrealall', 'cug.txt,workrealall,'+r_bdate+';'+r_edate+';'+r_bcuano+';'+r_ecuano+';'+r_bworkno+';'+r_eworkno);
					}else
						alert("填寫資料有問題!!");
				});
				
				$('#btnClose_div_real').click(function() {
					$('#div_real').toggle();
				});
				
				$('#btnClose_div_child').click(function() {
					$('#div_child').toggle();
				});
				
				$('#btnDayupdate').click(function() {
					//0514後面直接使用後端的func
					//0520 提前用負數 往後用正數
					var daytmp='',cworknotmp='';
					for (var i = 0; i < child_row; i++) {
						var eday=dec($('#child_txtEarlyday_'+i).val());
						var dday=dec($('#child_txtDelayday_'+i).val());
						var cworkno=trim($('#child_txtWorkno_'+i).val());
						if(eday>0 && cworkno.length>0){
							daytmp=daytmp+(daytmp.length>0?';':'')+(-1*eday).toString();
							cworknotmp=cworknotmp+(cworknotmp.length>0?';':'')+cworkno;
						}else if(dday>0 && cworkno.length>0){
							daytmp=daytmp+(daytmp.length>0?';':'')+dday.toString();
							cworknotmp=cworknotmp+(cworknotmp.length>0?';':'')+cworkno;
						}
					}
					
					if(daytmp.length>0 &&cworknotmp.length>0){
						q_func( 'workg.cuguChange', cworknotmp+','+daytmp);
						//原始q_func( 'workg.cuguChange', 'workno; ;  '+','+'days; ;  ');
						$('#btnDayupdate').attr('disabled', 'disabled');
						$('#btnAlldayupdate').attr('disabled', 'disabled');
					}else{
						alert("無資料更新!!");
					}
				});
				
				$('#btnAlldayupdate').click(function() {
					//0520 提前用負數 往後用正數
					var cugunoq=$('#textChildcugunoq').val().substring(0,$('#textChildcugunoq').val().indexOf('-',$('#textChildcugunoq').val().indexOf('-')+1));
					var day='';
					if(dec($('#textAllEarlyday').val())>0)
						day=(-1*dec($('#textAllEarlyday').val())).toString();
					else if (dec($('#textAllDelayday').val())>0)
						day=dec($('#textAllDelayday').val()).toString();
					else day='';
					
					if(day.length>0 &&cugunoq.length>0){
						q_func( 'workg.cuguChangeAll', cugunoq+','+day);
						//原始q_func( 'workg.cuguChangeAll', cugs.cugunoq+','+'1');
						$('#btnDayupdate').attr('disabled', 'disabled');
						$('#btnAlldayupdate').attr('disabled', 'disabled');
					}else{
						alert("無資料更新!!");
					}
				});
				
				$('#textAllEarlyday').keyup(function() {
					var tmp=$('#textAllEarlyday').val().replace(/[^\d]/g,'');
					$('#textAllEarlyday').val(tmp);
					$('#textAllDelayday').val('');
				});
				$('#textAllDelayday').keyup(function() {
					var tmp=$('#textAllDelayday').val().replace(/[^\d]/g,'');
					$('#textAllDelayday').val(tmp);
					$('#textAllEarlyday').val('');
				});
				//-------------------------------
				$('#btnCopy_plus').click(function() {
					var drow=3,countrow=0;//預設開三行
					//目前的行數
					var rowslength = document.getElementById("table_copy").rows.length - 5;
					while(countrow<drow){
						var tr = document.createElement("tr");
						tr.id = "copy_" + j;
						tr.innerHTML = "<td style='background-color: #CDFFCE;width:34px;' align='center'><input class='btn'  id='btnCopy_minus_"+(rowslength+countrow)+"' type='button' value='-' style='font-weight: bold;'  /></td>";
						tr.innerHTML += "<td colspan='2' style=1background-color: #CDFFCE;width:274px;1 align='center'><input id='copy_txtCuadate_" + (rowslength+countrow) + "' type='text' class='txt c1' value=''/></td>";
						tr.innerHTML += "<td colspan='2' style=1background-color: #CDFFCE;width:274px;1 align='center'><input id='copy_txtMount_" + (rowslength+countrow) + "' type='text' class='txt c1 num' value=''/></td>";
						tr.innerHTML += "<td colspan='2' style=1background-color: #CDFFCE;width:274px;1 align='center'><input id='copy_txtHours_" + (rowslength+countrow) + "' type='text' class='txt c1 num' value='' disabled='disabled' /></td>";
						
						var tmp = document.getElementById("copy_close");
						tmp.parentNode.insertBefore(tr, tmp);
						
						$('#copy_txtCuadate_'+(rowslength+countrow)).mask('999/99/99');
		                $('#copy_txtCuadate_'+(rowslength+countrow)).datepicker({defaultDate:$('#copy_cuadate').text()});
	                
						countrow++;
					}
					
					for (var i = 0; i < (rowslength+countrow); i++) {
						$('#copy_txtMount_'+i).keyup(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var tmp=$('#copy_txtMount_'+b_seq).val();
							tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
							$('#copy_txtMount_'+b_seq).val(tmp);
							
							var omount=dec($('#copy_mount').text());
							var ohours=dec($('#copy_hours').text());
							$('#copy_txtHours_'+b_seq).val(round(ohours*(dec(tmp)/omount),3));
						});
						
						$('#btnCopy_minus_'+i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							$('#copy_txtCuadate_'+b_seq).val('');
							$('#copy_txtMount_'+b_seq).val('');
							$('#copy_txtHours_'+b_seq).val('');
						});
					}
					
					var SeekF= new Array();
					$('#table_copy td').children("input:text").each(function() {
						if($(this).attr('disabled')!='disabled')
							SeekF.push($(this).attr('id'));
					});
					divdate=true;
					SeekF.push('btn_div_copy');
					$('#table_copy td').children("input:text").each(function() {
						$(this).focusout(function(event) {
							if($(this).attr('id').indexOf('copy_txtCuadate_')>-1){
								divdate=true;
								if(divkdate){
									$('#ui-datepicker-div').hide();
									divkdate=false;
								}
								$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).focus();
								//$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).select();
							}
							if($(this).attr('id').indexOf('copy_txtMount_')>-1 &&divdate){
								$('#'+SeekF[SeekF.indexOf($(this).attr('id'))]).select();
								divdate=false;
							}
						});
						
						$(this).bind('keydown', function(event) {
							if($(this).attr('id').indexOf('copy_txtCuadate_')>-1){
								divdate=true;
								divkdate=true;
							}
							keypress_bbm(event, $(this), SeekF, SeekF[$.inArray($(this).attr('id'),SeekF)+1]);	
							
						});
					});
				});
				
				$('#btn_div_copy').click(function() {
					var rowslength = document.getElementById("table_copy").rows.length - 5;
					//檢查拆分數量是否等於原始數量
					var total_mount=0,total_row=0,tmp_total_row=0,total_hours=0;
					var copy_row=new Array();
					var omount=dec($('#copy_mount').text());
					var ohours=dec($('#copy_hours').text());
					for (var i = 0; i < rowslength; i++) {
						if(dec($('#copy_txtMount_'+i).val())>0){
							//暫存資料
							var t_copy=new Array();
	                		t_copy['txtCuadate']=$('#copy_txtCuadate_'+i).val();
	                		t_copy['textDatea']=$('#copy_txtCuadate_'+i).val();
	                		t_copy['txtMount']=$('#copy_txtMount_'+i).val();
	                		t_copy['txtHours']=$('#copy_txtHours_'+i).val();
	                		copy_row.push(t_copy);
	                		
							total_mount=q_add(total_mount,dec($('#copy_txtMount_'+i).val()));
							total_hours=q_add(total_hours,dec($('#copy_txtHours_'+i).val()));
							total_row++;
						}
					}
					
					if(total_mount!=omount){
						alert("拆分數量不等於原始數量!!");
						return;
					}
					
					if(emp($('#textCugunoq').val())){
						alert("資料錯誤!!");
						return;
					}else{
						del_cugunoq=del_cugunoq+(del_cugunoq.length>0?',':'')+$('#textCugunoq').val();
					}
					
					if(dec(total_hours)!=dec(ohours)){//處理小數點四捨五入的問題
						copy_row[total_row-1]['txtHours']=q_add(dec(copy_row[total_row-1]['txtHours']),q_sub(dec(ohours),dec(total_hours)));
					}
					
					tmp_total_row=total_row-1;
					//複製行數
					while(tmp_total_row>0){
						q_bbs_addrow('bbs', copy_row_b_seq, 1);
						tmp_total_row--;
					}
					
					//寫入資料
					for(var i=0;i<total_row;i++){
						for (var j = 0; j < fbbs.length; j++) {
							if(copy_row[i][fbbs[j]]!=undefined && copy_row[i][fbbs[j]]!='')
								$('#'+fbbs[j]+'_'+(dec(copy_row_b_seq)+i)).val(copy_row[i][fbbs[j]]);
							else
								$('#'+fbbs[j]+'_'+(dec(copy_row_b_seq)+i)).val(copy_bbs_row[fbbs[j]]);
							
							if(fbbs[j]=='txtCugunoq')
								$('#txtCugunoq_'+(dec(copy_row_b_seq)+i)).val($('#txtCugunoq_'+(dec(copy_row_b_seq)+i)).val()+String.fromCharCode(65+i));
						}
					}
					
					//處理bbs格式 
	                for (var i = 0; i < q_bbsCount; i++) {
						$('#txtCuadate_'+i).attr('disabled', 'disabled');
						//$('#txtUindate_'+i).attr('disabled', 'disabled');
						
						if(!emp($('#txtWorkno_'+i).val())){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
							if(r_modi || r_modi==undefined)
								$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
							else
								$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#btnCopy_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5 ){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#textDatea_'+i).datepicker('destroy');
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}else{
							$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
							if(r_modi || r_modi==undefined)
								$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
							else
								$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}
					$('#div_copy').toggle();
				});
				
				$('#btnClose_div_copy').click(function() {
					$('#div_copy').toggle();
				});
				
            }
            
            var divdate=false;
            var divkdate=false;
			var first_rest=true;
			var getnewgen=false;
            function scheduling(){
            	if(!getnewgen){
            		q_gt('station', "where=^^noa='"+$('#txtStationno').val()+"' ^^", 0, 0, 0, "getgen", r_accy);
            		return;
            	}
            	
            	/*if($('#txtGenorg').val()<=0){
            		alert(q_getMsg('lblGenorg')+'不得小於等於0!!');
            		$('#btnCug').removeAttr('disabled');
	               	return;
            	}*/
            	
                //取得編制時數
                if(t_cugt==undefined){
                	//取得最早開工日
                	var mincuadate=$('#txtBdate').val();
                	for (var i = 0; i < q_bbsCount; i++) {
                		if(mincuadate>$('#txtCuadate_'+i).val())
                			mincuadate=$('#txtCuadate_'+i).val()
                	}
                	q_gt('view_cugt', "where=^^stationno='"+$('#txtStationno').val()+"' and datea>='"+mincuadate+"' ^^", 0, 0, 0, "cugt", r_accy);
                	return;
                }
                
                //先清除自動產生的空白時數,並將指定開工日寫入到應開工日
                if(first_rest){
	               	for (var i = 0; i < q_bbsCount; i++) {
	               		if(!emp($('#textDatea_'+i).val()))
	               			$('#txtCuadate_'+i).val($('#textDatea_'+i).val());
	               		if(($('#txtNos_'+i).val().length==5)||(emp($('#txtProcess_'+i).val()) && emp($('#txtWorkno_'+i).val()))){
	               			$('#btnMinus_'+i).click();
	               		}
	               	}
	               	first_rest=false;
                }                
                
                //依應開工日做為排程開始日
                for (var i = 0; i < q_bbsCount; i++) {
                	//更新 有排程應開工日沒有排程序號的資料
                	var maxnos='0000'
                	if(emp($('#txtNos_'+i).val()) && !emp($('#txtCuadate_'+i).val()) && (!emp($('#txtProcess_'+i).val()) || !emp($('#txtWorkno_'+i).val()))){
	                	for (var j = 0; j < q_bbsCount; j++) {
	                		if(i!=j && $('#txtCuadate_'+i).val()==$('#txtCuadate_'+j).val() &&$('#txtNos_'+j).val()>maxnos){
	                			maxnos=$('#txtNos_'+j).val();
	                		}
	                	}
	                	$('#txtNos_'+i).val(('000'+(dec(maxnos.substr(0,3))+1)).slice(-3)+'0');
                	}
                	//更新沒有排程應開工日的資料>>指定應開工日
                	if(emp($('#txtCuadate_'+i).val()) && (!emp($('#txtProcess_'+i).val()) || !emp($('#txtWorkno_'+i).val()))){
                		if(emp($('#txtCuadate_'+i).val())){
                			$('#txtCuadate_'+i).val($('#txtBdate').val());
                		}
                		for (var j = 0; j < q_bbsCount; j++) {
	                		if(i!=j && $('#txtCuadate_'+i).val()==$('#txtCuadate_'+j).val() &&$('#txtNos_'+j).val()>maxnos){
	                			maxnos=$('#txtNos_'+j).val();
	                		}
	                	}
	                	$('#txtNos_'+i).val(('000'+(dec(maxnos.substr(0,3))+1)).slice(-3)+'0');
                	}
                	$('#txtNoq_'+i).val(replaceAll($('#txtCuadate_'+i).val(), '/','')+$('#txtNos_'+i).val());
                }
                
                //0516排程序號可重複
                //檢查排程序號是否重複
				/*for (var i = 0; i < q_bbsCount; i++) {
	               	for (var j = i+1; j < q_bbsCount; j++) {
	               		if (i!=j &&$('#txtNoq_'+i).val()==$('#txtNoq_'+j).val()&&(!emp($('#txtProcess_'+i).val())||!emp($('#txtWorkno_'+i).val()))){
	               			alert($('#lblNo_'+i).text()+'.'+$('#txtCuadate_'+i).val()+' '+q_getMsg('lblNos_s')+'['+$('#txtNos_'+i).val()+']重覆')
	               			$('#btnCug').removeAttr('disabled');
	               			return;
	               		}
	               	}
				}*/
                
                //排序資料
                //儲存有排序的資料,清除整個欄位
				var t_bbs=new Array();
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProcess_'+i).val()) || !emp($('#txtWorkno_'+i).val())){
                		var t_bbss=new Array();
                		for (var j = 0; j < fbbs.length; j++) {
                			t_bbss[fbbs[j]]=$('#'+fbbs[j]+'_'+i).val();
                		}
                		t_bbs.push(t_bbss);
                	}
					$('#btnMinus_'+i).click();
				}
                //最先做的放前面(依cudatea,nos,cugunoq)
                if(t_bbs.length!=0){
	               	for (var i = 0; i < q_bbsCount; i++) {
	               		var minnoq='',min_j=0;//目前最小資料,與資料位置
	               		for (var j = 0; j < t_bbs.length; j++) {
	               			if(minnoq==''){
	               				minnoq=t_bbs[j].txtCuadate+t_bbs[j].txtNos+t_bbs[j].txtCugunoq
	               				min_j=0;
	               			}else{
	               				if(minnoq>t_bbs[j].txtCuadate+t_bbs[j].txtNos+t_bbs[j].txtCugunoq){
	               					minnoq=t_bbs[j].txtCuadate+t_bbs[j].txtNos+t_bbs[j].txtCugunoq;
	               					min_j=j;
	               				}
	               			}
	               		}
	               		for (var j = 0; j < fbbs.length; j++) {
	               			$('#'+fbbs[j]+'_'+i).val(t_bbs[min_j][fbbs[j]]);
	               		}
	               		//移除最小資料
	               		t_bbs.splice(min_j, 1);
	               		//如果暫存沒資料就跳出
	               		if(t_bbs.length==0)
	               			break;
					}
				}
                //---------------------------------------------------------------------------------------------------------------
                //處理資料
                //0513 強制當天會做完所以不處理 拆分兩個work、延後、剩餘一小時不處理等動作
                var t_genorg=dec($('#txtGenorg').val());//原始產能
                var t_gen=t_genorg;//目前產能
                var total_hours=0; //累計機時
                for (var i = 0; i < q_bbsCount; i++) {
                	t_gen=t_genorg;//目前產能
                	total_hours=q_add( total_hours,dec($('#txtHours_'+i).val()));
                	if($('#txtCuadate_'+i).val()!='' && $('#txtCuadate_'+i).val().length==9){
		                //取得當天gen
		                for (var k = 0; k < t_cugt.length; k++) {
		                	if(t_cugt[k].datea==$('#txtCuadate_'+i).val()){
		                		t_gen=dec(t_cugt[k].gen);
		                	}
		                }
		                //-------------------------------------------------------------------
		                //處理時數
		                //累計工時
		                $('#txtThours_'+i).val(total_hours);
		                //取得當天已工作時數
		                var t_hours=0 //當日累計時數
		                for (var j = 0; j <=i; j++) {
		                	if($('#txtCuadate_'+i).val()==$('#txtCuadate_'+j).val()){
		                		t_hours=q_add( t_hours,dec($('#txtHours_'+j).val()));
		                	}
		                }
		                //-------------------------------------------------------------------
		                //完工日>>>0513做為判斷是否有變動開工日
		                //$('#txtUindate_'+i).val($('#txtCuadate_'+i).val());
		                //-------------------------------------------------------------------
		                //如果當天是最後一筆且非空白行 插入 空白行分隔
		                var smount=dec($('#txtSmount').val());
						if($('#txtCuadate_'+i).val()!=$('#txtCuadate_'+(i+1)).val() && $('#txtNos_'+i).val().length!=5){
							q_bbs_addrow('bbs',i,1);//下方插入空白行
							$('#txtCuadate_'+(i+1)).val($('#txtCuadate_'+i).val());
			                $('#txtUindate_'+(i+1)).val($('#txtCuadate_'+i).val());
			                $('#txtHours_'+(i+1)).val(0);
			                $('#txtMount_'+(i+1)).val(0);
			                $('#textDatea_'+(i+1)).val($('#txtCuadate_'+i).val());
			                
			                $('#txtNos_'+(i+1)).val($('#txtNos_'+i).val()+'X');
			                $('#txtNoq_'+(i+1)).val(replaceAll($('#txtCuadate_'+(i+1)).val(), '/','')+$('#txtNos_'+(i+1)).val());
			                $('#txtProcess_'+(i+1)).val($('#txtCuadate_'+i).val());
			                $('#txtSpec_'+(i+1)).val('當天累計：'+round(q_div(t_hours,smount),2)+'HR;剩餘：'+round(q_div(q_sub(t_gen,t_hours),smount),2)+'HR');
						}
		                //-------------------------------------------------------------------
	                }
                }
                
                //處理格式
                for (var i = 0; i < q_bbsCount; i++) {
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					//$('#txtUindate_'+i).attr('disabled', 'disabled');
					
					if(!emp($('#txtWorkno_'+i).val())){
						$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
						if(r_modi || r_modi==undefined)
							$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
						else
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).removeClass('hasDatepicker');
						$('#textDatea_'+i).datepicker();
						$('#btnCopy_'+i).removeAttr('disabled');
						$('#btnChildchange_'+i).removeAttr('disabled');
					}else if ($('#txtNos_'+i).val().length==5 ){
						$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).removeClass('hasDatepicker');
						$('#textDatea_'+i).datepicker();
						$('#textDatea_'+i).datepicker('destroy');
						$('#btnCopy_'+i).attr('disabled', 'disabled');
						$('#btnChildchange_'+i).attr('disabled', 'disabled');
					}else{
						$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
						$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
						$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
						if(r_modi || r_modi==undefined)
							$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
						else
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).removeClass('hasDatepicker');
						$('#textDatea_'+i).datepicker();
						$('#btnCopy_'+i).attr('disabled', 'disabled');
						$('#btnChildchange_'+i).attr('disabled', 'disabled');
					}
				}
				
                t_cugt=undefined;
                first_rest=true;
                getnewgen=false
                sum();
                $('#btnCug').removeAttr('disabled');
                if(cngisbtnok){
                	$('#btnOk').click();
                }
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
			
			var child_row = 0;//異動子階的欄位數
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'getgen':
                		var as = _q_appendData("station", "", true);
                		if(as[0]==undefined){
                			alert("該工作中心不存在!!");
                			$('#btnCug').removeAttr('disabled');
                		}else{
                			$('#txtGenorg').val(as[0].gen);
                			$('#txtSmount').val(dec(as[0].hours)!=0?Math.ceil(q_div(as[0].gen,as[0].hours)):1);
                			getnewgen=true;
                			scheduling();
                		}
                		break;
                	case 'cugt':
                		t_cugt = _q_appendData("view_cugt", "", true);
                		scheduling();
                		break;
                	/*case 'station_chk':
                		var as = _q_appendData("cug", "", true);
                		if(as[0]!=undefined){
                			alert("該工作中心已存在!!");
                		}else{
                			station_chk=true;
                			$('#btnWork').click();
                		}
                		break;*/
                	/*case 'station_btnok':
                		var as = _q_appendData("cug", "", true);
                		if(as[0]!=undefined){
                			alert("該工作中心已存在!!");
                		}else{
                			station_btnok=true;
                			$('#btnOk').click();
                		}
                		break;*/
                	case 'cug_work':
                		var as = _q_appendData("view_cugu", "", true);
                		if(as[0]!=undefined){
                			for ( var i = 0; i < as.length; i++) {
								//cugu //1030516 nos 可重複
                				/*as[i].nownos=as[i].nos;
                				if(as[i].nos=='9000'){
                					var tmp_nos='9000';
                					for ( var j = 0; j < as.length; j++) {
                						if(i!=j&&as[i].cuadate==as[j].cuadate &&tmp_nos!=as[j].nos&&as[j].nos!=''){
                							tmp_nos=as[j].nos;
                						}
                					}
                					if(tmp_nos=='9000')//表示當天沒有其他排程
                						as[i].nownos='';
                				}*/
                			}
                			
                			//0513 只要匯入bbs就全部砍
                			//判斷是否已被匯入
                			/*for (var i = 0; i < q_bbsCount; i++) {
								for (var j = 0; j < as.length; j++) {
									if($('#txtWorkno_' + i).val()==as[j].workno && $('#txtProcess_'+i).val()==as[j].process){
										as.splice(j, 1);
                                    	j--;
										break;	
									}
								}
							}*/
							
							q_gridAddRow(bbsHtm, 'tbbs'
							,'txtNos,txtNoq,txtProcessno,txtProcess,txtProductno,txtProduct,txtSpec,txtStyle,txtMount,txtHours,txtCuadate,txtUindate,txtOrgcuadate,txtOrguindate,txtWorkno,txtWorkgno,txtOrdeno,txtPretime,txtCugunoq,txtNosold', as.length, as,
							'nos,noq,processno,process,productno,product,spec,style,mount,hours,cuadate,uindate,orgcuadate,orguindate,workno,workgno,ordeno,pretime,cugunoq,nos','txtProductno,txtProcess,txtWorkno');
							
							for (var i = 0; i < q_bbsCount; i++) {
								$('#txtCuadate_'+i).attr('disabled', 'disabled');
								//$('#txtUindate_'+i).attr('disabled', 'disabled');
								$('#txtCuadate_'+i).css('background-color','rgb(237, 237, 238)');
								//$('#txtUindate_'+i).css('background-color','rgb(237, 237, 238)');
							}
							sum();
                		}
                		
                		break;
                	case 'child_work':
                		var as = _q_appendData("view_work", "", true);
                		var rowslength = document.getElementById("table_child").rows.length - 2;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("table_child").deleteRow(2);
						}
						child_row=0;
						if(as[0]!=undefined){
							$('#textEarlyday').val('');
							for (var i = 0; i < as.length; i++) {
								var tr = document.createElement("tr");
								tr.id = "bbs_" + j;
								tr.innerHTML = "<td><input id='child_txtEarlyday_" + child_row + "' type='text' class='txt c1' value='' style='text-align:right;' /></td>";
								tr.innerHTML += "<td><input id='child_txtDelayday_" + child_row + "' type='text' class='txt c1' value='' style='text-align:right;' /></td>";
								tr.innerHTML += "<td><input id='child_txtRank_" + child_row + "' type='text' class='txt c1' value='" + as[i].rank + "' disabled='disabled' style='text-align:center;'/></td>";
								tr.innerHTML += "<td><input id='child_txtWorkno_" + child_row + "' type='text' class='txt c1' value='" + as[i].noa + "' disabled='disabled'/></td>";								
								tr.innerHTML += "<td><input id='child_txtProductno_" + child_row + "' type='text' class='txt c1' value='" + as[i].productno + "' disabled='disabled' /><input id='child_txtProcess_" + child_row + "' type='text' class='txt c1' value='" + as[i].process + "' disabled='disabled' /></td>";
								tr.innerHTML += "<td><input id='child_txtProduct_" + child_row + "' type='text' class='txt c1' value='" + as[i].product + "' disabled='disabled' /><input id='child_txtSpec_" + child_row + "' type='text' class='txt c1' value='" + as[i].spec + "' disabled='disabled' /></td>";
								tr.innerHTML += "<td><input id='child_txtStyle_" + child_row + "' type='text' class='txt c1' value='" + as[i].style + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td><input id='child_txtStation_" + child_row + "' type='text' class='txt c1' value='" + as[i].station + "' disabled='disabled' /><input id='child_txtTgg_" + child_row + "' type='text' class='txt c1' value='" + as[i].comp + "' disabled='disabled' /></td>";
								tr.innerHTML += "<td><input id='child_txtMount_" + child_row + "' type='text' class='txt c1 num' value='" + FormatNumber(as[i].mount) + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td><input id='child_txtHours_" + child_row + "' type='text' class='txt c1 num' value='" + FormatNumber(as[i].hours) + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td><input id='child_txtCuadate_" + child_row + "' type='text' class='txt c1' value='" + as[i].cuadate + "' disabled='disabled'/></td>";
								var tmp = document.getElementById("child_close");
								tmp.parentNode.insertBefore(tr, tmp);
								child_row++;
							}
							$('#btnDayupdate').removeAttr('disabled');
							$('#btnAlldayupdate').removeAttr('disabled');
							$('#div_child').toggle();
						}else{
							alert("無子階資料");
							$('#btnDayupdate').attr('disabled', 'disabled');
							$('#btnAlldayupdate').attr('disabled', 'disabled');
						}
						for (var i = 0; i < child_row; i++) {
							$('#child_txtEarlyday_'+i).keyup(function() {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								var tmp=$('#child_txtEarlyday_'+b_seq).val().replace(/[^\d]/g,'');
								$('#child_txtEarlyday_'+b_seq).val(tmp);
								$('#child_txtDelayday_'+b_seq).val('');
							});
							$('#child_txtDelayday_'+i).keyup(function() {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								var tmp=$('#child_txtDelayday_'+b_seq).val().replace(/[^\d]/g,'');
								$('#child_txtDelayday_'+b_seq).val(tmp);
								$('#child_txtEarlyday_'+b_seq).val('');
							});
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
			
			var station_btnok=false;
			var cngisbtnok=false;
            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtStationno', q_getMsg('lblStation')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(!cngisbtnok){
                	cngisbtnok=true;
                	q_gt('view_cugt', "where=^^stationno='"+$('#txtStationno').val()+"' and datea>='"+$('#txtBdate').val()+"' ^^", 0, 0, 0, "cugt", r_accy);
                	return;
                }
                
                cngisbtnok=false;
                sum();
                
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtNoq_'+i).val('');
                }
                
                //刪除拆分的cugunoq
                if(del_cugunoq.length>0){
                	q_func('qtxt.query.delcugunoq', 'cug.txt,delcugunoq,' + del_cugunoq);
                }
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
								
				var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtKdate').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cug') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cug_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtBdate').val(q_date());
                $('#txtKdate').val(q_date());
                del_cugunoq='';
                //預設兩個禮拜
                $('#txtEdate').val(q_cdn(q_date(),13));
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
				$('#txtStationno').attr('disabled', 'disabled');
				$('#lblStationk').css('display', 'inline').text($('#lblStation').text());
				$('#lblStation').css('display', 'none');
				del_cugunoq='';
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
            
            var copy_row_b_seq = '';
            var copy_bbs_row;
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_' + i).text(i + 1);
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
		                
		                $('#txtOrdeno_'+i).click(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtOrdeno_' + b_seq).val())){
								t_where = "charindex(noa,'"+$('#txtOrdeno_' + b_seq).val()+"')>0";
								q_box("orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'orde', "95%", "95%", q_getMsg('PopOrde'));
							}
		                });
		                
		                $('#txtWorkgno_'+i).click(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtWorkgno_' + b_seq).val())){
								t_where = "noa='"+$('#txtWorkgno_' + b_seq).val()+"'";
								q_box("workg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workg', "95%", "95%", q_getMsg('PopWorkg'));
							}
		                });
		                
		                $('#txtNos_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                	//if(q_cur==1 || q_cur==2){}
						});
						
						$('#txtProcess_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#textDatea_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                	//$('#txtCuadate_' + b_seq).val($('#textDatea_' + b_seq).val())
						});
						
						$('#btnChildchange_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(e.button==0){
								if (!emp($('#txtWorkno_' + b_seq).val()) && $("#div_child").is(":hidden")) {
									$('#textChildseq').val(b_seq);
									$('#textChildworkno').val($('#txtWorkno_' + b_seq).val());
									$('#textChildcugunoq').val($('#txtCugunoq_' + b_seq).val());
									$('#textAllEarlyday').val('');
									$('#textAllDelayday').val('');
									//查詢子階work
									var t_where = "where=^^ cuano+'-'+cuanoq=(select cuano+'-'+cuanoq from view_work where noa='"+$('#txtWorkno_' + b_seq).val()+"') ";
									t_where=t_where+"and isnull(previd,'')=(select isnull(nowid,'') from view_work where noa='"+$('#txtWorkno_' + b_seq).val()+"') ";
									t_where=t_where+"and rank=(select cast(rank as int)+1 from view_work where noa='"+$('#txtWorkno_' + b_seq).val()+"') ^^";
									q_gt('view_work', t_where, 0, 0, 0, "child_work", r_accy);
									//有廠商的work也要顯示 >>>拿掉 and stationno!=''
									$('#div_child').css('top', $('#btnChildchange_'+b_seq).offset().top+25);
									$('#div_child').css('left', $('#btnChildchange_'+b_seq).offset().left-75);
								}
							}
						});
						
						$('#btnCopy_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(e.button==0){
								if(dec($('#txtMount_' + b_seq).val())<=0 || emp($('#txtWorkno_' + b_seq).val()))
									return;
									
								//設定顯示位置
								$('#div_copy').css('top', e.pageY+30);
								$('#div_copy').css('left', e.pageX+45);
								//填入資料
								$('#copy_workno').text($('#txtWorkno_'+b_seq).val());
								$('#copy_productno').text($('#txtProductno_'+b_seq).val());
								$('#copy_product').text($('#txtProduct_'+b_seq).val());
								$('#copy_cuadate').text($('#txtCuadate_'+b_seq).val());
								$('#copy_mount').text($('#txtMount_'+b_seq).val());
								$('#copy_hours').text($('#txtHours_'+b_seq).val());
								$('#textCugunoq').val($('#txtCugunoq_'+b_seq).val());
								
								//刪除舊資料
								var rowslength = document.getElementById("table_copy").rows.length - 4;
								for (var j = 1; j < rowslength; j++) {
									document.getElementById("table_copy").deleteRow(4);
								}
								
								//預設開3行
								$('#btnCopy_plus').click();
								
								//暫存要複製的資料
								copy_bbs_row=new Array();
				                for (var j = 0; j < fbbs.length; j++) {
				                	copy_bbs_row[fbbs[j]]=$('#'+fbbs[j]+'_'+b_seq).val();
				                }
				                
								$('#div_copy').show();
								copy_row_b_seq = b_seq;
								e.preventDefault();
							}
						});
					}
                }
                _bbsAssign();
				
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					//$('#txtUindate_'+i).attr('disabled', 'disabled');
					$('#txtCuadate_'+i).css('background-color','rgb(237, 237, 238)');
					//$('#txtUindate_'+i).css('background-color','rgb(237, 237, 238)');
					
					if(q_cur==1 || q_cur==2){
						if(!emp($('#txtWorkno_'+i).val())){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
							if(r_modi || r_modi==undefined)
								$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
							else
								$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#btnCopy_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#textDatea_'+i).datepicker('destroy');
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}else{
							$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
							if(r_modi || r_modi==undefined)
								$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
							else
								$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}else{
						if(!emp($('#txtWorkno_'+i).val())){
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else{
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
						$('#btnCopy_'+i).attr('disabled', 'disabled');
					}
				}
				
				if(q_getPara('sys.isstyle')=='1'){
                	$('.isstyle').show();
                	$('.dbbs').css('width','1900px');
                }else{
                	$('.isstyle').hide();
                	$('.dbbs').css('width','1710px');
                }
            }

            function bbsSave(as) {
                if (!as['process']&&!as['workno'] ) {//不存檔條件
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
					t1=q_add(t1,q_float('txtHours_'+j));
                } // j
                $('#txtHours').val(t1);
            }

            function refresh(recno) {
                _refresh(recno);
                $('#div_child').hide();
                $('#div_copy').hide();
                $('#div_real').hide();
				$('#lblStation').css('display', 'inline');
				$('#lblStationk').css('display', 'none');
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(t_para){
	            	$('#btnWork').attr('disabled', 'disabled');
	            	$('#btnCug').attr('disabled', 'disabled');
	            	$('#btnCugt').attr('disabled', 'disabled');
	            	$('#btnWorkReal').removeAttr('disabled');
	            	$('#btnWorkRealAll').removeAttr('disabled');
	            }else{
	            	$('#btnWork').removeAttr('disabled');
	            	$('#btnCug').removeAttr('disabled');
	            	$('#btnCugt').removeAttr('disabled');
	            	$('#btnWorkReal').attr('disabled', 'disabled');
	            	$('#btnWorkRealAll').attr('disabled', 'disabled');
	            }
                
                if(q_getPara('sys.isstyle')=='1'){
                	$('.isstyle').show();
                	$('.dbbs').css('width','1900px');
                }else{
                	$('.isstyle').hide();
                	$('.dbbs').css('width','1710px');
                }
                
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					//$('#txtUindate_'+i).attr('disabled', 'disabled');
					$('#txtCuadate_'+i).css('background-color','rgb(237, 237, 238)');
					//$('#txtUindate_'+i).css('background-color','rgb(237, 237, 238)');
					
					if(q_cur==1 || q_cur==2){
						if(!emp($('#txtWorkno_'+i).val())){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
							if(r_modi || r_modi==undefined)
								$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
							else
								$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#btnCopy_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5 ){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#textDatea_'+i).datepicker('destroy');
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}else{
							$('#txtProcess_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtHours_'+i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
							if(r_modi || r_modi==undefined)
								$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
							else
								$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}else{
						if(!emp($('#txtWorkno_'+i).val())){
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else{
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
						$('#btnCopy_'+i).attr('disabled', 'disabled');
					}
				}
				if(issave){
            		issave=false;
            		var s2=new Array('cug_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
					q_boxClose2(s2);
				}
				$('.ui-datepicker').css('margin-left','100px');
				$('#div_real').hide();
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
            
		   function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'workg.cuguChange':
                		alert("更新完成!!");
                		//重新開啟新的資料
                		$('#div_child').toggle();
						var t_where = "where=^^ cuano+'-'+cuanoq=(select cuano+'-'+cuanoq from view_work where noa='"+$('#txtWorkno_' + $('#textChildseq').val()).val()+"') ";
						t_where=t_where+"and isnull(previd,'')=(select isnull(nowid,'') from view_work where noa='"+$('#txtWorkno_' + $('#textChildseq').val()).val()+"') ";
						t_where=t_where+"and rank=(select cast(rank as int)+1 from view_work where noa='"+$('#txtWorkno_' + $('#textChildseq').val()).val()+"') ^^";
						//有廠商的work也要顯示 >>>拿掉 and stationno!=''
						q_gt('view_work', t_where, 0, 0, 0, "child_work", r_accy);
                	break;
                	case 'workg.cuguChangeAll':
                		alert("更新完成!!");
                		//重新開啟新的資料
                		$('#div_child').toggle();
						var t_where = "where=^^ cuano+'-'+cuanoq=(select cuano+'-'+cuanoq from view_work where noa='"+$('#txtWorkno_' + $('#textChildseq').val()).val()+"') ";
						t_where=t_where+"and isnull(previd,'')=(select isnull(nowid,'') from view_work where noa='"+$('#txtWorkno_' + $('#textChildseq').val()).val()+"') ";
						t_where=t_where+"and rank=(select cast(rank as int)+1 from view_work where noa='"+$('#txtWorkno_' + $('#textChildseq').val()).val()+"') ^^";
						q_gt('view_work', t_where, 0, 0, 0, "child_work", r_accy);
                	break;
                	case 'qtxt.query.workreal':
                		$('#btnWorkReal').removeAttr('disabled');
                		$('#btnWorkReal').val(q_getMsg('btnWorkReal'));
                		alert("模擬製令成功轉成正式製令!!");
                		var s2=new Array('cug_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
						q_boxClose2(s2);
                	break;
                	case 'qtxt.query.workrealall':
                		$('#btn_div_real').removeAttr('disabled');
                		$('#btn_div_real').val('轉換');
                		alert("批次模擬製令成功轉成正式製令!!");
                		$('#div_real').toggle();
                		var s2=new Array('cug_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
						q_boxClose2(s2);
                	break;
                }
			}
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
                width: 1700px;
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
		<div id="div_real" style="position:absolute; top:0px; left:0px; display:none; width:510px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_real" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">應開工日區間</td>
					<td style="background-color: #f8d463;">
						<input id='textRealbdate' type='text' style='text-align:left;width:100px;'/>	~
						<input id='textRealedate' type='text' style='text-align:left;width: 100px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">排產單號</td>
					<td style="background-color: #f8d463;">
						<input id='textRealbcuano' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textRealecuano' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">製令單號</td>
					<td style="background-color: #f8d463;">
						<input id='textRealbworkno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textRealeworkno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr id='real_close'>
					<td align="center" colspan='7'>
						<input id="btn_div_real" type="button" value="轉換">
						<input id="btnClose_div_real" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!---DIV分隔線---->
		<div id="div_copy" style="position:absolute; top:0px; left:0px; display:none; width:800px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_copy" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td colspan='2'  style="background-color: #F8D463;" align="center">製品編號</td>
					<td id="copy_productno" colspan='2' style="background-color: #F8D463;" align="center"> </td>
					<td style="background-color: #F8D463;width:144px;" align="center">製令編號</td>
					<td id="copy_workno" colspan='2' style="background-color: #F8D463;" align="center"> </td>
				</tr>
				<tr>
					<td colspan='2'  style="background-color: #F8D463;" align="center">製品名稱</td>
					<td id="copy_product" colspan='5' style="background-color: #F8D463;" align="left"> </td>
				</tr>
				<tr>
					<td colspan='2' style="background-color: #F8D463;" align="center">原始應開工日</td>
					<td id="copy_cuadate" style="background-color: #F8D463;width:144px;" align="center"> </td>
					<td style="background-color: #F8D463;width:114px;" align="center">原始數量</td>
					<td id="copy_mount" style="background-color: #F8D463;width:144px;" align="center"> </td>
					<td style="background-color: #F8D463;width:114px;" align="center">原始機時</td>
					<td id="copy_hours" style="background-color: #F8D463;width:144px;" align="center"> </td>
				</tr>
				<tr id='copy_top'>
					<td style="background-color: #CDFFCE;width:34px;" align="center">
						<input class="btn"  id="btnCopy_plus" type="button" value='+' style="font-weight: bold;"  />
						<input id='textCugunoq' type='hidden'/>
					</td>
					<td colspan='2' style="background-color: #CDFFCE;width:274px;" align="center">應開工日</td>
					<td colspan='2' style="background-color: #CDFFCE;width:274px;" align="center">數量</td>
					<td colspan='2' style="background-color: #CDFFCE;width:274px;" align="center">機時</td>
				</tr>
				<tr id='copy_close'>
					<td align="center" colspan='7'>
						<input id="btn_div_copy" type="button" value="拆分">
						<input id="btnClose_div_copy" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!---DIV分隔線---->
		<div id="div_child" style="position:absolute; top:0px; left:0px; display:none; width:1100px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_child" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr >
					<td colspan="11" style="background-color: #f8d463;">
						<input id='textChildseq' type='hidden'/>
						<input id='textChildworkno' type='hidden'/>
						<input id='textChildcugunoq' type='hidden'/>
						所有製成品子階全部&nbsp;&nbsp;
						提前&nbsp;
						<input id='textAllEarlyday' type='text' style='text-align:right;width: 50px;'/>
						往後&nbsp;
						<input id='textAllDelayday' type='text' style='text-align:right;width: 50px;'/>
						&nbsp;&nbsp;
						<input id="btnAlldayupdate" type="button" value="全部更新">
					</td>
				</tr>
				<tr id='child_top'>
					<td style="background-color: #CDFFCE;width:4%;" align="center">提前天數</td>
					<td style="background-color: #CDFFCE;width:4%;" align="center">往後天數</td>
					<td style="background-color: #CDFFCE;width:4%;" align="center">子階層數</td>
					<td style="background-color: #CDFFCE;width:14%;" align="center">子階製令單號</td>
					<td style="background-color: #CDFFCE;width:14%;" align="center">製品編號/製程</td>
					<td style="background-color: #CDFFCE;width:17%;" align="center">製品名稱/規格</td>
					<td style="background-color: #CDFFCE;width:10%;" align="center">機型</td>
					<td style="background-color: #CDFFCE;width:12%;" align="center">工作中心/廠商</td>
					<td style="background-color: #CDFFCE;width:7%;" align="center">數量</td>
					<td style="background-color: #CDFFCE;width:6%;" align="center">機時</td>
					<td style="background-color: #CDFFCE;width:8%;" align="center">應開工日</td>
				</tr>
				<tr id='child_close'>
					<td align="center" colspan='11'>
						<input id="btnDayupdate" type="button" value="部分更新">
						<input id="btnClose_div_child" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewBdate'> </a></td>
						<td align="center" style="width:30%"><a id='vewStation'> </a></td>
						<td align="center" style="width:30%"><a id='vewProcess'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='bdate'>~bdate</td>
						<td align="center" id='station'>~station</td>
						<td align="center" id='process'>~process</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td3" style="width: 105px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4" style="width: 206px;"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td5" style="width: 105px;"><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td class="td6" style="width: 176px;"><input id="txtKdate"  type="text" class="txt c1"/></td>
						<td class="td1" style="width: 105px;"><!--<span> </span><a id='lblDatea' class="lbl"> </a>--></td>
						<td class="td2" style="width: 176px;"><!--<input id="txtDatea"  type="hidden" class="txt c1"/>--></td>
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
						<td class="td5"><input id="btnWorkReal" type="button" style="float: right;"/></td>
						<td class="td6"><input id="btnWorkRealAll" type="button" style="float: center;"/></td>
						<!--<td class="td3"><span> </span><a id="lblIsset"> </a></td>
						<td class="td4"><input id="chkIsset" type="checkbox" /></td>-->
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:31px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:75px;"><a id='lblNos_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDatea_s'> </a></td>
					<td align="center" style="width:155px;"><a id='lblProductno_s'> </a>/<a id='lblProcess_s'> </a></td>
					<td align="center" style="width:270px;"><a id='lblProduct_s'> </a>/<a id='lblSpec_s'> </a></td>
					<td align="center" class="isstyle" style="width:100px;"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblHours_s'> </a></td>
					<td style='display: none;' align="center" style="width:90px;"><a id='lblPretime_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblOrgcuadate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblOrguindate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblCuadate_s'> </a></td>
					<td style='display: none;' align="center" style="width:105px;"><a id='lblUindate_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblThours_s'> </a></td>
					<td align="center" style="width:160px;"><a id='lblWorkno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblOrdeno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblWorkgno_s'> </a></td>
					<!--<td align="center"><a id='lblMemo_s'> </a></td>-->
				</tr>
				<tr id="trSel.*">
					<td align="center">
						<!--0520該作業不需要-->
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold; display: none;" />
						<input class="btn"  id="btnCopy.*" type="button" value='拆分' />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtNos.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" class="txt c1"/>
						<input id="txtCugunoq.*" type="hidden" class="txt c1"/>
						<input id="txtNosold.*" type="hidden" class="txt c1"/>
						<input id="txtStationno.*" type="hidden" class="txt c1"/>
						<input id="txtStation.*" type="hidden" class="txt c1"/>
					</td>
					<td>
						<input id="textDatea.*" type="text" class="txt c1"/>
						<input id="btnChildchange.*" type="button" style="float: center;" value="子階開工異動"/>
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
					<td style='display: none;'><input id="txtPretime.*" type="text" class="txt num c1"/></td>
					<td><input id="txtOrgcuadate.*" type="text" class="txt c1"/></td>
					<td><input id="txtOrguindate.*" type="text" class="txt c1"/></td>
					<td><input id="txtCuadate.*" type="text" class="txt c1" style="color: red;"/></td>
					<td style='display: none;'><input id="txtUindate.*" type="text" class="txt c1" style="color: red;"/></td>
					<td>
						<input id="txtThours.*" type="text" class="txt  num c1"/>
						<input id="txtDhours.*" type="hidden" class="txt num c1"/>
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
