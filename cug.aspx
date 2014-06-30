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
            ,['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx']
            ,['textCugtbstationno', '', 'station', 'noa,station', 'textCugtbstationno', ''],['textCugtestationno', '', 'station', 'noa,station', 'textCugtestationno', '']
            ,['textRealbstationno', '', 'station', 'noa,station', 'textRealbstationno', ''],['textRealestationno', '', 'station', 'noa,station', 'textRealestationno', '']
            ,['textRealbstationgno', '', 'stationg', 'noa,namea', 'textRealbstationgno', ''],['textRealestationgno', '', 'stationg', 'noa,namea', 'textRealestationgno', '']
            ,['textRealbtggno', '', 'tgg', 'noa,comp', 'textRealbtggno', ''],['textRealetggno', '', 'tgg', 'noa,comp', 'textRealetggno', '']
            );
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            }).mousedown(function(e) {
				if (!$('#div_row').is(':hidden')) {
					if (mouse_div) {
						$('#div_row').hide();
					}
					mouse_div = true;
				}
			});

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
			var t_xshowover='#non';
            function mainPost() {
                bbmMask = [['txtBdate', r_picd],['txtEdate', r_picd]];
                bbsMask = [['txtCuadate', r_picd],['txtUindate', r_picd],['txtNos', '9999'],['textDatea', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                
                $('#btnWorkgg').click(function() {
                	/*if(emp($('#txtStationno').val())){
                		alert(q_getMsg('lblStation')+'請先填寫。');
                		return;
                	}
                	
                	var bdate=!emp($('#txtBdate').val())?$('#txtBdate').val():q_date();
                	var edate=!emp($('#txtEdate').val())?$('#txtEdate').val():q_cdn(bdate,13);
                	var stationo=!emp($('#txtStationno').val())?$('#txtStationno').val():'#non';
                	var issaturday = (q_getPara('sys.saturday').toString()=='1'?'1':'0');
                	
					q_func('qtxt.query.z_workgg1','z_workgg.txt,z_workgg1,'+
							bdate + ';' + edate + ';' + issaturday + ';' +	stationo + ';' + stationo + ';' +
							'#non' + ';' +	'#non' + ';' +	'#non' + ';' +	t_xshowover + ';'
					);*/
					
					q_box("z_workgg.aspx", 'z_workgg', "95%", "95%", q_getMsg("btnWorkgg"));
				});
                
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
						$('#separationa_'+i).text('');
                		$('#separationb_'+i).text('');
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
					//預設
					$('#textRealbdate').val($('#txtBdate').val());
					$('#textRealedate').val($('#txtEdate').val());
					$('#checkSigntgg').prop('checked','true');
					
					$('#div_real').css('top', $('#btnWorkRealAll').offset().top+25);
					$('#div_real').css('left', $('#btnWorkRealAll').offset().left-$('#div_real').width()+$('#btnWorkRealAll').width()+10);
					$('#div_real').toggle();
					q_cur=2;
				});
				
				$('#btnCugt2').click(function() {
					$('#textCugtbdate').val($('#txtBdate').val());
					$('#textCugtedate').val($('#txtEdate').val());
					$('#textCugtbstationno').val($('#txtStationno').val());
					$('#textCugtestationno').val($('#txtStationno').val());
					$('#textCugtGen').val(round(q_div(dec($('#txtGenorg').val()),dec($('#txtSmount').val())),0));
					if(q_getPara('sys.saturday').toString()=='1')
						$('#checkSaturday').prop('checked','true')
					else
						$('#checkSaturday').prop('checked','')
					$('#checkSunday').prop('checked','')
					
					$('#div_cugt').css('top', $('#btnCugt2').offset().top+25);
					$('#div_cugt').css('left', $('#btnCugt2').offset().left-$('#div_cugt').width()+$('#btnCugt2').width()+10);
					$('#div_cugt').toggle();
					q_cur=2;
				});
				
				//DIV事件---------------------------------------------------
				$('#textCugtbdate').mask('999/99/99');
				$('#textCugtbdate').datepicker();
				$('#textCugtedate').mask('999/99/99');
				$('#textCugtedate').datepicker();
				
				$('#textCugtGen').keyup(function() {
					var tmp=$('#textCugtGen').val().replace(/[^\d]/g,'');
					$('#textCugtGen').val(tmp);
				});
				
				$('#btn_div_cugt').click(function() {
					if(emp($('#textCugtbdate').val()) || emp($('#textCugtedate').val())){
						alert('請填寫日期區間!!');
						return;
					}
					
					if(emp($('#textCugtbstationno').val()) && emp($('#textCugtestationno').val())){
						if(!confirm("確定要更新全部的工作線別?"))
							return;
					}
					
					if(dec($('#textCugtGen').val())<=0){
						if(dec($('#textCugtGen').val())<0){
							alert('請填寫正確產能!!');
							return;
						}else{
							if(!confirm("確定要將產能設置成0?"))
								return;	
						}
					}
					
					var t_week='';
					if(!$('#div_cugtweek').is(':hidden')){
						$('#div_cugtweek input[type="checkbox"]').each(function(){
							if($(this).prop('checked'))
								t_week+=$(this).val()+'^';
						});
					}
					
					if(t_week=='')
						t_week='#non';
					
					var t_cugt_bstationno=!emp($('#textCugtbstationno').val())?trim($('#textCugtbstationno').val()):'#non';
					var t_cugt_estationno=!emp($('#textCugtestationno').val())?trim($('#textCugtestationno').val()):'#non';
					var t_cugt_bstationgno=!emp($('#textCugtbstationgno').val())?trim($('#textCugtbstationgno').val()):'#non';
					var t_cugt_estationgno=!emp($('#textCugtestationgno').val())?trim($('#textCugtestationgno').val()):'#non';
					var t_cugt_bdate=!emp($('#textCugtbdate').val())?trim($('#textCugtbdate').val()):'#non';
					var t_cugt_edate=!emp($('#textCugtedate').val())?trim($('#textCugtedate').val()):'#non';
					var t_cugt_saturday=$('#checkSaturday').prop('checked')?'1':'#non';
					var t_cugt_sunday=$('#checkSunday').prop('checked')?'1':'#non';
					var t_cugt_gen=dec($('#textCugtGen').val()).toString();
					
					$('#btn_div_cugt').attr('disabled', 'disabled');
					$('#btn_div_cugt').val('更新中....');
					q_func('qtxt.query.cugtchange', 'cug.txt,cugtchange,'+t_cugt_bstationno+';'+t_cugt_estationno+';'+t_cugt_bstationgno+';'+t_cugt_estationgno
					+';'+t_cugt_bdate+';'+t_cugt_edate+';'+t_cugt_saturday+';'+t_cugt_sunday+';'+t_cugt_gen+';'+t_week+';'+r_name);
					q_cur=0;
					$('#div_cugtweek').hide();
				});
				
				$('#btnClose_div_cugt').click(function() {
					q_cur=0;
					$('#div_cugt').toggle();
					$('#div_cugtweek').hide();
				});
				
				$('#btn_div_cugtweek').click(function() {
					$('#div_cugtweek').show();
					//產生勾選日期
					var week_bdate=$('#textCugtbdate').val();
					var week_edate=$('#textCugtedate').val();
					
					if(week_bdate=='' && week_edate==''){
						week_bdate=q_date();
						week_edate=q_cdn(q_date(),13);
					}else if(week_bdate!='' && week_edate==''){
						week_edate=q_cdn(week_bdate,13);
					}else if(week_bdate=='' && week_edate!=''){
						week_bdate=q_cdn(week_edate,-13);
					}
					
					$('#div_cugtweek').css('top', $('#div_cugt').offset().top);
					$('#div_cugtweek').css('left', $('#div_cugt').offset().left-$('#div_cugtweek').width()-5);
					
					var tmp_checkbox='',t_week=1;
					while(week_bdate<=week_edate){
						if(q_holiday.indexOf(week_bdate)>-1 || getweek(week_bdate)=='日' || (getweek(week_bdate)=='六' && q_getPara('sys.saturday').toString()=='0'))
							tmp_checkbox += "<div style='float:left;text-align: center;'>&nbsp;<a class='lbl' id='week_" + t_week + "' style='color:red;'>" + week_bdate +"("+getweek(week_bdate)+")</a>&nbsp;<BR>"
							+"<input id='checkweek" + t_week + "' type='checkbox' value='" + week_bdate +"'/></div>";
						else{
							tmp_checkbox += "<div style='float:left;text-align: center;'>&nbsp;<a class='lbl' id='week_" + t_week + "' >" + week_bdate +"("+getweek(week_bdate)+")</a>&nbsp;<BR>"
							+"<input id='checkweek" + t_week + "' type='checkbox' value='" + week_bdate +"'/></div>";
						}
						week_bdate=q_cdn(week_bdate,1);
						t_week++;
					}
					$('#div_cugtweek').html(tmp_checkbox);
				});
				
				$('#textRealbdate').mask('999/99/99');
				$('#textRealbdate').datepicker();
				$('#textRealedate').mask('999/99/99');
				$('#textRealedate').datepicker();
				
				$('#btn_div_real').click(function() {
					var r_bdate=trim($('#textRealbdate').val())==''?'#non':trim($('#textRealbdate').val());
					var r_edate=trim($('#textRealedate').val())==''?'#non':trim($('#textRealedate').val());
					var r_bcuano=trim($('#textRealbcuano').val())==''?'#non':trim($('#textRealbcuano').val());
					var r_ecuano=trim($('#textRealecuano').val())==''?'#non':trim($('#textRealecuano').val());
					var r_bworkno=trim($('#textRealbworkno').val())==''?'#non':trim($('#textRealbworkno').val());
					var r_eworkno=trim($('#textRealeworkno').val())==''?'#non':trim($('#textRealeworkno').val());
					var r_bstationno=trim($('#textRealbstationno').val())==''?'#non':trim($('#textRealbstationno').val());
					var r_estationno=trim($('#textRealestationno').val())==''?'#non':trim($('#textRealestationno').val());
					var r_bstationgno=trim($('#textRealbstationgno').val())==''?'#non':trim($('#textRealbstationgno').val());
					var r_estationgno=trim($('#textRealestationgno').val())==''?'#non':trim($('#textRealestationgno').val());
					var r_btggno=trim($('#textRealbtggno').val())==''?'#non':trim($('#textRealbtggno').val());
					var r_etggno=trim($('#textRealetggno').val())==''?'#non':trim($('#textRealetggno').val());
					
					var r_sigtngg=$('#checkSigntgg').prop('checked')?'1':'#non';
					
					var r_tmp=trim($('#textRealbdate').val())+trim($('#textRealedate').val())+trim($('#textRealbcuano').val())
									+trim($('#textRealecuano').val())+trim($('#textRealbworkno').val())+trim($('#textRealeworkno').val())
									+trim($('#textRealbstationno').val())+trim($('#textRealestationno').val())+trim($('#textRealbstationgno').val())
									+trim($('#textRealestationgno').val());
									
					if(r_tmp.length>0){
						$('#btn_div_real').attr('disabled', 'disabled');
						$('#btn_div_real').val('轉換中....');
						q_func('qtxt.query.workrealall', 'cug.txt,workrealall,'+r_bdate+';'+r_edate+';'+r_bcuano+';'+r_ecuano+';'+r_bworkno+';'+r_eworkno
						+';'+r_bstationno+';'+r_estationno+';'+r_bstationgno+';'+r_estationgno+';'+r_btggno+';'+r_etggno+';'+r_sigtngg+';'+r_name);
					}else
						alert("填寫資料有問題!!");
						
					q_cur=0;
				});
				
				$('#btnClose_div_real').click(function() {
					$('#div_real').toggle();
					q_cur=0;
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
						
						$(this).mousedown(function(e) {
							divdate=false;
							$(this).focus();
							$(this).select();
						});
						
						$(this).bind('keydown', function(event) {
							if($(this).attr('id').indexOf('copy_txtCuadate_')>-1){
								divdate=true;
								divkdate=true;
							}else
								divdate=false;
							
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
						del_cugunoq=del_cugunoq+(del_cugunoq.length>0?'&':'')+$('#textCugunoq').val();
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
					//執行排產計算
					scheduling();
					//處理bbs格式 
	                /*for (var i = 0; i < q_bbsCount; i++) {
						$('#txtCuadate_'+i).attr('disabled', 'disabled');
						//$('#txtUindate_'+i).attr('disabled', 'disabled');
						$('#separationa_'+i).text('');
                		$('#separationb_'+i).text('');
						
						if(!emp($('#txtWorkno_'+i).val())){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','black').css('background','white').removeAttr('readonly');
							if(r_modi || r_modi==undefined)
								$('#textDatea_'+i).css('color','black').css('background','white').removeAttr('readonly');
							else
								$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
							$('#btnCopy_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5 ){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
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
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}*/
					$('#div_copy').toggle();
				});
				
				$('#btnClose_div_copy').click(function() {
					$('#div_copy').toggle();
				});
				
				$('#lblTop_row').mousedown(function(e) {
					if (e.button == 0) {
						mouse_div = false;
						q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
						bbsAssign();
					}
				});
				
				//下方插入空白行
				$('#lblDown_row').mousedown(function(e) {
					if (e.button == 0) {
						mouse_div = false;
						q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
						bbsAssign();
					}
				});
            }
            
            var divdate=false;
            var divkdate=false;
			var getnewgen=false;
            function scheduling(){
            	if(!getnewgen){
            		q_gt('station', "where=^^noa='"+$('#txtStationno').val()+"' ^^", 0, 0, 0, "getgen", r_accy);
            		return;
            	}
            	
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
                
                //依應開工日做為排程開始日
                for (var i = 0; i < q_bbsCount; i++) {
                	if(!emp($('#textDatea_'+i).val()))
	               		$('#txtCuadate_'+i).val($('#textDatea_'+i).val());
	               	
	               	$('#separationa_'+i).text('');
                	$('#separationb_'+i).text('');	
                	
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
					t_bbs.sort(compare);
					for (var i = 0; i < t_bbs.length; i++) {
	               		for (var j = 0; j < fbbs.length; j++) {
	               			$('#'+fbbs[j]+'_'+i).val(t_bbs[i][fbbs[j]]);
	               		}
					}
				}
                //---------------------------------------------------------------------------------------------------------------
                //處理資料
                //0526 沒有資料預設8小時 機台1台
                //0513 強制當天會做完所以不處理 拆分兩個work、延後、剩餘一小時不處理等動作
                var t_genorg=dec($('#txtGenorg').val())>0?dec($('#txtGenorg').val()):8;//原始產能
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
							if(round(q_div(q_sub(t_gen,t_hours),smount),2)>=0){
								$('#separationa_'+i).text($('#txtCuadate_'+i).val()).css('color','blue');
								$('#separationb_'+i).text('當天累計：'+round(q_div(t_hours,smount),2)+'HR;剩餘：'+round(q_div(q_sub(t_gen,t_hours),smount),2)+'HR').css('color','blue');
							}
							else{
								$('#separationa_'+i).text($('#txtCuadate_'+i).val()).css('color','red');
								$('#separationb_'+i).text('當天累計：'+round(q_div(t_hours,smount),2)+'HR;剩餘：'+round(q_div(q_sub(t_gen,t_hours),smount),2)+'HR').css('color','red');
							}
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
						$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
						$('#btnCopy_'+i).removeAttr('disabled');
						$('#btnChildchange_'+i).removeAttr('disabled');
					}else if ($('#txtNos_'+i).val().length==5 ){
						$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).removeClass('hasDatepicker');
						$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
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
						$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
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
                			alert("該工作線別不存在!!");
                			$('#btnCug').removeAttr('disabled');
                		}else{
                			$('#txtGenorg').val(dec(as[0].gen)>0?dec(as[0].gen):8);
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
                			alert("該工作線別已存在!!");
                		}else{
                			station_chk=true;
                			$('#btnWork').click();
                		}
                		break;*/
                	/*case 'station_btnok':
                		var as = _q_appendData("cug", "", true);
                		if(as[0]!=undefined){
                			alert("該工作線別已存在!!");
                		}else{
                			station_btnok=true;
                			$('#btnOk').click();
                		}
                		break;*/
                	case 'cug_work':
                		var as = _q_appendData("view_cugu", "", true);
                		if(as[0]!=undefined){							
							q_gridAddRow(bbsHtm, 'tbbs'
							,'txtNos,txtNoq,txtProcessno,txtProcess,txtProductno,txtProduct,txtSpec,txtStyle,txtMount,txtHours,txtCuadate,txtUindate,txtOrgcuadate,txtOrguindate,txtWorkno,txtWorkgno,txtOrdeno,txtPretime,txtCugunoq,txtNosold', as.length, as,
							'nos,noq,processno,process,productno,product,spec,style,mount,hours,cuadate,uindate,orgcuadate,orguindate,workno,workgno,ordeno,pretime,cugunoq,nos','txtProductno,txtProcess,txtWorkno');
							
							/*for (var i = 0; i < q_bbsCount; i++) {
								$('#txtCuadate_'+i).attr('disabled', 'disabled');
								//$('#txtUindate_'+i).attr('disabled', 'disabled');
								$('#txtCuadate_'+i).css('background-color','rgb(237, 237, 238)');
								//$('#txtUindate_'+i).css('background-color','rgb(237, 237, 238)');
							}*/
							scheduling();
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
                q_box('z_cugp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
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
            var row_b_seq = '';
            var row_bbsbbt = '';
            //控制滑鼠消失div
            var mouse_div = true;
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
								t_where = "charindex(noa,'"+$('#txtWorkgno_' + b_seq).val()+"')>0";
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
						
						$('#btnPlus_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(e.button==0){
								mouse_div = false;
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//顯示選單
								$('#div_row').show();
								//儲存選取的row
								row_b_seq = b_seq;
								//儲存要新增的地方
								row_bbsbbt = 'bbs';
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
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
							$('#btnCopy_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
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
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
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
                	$('.dbbs').css('width','1950px');
                }else{
                	$('.isstyle').hide();
                	$('.dbbs').css('width','1760px');
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
                $('#div_realweek').hide();
                $('#div_cugt').hide();
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
	            	$('#btnCugt2').removeAttr('disabled');
	            }else{
	            	$('#btnWork').removeAttr('disabled');
	            	$('#btnCug').removeAttr('disabled');
	            	$('#btnCugt').removeAttr('disabled');
	            	$('#btnWorkReal').attr('disabled', 'disabled');
	            	$('#btnWorkRealAll').attr('disabled', 'disabled');
	            	$('#btnCugt2').attr('disabled', 'disabled');
	            }
                
                if(q_getPara('sys.isstyle')=='1'){
                	$('.isstyle').show();
                	$('.dbbs').css('width','1950px');
                }else{
                	$('.isstyle').hide();
                	$('.dbbs').css('width','1760px');
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
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
							$('#btnCopy_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5 ){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
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
							$('#textDatea_'+i).datepicker({defaultDate:$('#txtCuadate_'+i).val()});
							$('#btnCopy_'+i).attr('disabled', 'disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
						$('#btnPlus_'+i).removeAttr('disabled');
					}else{
						if(!emp($('#txtWorkno_'+i).val())){
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else{
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
						$('#btnCopy_'+i).attr('disabled', 'disabled');
						$('#btnPlus_'+i).attr('disabled', 'disabled');
					}
				}
				if(issave){
            		issave=false;
            		var s2=new Array('cug_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
					q_boxClose2(s2);
				}
				$('.ui-datepicker').css('margin-left','100px');
				$('#div_real').hide();
				$('#div_realweek').hide();
				$('#div_cugt').hide();
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
                	case 'qtxt.query.cugtchange':
                		alert("更新完成!!");
                		$('#btn_div_cugt').removeAttr('disabled');
                		$('#btn_div_cugt').val('更新');
                		$('#div_cugt').toggle();
                	break;
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
                	case 'qtxt.query.z_workgg1':
                		var DayName = ['週日','週一','週二','週三','週四','週五','週六'];
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{					
							var t_bdate = !emp($('#txtBdate').val())?$('#txtBdate').val():q_date();
							var t_edate = !emp($('#txtEdate').val())?$('#txtEdate').val():q_cdn(bdate,13);
							var t_bADdate = dec(t_bdate.substring(0,3))+1911+t_bdate.substr(3);
							var t_eADdate = dec(t_edate.substring(0,3))+1911+t_edate.substr(3);
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = dec(thisDay.substring(0,3))+1911+thisDay.substr(3);
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										mount:0
									});
								}
							}
							
							var t_totalWidth = 0;
							t_totalWidth = 670+((40+2)*(DateObj.length+1+2))+10;
							var TL = [];
							var OutHtml= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0" style="width:'+t_totalWidth+';">';
							for(var i=0;i<as.length;i++){
								var isFind = false;
								for(var j=0;j<TL.length;j++){
									if((as[i].stationno==TL[j].stationno)){
										TL[j].rate = q_add(dec(TL[j].rate),dec(as[i].mount));
										TL[j].days = q_add(dec(TL[j].days),1);
										isFind = true;
									}
								}
								if(!isFind){
									TL.push({
										stationno : as[i].stationno,
										station : as[i].station,
										gen : (dec(as[i].gen)==0?8:dec(as[i].gen)),
										rate : 0,
										days : 1,
										datea : []
									});
								}
							}
							for(var k=0;k<TL.length;k++){
								for(var j=0;j<DateList.length;j++){
									TL[k].datea.push([DateList[j],0,TL[k].gen]);
								}
							}
							for(var k=0;k<as.length;k++){
								isFind = false;
								for(var j=0;j<TL.length;j++){
									if(isFind) break;
									if((as[k].stationno==TL[j].stationno)){
										var TLDatea = TL[j].datea;
										for(var h=0;h<TLDatea.length;h++){
											if(as[k].datea==TLDatea[h][0]){
												TLDatea[h][1] = dec(TLDatea[h][1])+dec(as[k].mount);
												isFind = true;
												break;
											}
										}
									}
								}
							}
							OutHtml += '<tr>';
							OutHtml += "<td class='tTitle' style='width:240px;' colspan='2' rowspan='2'>工作線別</td>" +
								   "<td class='tTitle' style='width:60px;' rowspan='2'>日產能</td>" +
								   "<td class='tTitle' style='width:80px;' rowspan='2'>稼動率</td>";
							var tmpTd = '<tr>';
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								var thisADday = dec(thisDay.substring(0,3))+1911+thisDay.substr(3);
								OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(4) + "</td>";
								tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0;
							for(var k=0;k<TL.length;k++){
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:120px;'>" + TL[k].stationno + "</td><td class='Lproduct' style='width:120px;'>" + TL[k].station + "</td>" +
										   "<td class='num'>" + TL[k].gen + "</td>" +
										   "<td class='num'>" + (dec(TL[k].gen)==0?0:round(q_mul(q_div(TL[k].rate,q_mul(TL[k].gen,TL[k].days)),100),3)) + "</td>";
								var TTD = TL[k].datea;
								var tTotal = 0;
								for(var j=0;j<TTD.length;j++){
									var thisValue = round(TTD[j][1],3);
									if(t_xshowover=='1'){
										thisValue = (thisValue==0?'':thisValue);
									}
									var thisGen = dec(TTD[j][2]);
									tTotal = q_add(tTotal,round(TTD[j][1],3));
									DateObj[j].mount = q_add(dec(DateObj[j].mount),round(TTD[j][1],3));
									OutHtml += "<td class='num'"+(thisValue>thisGen?' style="color:red;"':'')+"><font title='日產能:"+thisGen+"'>" + thisValue + "</font></td>";
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + tTotal + "</td>";
								OutHtml += '</tr>';
							}
							OutHtml += "<tr><td colspan='4' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + round(DateObj[k].mount,3) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + round(ATotal,3) + "</td>";
							OutHtml += "</table>"
							
							var csstmp='<style type="text/css"> #tTable{table-layout: fixed;}	#chgTitle:nth-child(even){	background-color:#CEFFC6;}.tTitle{text-align:center;background: #FF9;}';
							csstmp+=' .tTotal{	text-align:right;background: #CFF;	}.center{text-align:center;}	.Lproduct{text-align:left;padding-left:3px;}	.num{text-align:right;	padding-right:2px;	}';
							csstmp+=' .tWidth_Station{padding-left:2px;	width:100px;}.tWidth{width:70px;}.q_report .report {position: relative;width: 460px;margin-right: 2px;border: 1px solid #76a2fe;background: #EEEEEE;float: left;border-radius: 5px;}';
							csstmp+=' </style>';
							
							var w=window.open('','','width='+t_totalWidth+',height=150');
							w.document.open();
							w.document.title=q_getMsg('btnWorkgg');
							w.document.write(csstmp+OutHtml);
							
							//$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
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
            
			function compare(a,b) {
				if (a.txtCuadate+a.txtNos+a.txtCugunoq< b.txtCuadate+b.txtNos+b.txtCugunoq)
					return -1;
				if (a.txtCuadate+a.txtNos+a.txtCugunoq > b.txtCuadate+b.txtNos+b.txtCugunoq)
					return 1;
				return 0;
			}
			
			function getweek(t_date) {
            	switch (new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()) {
            		case 0:
            			return '日'; 
            			break;
            		case 1:
            			return '一';
            			break;
            		case 2:
            			return '二';
            			break;
            		case 3:
            			return '三';
            			break;
            		case 4:
            			return '四';
            			break;
            		case 5:
            			return '五';
            			break;
            		case 6:
            			return '六';
            			break;
            		default:
            			return '';
  						break;
            	}
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
		<div id="div_cugt" style="position:absolute; top:0px; left:0px; display:none; width:510px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_cugt" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">工作線別區間</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtbstationno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textCugtestationno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">管理單位區間</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtbstationgno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textCugtestationgno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">日期區間</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtbdate' type='text' style='text-align:left;width:100px;'/>	~
						<input id='textCugtedate' type='text' style='text-align:left;width: 100px;'/>	
						包含	<input id="checkSaturday" type="checkbox">	六 		<input id="checkSunday" type="checkbox">	日
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">工時</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtGen' type='text' style='text-align:left;width:100px;'/>
						<input id="btn_div_cugtweek" type="button" style="float: right;margin-right: 75px;" value="挑選日期">
					</td>
				</tr>
				<tr id='cugt_close'>
					<td align="center" colspan='2'>
						<input id="btn_div_cugt" type="button" value="更新">
						<input id="btnClose_div_cugt" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_cugtweek" style="position:absolute; top:0px; left:0px; display:none; width:690px; background-color: rgb(255, 240, 237); border: 5px solid gray;">	</div>
		<!---DIV分隔線---->
		<div id="div_real" style="position:absolute; top:0px; left:0px; display:none; width:510px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_real" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">應開工日區間</td>
					<td style="background-color: #f8d463;">
						<input id='textRealbdate' type='text' style='text-align:left;width:80px;'/>	~
						<input id='textRealedate' type='text' style='text-align:left;width: 80px;'/>
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
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">工作線別區間</td>
					<td style="background-color: #f8d463;">
						<input id='textRealbstationno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textRealestationno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">管理單位區間</td>
					<td style="background-color: #f8d463;">
						<input id='textRealbstationgno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textRealestationgno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">委外廠商區間</td>
					<td style="background-color: #f8d463;">
						<input id='textRealbtggno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textRealetggno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">委外送簽核</td>
					<td style="background-color: #f8d463;"><input id="checkSigntgg" type="checkbox">	</td>
				</tr>
				<tr id='real_close'>
					<td align="center" colspan='2'>
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
						製成品全部子階&nbsp;&nbsp;
						提前&nbsp;
						<input id='textAllEarlyday' type='text' style='text-align:right;width: 50px;'/>
						往後&nbsp;
						<input id='textAllDelayday' type='text' style='text-align:right;width: 50px;'/>
						天&nbsp;&nbsp;
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
					<td style="background-color: #CDFFCE;width:12%;" align="center">工作線別/廠商</td>
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
		<!---DIV分隔線---->
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row" class="table_row" style="width:100%;" border="1" cellpadding='1' cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
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
						<td class="td2" style="width: 176px;"><input id="btnWorkgg" type="button" style="float: center;"/></td>
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
						<td class="td5" >
							<input id="btnWork" type="button" style="float: right;"/>
							<input id="btnCugt" type="button" style="float: right;"/>
						</td>
						<td class="td5">
							<input id="btnCug" type="button" style="float: center;"/>
							<input id="btnCugt2" type="button" style="float: center;"/>
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
					<td align="center" style="width:85px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
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
						<input class="btn"  id="btnPlus.*" type="button" value='+'  />
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
						<span id='separationa.*' style="color: red;font-size: larger;"> </span>
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1"/>
						<span id='separationb.*' style="font-size: medium;"> </span>
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
