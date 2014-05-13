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
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
			
			var t_cugt=undefined;//儲存cugt的資料
			//var station_chk=false;
			//var first_cur2=false;//第一次匯入
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
                	if(emp($('#txtBdate').val())){
                		alert(q_getMsg('lblCuadate')+'請先填寫。');
                		return;
                	}
                	
                	if(emp($('#txtStationno').val())){
                		alert(q_getMsg('lblStation')+'請先填寫。');
                		return;
                	}
                	
                	//檢查station 是否已存在
                	/*if(q_cur==1 && !station_chk){
                		q_gt('cug', "where=^^stationno='"+$('#txtStationno').val()+"'^^", 0, 0, 0, "station_chk", r_accy);
                		return;
                	}else{
                		station_chk=false;*/
                	//}
                	
                	//0513 只要匯入bbs就全部砍
                	//if(first_cur2){
	                	for (var i = 0; i < q_bbsCount; i++) {
							$('#btnMinus_'+i).click();
						}
					//}
                	//first_cur2=false;
                		
                	$('#txtStationno').attr('disabled', 'disabled');
                	//$('#txtBdate').attr('disabled', 'disabled');
					$('#lblStationk').css('display', 'inline').text($('#lblStation').text());
					$('#lblStation').css('display', 'none');
					
					/*var t_where = "where=^^ ";
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
                	t_where=t_where+"a.noa not in (select workno from view_cugu) ";
                		
                	//排序
                	t_where=t_where+"order by noq,orgcuadate,rank desc,workno^^";
                		
                	var t_where1 = "where[1]=^^ ";
                	var t_bdate='',t_edate='';
                	t_bdate=$('#txtBdate').val();
                	t_edate=!emp($('#txtEdate').val())?$('#txtEdate').val():'999/99/99';
                	t_where1=t_where1+"(a.datea between '"+t_bdate+"' and '"+t_edate+"' ) and ";
                	t_where1=t_where1+"a.stationno='"+$('#txtStationno').val()+"' ^^";
                	
                	q_gt('cug_work', t_where+t_where1, 0, 0, 0, "", r_accy);*/
                	
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
				
				$('#btnClose_div_child').click(function() {
					$('#div_child').toggle();
				});
				
				$('#btnEarlydayok').click(function() {
					if(!emp($('#textEarlyday').val())&&!emp($('#textEarlyworkno').val())){						
						var t_where = $('#textEarlyworkno').val()+ ';' + dec($('#textEarlyday').val());
						q_func('qtxt.query.earlyday', 'cug.txt,earlyday,' + t_where);
						$('#btnEarlydayok').attr('disabled', 'disabled');
					}else{
						alert("資料錯誤!!");
					}
				});
            }
            
			var first_rest=true;
			var getnewgen=false;
            function scheduling(){
            	if(!getnewgen){
            		q_gt('station', "where=^^noa='"+$('#txtStationno').val()+"' ^^", 0, 0, 0, "getgen", r_accy);
            		return;
            	}
            	
            	if($('#txtGenorg').val()<=0){
            		alert(q_getMsg('lblGenorg')+'不得小於0!!');
	               	return;
            	}
            	
            	//禮拜六是否要上班
            	var issaturday=q_getPara('sys.saturday')=='1'?true:false;
                //取得編制時數
                if(t_cugt==undefined){
                	q_gt('view_cugt', "where=^^stationno='"+$('#txtStationno').val()+"' and datea>='"+$('#txtBdate').val()+"' ^^", 0, 0, 0, "cugt", r_accy);
                	return;
                }
                
                //先清除自動產生的空白時數,並將指定開工日寫入到應開工日
                if(first_rest){
	               	for (var i = 0; i < q_bbsCount; i++) {
	               		if(!emp($('#textDatea_'+i).val()))
	               			$('#txtCuadate_'+i).val($('#textDatea_'+i).val());
	               		if($('#txtNos_'+i).val().length==5 && $('#txtNoq_'+i).val().length==12){
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
	                	$('#txtNos_'+i).val(('000'+(dec(maxnos.substr(0,3))+1)).substr(-3)+'0');
	                	$('#txtNoq_'+i).val(replaceAll($('#txtCuadate_'+i).val(), '/','')+$('#txtNos_'+i).val());
                	}
                	//更新沒有排程應開工日的資料>>指定應開工日
                	if(emp($('#txtCuadate_'+i).val()) && (!emp($('#txtProcess_'+i).val()) || !emp($('#txtWorkno_'+i).val()))){
                		if(!emp($('#textDatea_'+i).val())){
                			$('#txtCuadate_'+i).val($('#textDatea_'+i).val());
                		}
                		if(emp($('#txtCuadate_'+i).val())){
                			$('#txtCuadate_'+i).val($('#txtBdate').val());
                		}
                		for (var j = 0; j < q_bbsCount; j++) {
	                		if(i!=j && $('#txtCuadate_'+i).val()==$('#txtCuadate_'+j).val() &&$('#txtNos_'+j).val()>maxnos){
	                			maxnos=$('#txtNos_'+j).val();
	                		}
	                	}
	                	$('#txtNos_'+i).val(('000'+(dec(maxnos.substr(0,3))+1)).substr(-3)+'0');
	                	$('#txtNoq_'+i).val(replaceAll($('#txtCuadate_'+i).val(), '/','')+$('#txtNos_'+i).val());
                	}
                }
                
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
                var t_genorg=dec($('#txtGenorg').val());
                var t_gen=t_genorg;
                var re_scheduling=false;
                var total_hours=0;
                for (var i = 0; i < q_bbsCount; i++) {
                	total_hours=q_add( total_hours,dec($('#txtHours_'+i).val()));
                	if($('#txtCuadate_'+i).val()!='' && $('#txtCuadate_'+i).val().length==9){
                		var setgen=false;//判斷是否有自訂產能
		                //取得當天gen
		                for (var k = 0; k < t_cugt.length; k++) {
		                	if(t_cugt[k].datea==$('#txtCuadate_'+i).val()){
		                		t_gen=dec(t_cugt[k].gen);
		                		setgen=true;
		                	}
		                }
		                
		                //表示當天沒有產能,禮拜六休假且沒有加工,禮拜日沒有加工>>>休息
		                if((setgen && t_gen<=0)
			                || (new Date(dec($('#txtCuadate_'+i).val().substr(0,3))+1911,dec($('#txtCuadate_'+i).val().substr(4,2))-1,dec($('#txtCuadate_'+i).val().substr(7,2))).getDay()==6 && !issaturday && !setgen)
			                || (new Date(dec($('#txtCuadate_'+i).val().substr(0,3))+1911,dec($('#txtCuadate_'+i).val().substr(4,2))-1,dec($('#txtCuadate_'+i).val().substr(7,2))).getDay()==0 && !setgen)
		                ){
		                	var tmpdate=$('#txtCuadate_'+i).val();
		                	//處理目前與之後的應開工日
		                	for (var j = i; j < q_bbsCount; j++) {
		                		if(tmpdate==$('#txtCuadate_'+j).val()){
		                			$('#txtCuadate_'+j).val(q_cdn(tmpdate,1));
		                			$('#txtNos_'+j).val('');
		                		}
		                		if($('#txtCuadate_'+j).val()==q_cdn(tmpdate,1) && emp($('#textDatea_'+j).val())){
		                			$('#txtNos_'+j).val('');
		                		}
		                	}
		                	re_scheduling=true;
		                }
		                if(re_scheduling)
		                	break;
		                //-------------------------------------------------------------------
		                //處理時數
		                //取得當天已工作時數
		                var t_hours=0 //當天暫存已工作時數
		                for (var j = 0; j <i; j++) {
		                	if($('#txtCuadate_'+i).val()==$('#txtCuadate_'+j).val()){
		                		t_hours=q_add( t_hours,dec($('#txtHours_'+j).val()));
		                	}
		                }
		                //如果已工作時數>產能表示當天已沒有產能>>往後排
		                if(t_hours>t_gen){
		                	var tmpdate=$('#txtCuadate_'+i).val();
		                	//處理目前與之後的應開工日
		                	for (var j = i; j < q_bbsCount; j++) {
		                		if(tmpdate==$('#txtCuadate_'+j).val() && $('#txtNos_'+i).val().length!=5 && $('#txtNoq_'+i).val().length!=12){
		                			$('#txtCuadate_'+j).val(q_cdn(tmpdate,1));
		                			$('#txtNos_'+j).val('');
		                		}
		                		if($('#txtCuadate_'+j).val()==q_cdn(tmpdate,1) && emp($('#textDatea_'+j).val())){
		                			$('#txtNos_'+j).val('');
		                		}
		                	}
		                	re_scheduling=true;
		                }
		                if(re_scheduling)
		                	break;
		                //-------------------------------------------------------------------
		                //如果當天總工時時數會跨天>>>拆分兩個work	0513 強制當天會做完
		                /*var tt_hours=q_add( t_hours,dec($('#txtHours_'+i).val()));//當日累計時數
		                if(tt_hours>t_gen){
		                	q_bbs_addrow('bbs',i,1);//下方插入空白行
		                	//將work複製
		                	for (var j = 0; j < fbbs.length; j++) {
		                		$('#'+fbbs[j]+'_'+(i+1)).val($('#'+fbbs[j]+'_'+i).val());
		                	}
		                	
		                	$('#txtCuadate_'+(i+1)).val(q_cdn($('#txtCuadate_'+i).val(),1));
		                	var tmp_hours=dec($('#txtHours_'+i).val());
		                	var tmp_mount=dec($('#txtMount_'+i).val());
		                	$('#txtHours_'+i).val(q_sub(t_gen,t_hours));
		                	$('#txtHours_'+(i+1)).val(q_sub(tt_hours,t_gen));
		                	
		                	$('#txtMount_'+i).val(round(q_mul(tmp_mount,q_div(q_sub(t_gen,t_hours),tmp_hours)),0));
		                	$('#txtMount_'+(i+1)).val(q_sub(tmp_mount,dec($('#txtMount_'+i).val())));
		                	
		                	$('#textDatea_'+(i+1)).val(q_cdn($('#txtCuadate_'+i).val(),1));
		                	$('#txtNos_'+(i+1)).val('0010');
		                	$('#txtNoq_'+(i+1)).val(replaceAll($('#txtCuadate_'+(i+1)).val(), '/','')+$('#txtNos_'+(i+1)).val());
		                	
		                	//檢查隔天最小的排程序號
		                	var minnos='9999'
		                	for (var j = i+2; j < q_bbsCount; j++) {
		                		if(q_cdn($('#txtCuadate_'+i).val(),1)==$('#txtCuadate_'+j).val() && !emp($('#textDatea_'+j).val()) && !emp($('#txtNos_'+j).val())  && minnos>$('#txtNos_'+j).val()){
		                			minnos=$('#txtNos_'+j).val();
		                		}
		                	}
		                	
		                	if(minnos<='0010'){
		                		for (var j = i+2; j < q_bbsCount; j++) {
		                			if(q_cdn($('#txtCuadate_'+i).val(),1)==$('#txtCuadate_'+j).val() && !emp($('#textDatea_'+j).val()) && !emp($('#txtNos_'+j).val())){
		                				$('#txtNos_'+j).val(('0000'+(dec($('#txtNos_'+j).val())+10)).substr(-4));
		                				$('#txtNoq_'+j).val(replaceAll($('#txtCuadate_'+j).val(), '/','')+$('#txtNos_'+j).val());
		                			}
		                		}
		                	}
		                	
		                	//處理當天如果還有work順便延後
		                	for (var j = i+2; j < q_bbsCount; j++) {
		                		if($('#txtCuadate_'+i).val()==$('#txtCuadate_'+j).val()){
		                			$('#txtCuadate_'+j).val(q_cdn($('#txtCuadate_'+i).val(),1));
		                			$('#txtNos_'+j).val('');
		                		}
		                		if(q_cdn($('#txtCuadate_'+i).val(),1)==$('#txtCuadate_'+j).val() && emp($('#textDatea_'+j).val())){
		                			$('#txtNos_'+j).val('');
		                		}
		                	}
		                	
		                	re_scheduling=true;
		                }
		                
		                if(re_scheduling)
		                	break;*/
		                //-------------------------------------------------------------------
		                //完工日
		                $('#txtUindate_'+i).val($('#txtCuadate_'+i).val());
		                //累計工時
		                $('#txtThours_'+i).val(total_hours);
		                
		                //-------------------------------------------------------------------
		                //0506 非機時 >>指實際工作時數>>產能/標準日工時=機器數>>當天產能/機器數=實際工作時數
		                //如果剩餘時數低於一小時且下個排程大於1個小時 插入休息不做
		                //if(q_sub(t_gen,tt_hours)<1 &&q_sub(t_gen,tt_hours)>0 && dec($('#txtHours_'+(i+1)).val())>=1){
		                var smount=dec($('#txtSmount').val());
		                if(q_div(q_sub(t_gen,tt_hours),smount)<1 && q_div(q_sub(t_gen,tt_hours),smount)>0 
		                	&& q_div(dec($('#txtHours_'+(i+1)).val()),smount)>=1){
		                	q_bbs_addrow('bbs',i,1);//下方插入空白行
			                $('#txtCuadate_'+(i+1)).val($('#txtCuadate_'+i).val());
			                $('#txtUindate_'+(i+1)).val($('#txtCuadate_'+i).val());
			                $('#txtHours_'+(i+1)).val(q_sub(t_gen,tt_hours));
			                $('#txtMount_'+(i+1)).val(0);
			                $('#textDatea_'+(i+1)).val($('#txtCuadate_'+i).val());
			                
			                $('#txtNos_'+(i+1)).val($('#txtNos_'+i).val()+'X');
			                $('#txtNoq_'+(i+1)).val(replaceAll($('#txtCuadate_'+(i+1)).val(), '/','')+$('#txtNos_'+(i+1)).val());
			                $('#txtProcess_'+(i+1)).val($('#txtCuadate_'+i).val());
			                //$('#txtSpec_'+(i+1)).val('當天累計：'+tt_hours+'HR;剩餘：'+q_sub(t_gen,tt_hours)+'HR');
			                $('#txtSpec_'+(i+1)).val('當天累計：'+round(q_div(tt_hours,smount),2)+'HR;剩餘：'+round(q_div(q_sub(t_gen,tt_hours),smount),2)+'HR');
			                
			                //處理當天如果還有work順便延後
		                	for (var j = i+2; j < q_bbsCount; j++) {
		                		if($('#txtCuadate_'+i).val()==$('#txtCuadate_'+j).val()){
		                			$('#txtCuadate_'+j).val(q_cdn($('#txtCuadate_'+i).val(),1));
		                			$('#txtNos_'+j).val('');
		                		}
		                		if(q_cdn($('#txtCuadate_'+i).val(),1)==$('#txtCuadate_'+j).val() && emp($('#textDatea_'+j).val())){
		                			$('#txtNos_'+j).val('');
		                		}
		                	}
			                
			                re_scheduling=true;
		                }
		                
		                if(re_scheduling)
		                	break;
		                //-------------------------------------------------------------------
		                //如果當天是最後一筆且非空白行 插入 空白行分隔
						if($('#txtCuadate_'+i).val()!=$('#txtCuadate_'+(i+1)).val() && $('#txtNos_'+i).val().length!=5 && $('#txtNoq_'+i).val().length!=12){
							q_bbs_addrow('bbs',i,1);//下方插入空白行
							$('#txtCuadate_'+(i+1)).val($('#txtCuadate_'+i).val());
			                $('#txtUindate_'+(i+1)).val($('#txtCuadate_'+i).val());
			                $('#txtHours_'+(i+1)).val(0);
			                $('#txtMount_'+(i+1)).val(0);
			                $('#textDatea_'+(i+1)).val($('#txtCuadate_'+i).val());
			                
			                $('#txtNos_'+(i+1)).val($('#txtNos_'+i).val()+'X');
			                $('#txtNoq_'+(i+1)).val(replaceAll($('#txtCuadate_'+(i+1)).val(), '/','')+$('#txtNos_'+(i+1)).val());
			                $('#txtProcess_'+(i+1)).val($('#txtCuadate_'+i).val());
			                //$('#txtSpec_'+(i+1)).val('當天累計：'+tt_hours+'HR;剩餘：'+q_sub(t_gen,tt_hours)+'HR');
			                $('#txtSpec_'+(i+1)).val('當天累計：'+round(q_div(tt_hours,smount),2)+'HR;剩餘：'+round(q_div(q_sub(t_gen,tt_hours),smount),2)+'HR');
			                re_scheduling=true;
						}
		                
		                if(re_scheduling)
		                	break;
		                //-------------------------------------------------------------------
	                }
                }
                
                if(re_scheduling){
                	q_gt('view_cugt', "where=^^stationno='"+$('#txtStationno').val()+"' and datea>='"+$('#txtBdate').val()+"' ^^", 0, 0, 0, "cugt", r_accy);
                	return;
                }
                
                //檢查排程序號是否重複
				for (var i = 0; i < q_bbsCount; i++) {
	               	for (var j = i+1; j < q_bbsCount; j++) {
	               		if (i!=j &&$('#txtNoq_'+i).val()==$('#txtNoq_'+j).val()&&(!emp($('#txtProcess_'+i).val())||!emp($('#txtWorkno_'+i).val()))){
	               			alert(q_getMsg('lblNoq_s')+'['+$('#txtNos_'+i).val()+']重覆')
	               			return;
	               		}
	               	}
				}
                
                //處理格式
                for (var i = 0; i < q_bbsCount; i++) {
					
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					$('#txtUindate_'+i).attr('disabled', 'disabled');
					
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
						$('#btnMinus_'+i).removeAttr('disabled');
						$('#btnChildchange_'+i).removeAttr('disabled');
					}else if ($('#txtNos_'+i).val().length==5 && $('#txtNoq_'+i).val().length==12){
						$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#textDatea_'+i).removeClass('hasDatepicker');
						$('#textDatea_'+i).datepicker();
						$('#textDatea_'+i).datepicker('destroy');
						$('#btnMinus_'+i).attr('disabled', 'disabled');
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
						$('#btnMinus_'+i).removeAttr('disabled');
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
                	case 'station_chk':
                		var as = _q_appendData("cug", "", true);
                		if(as[0]!=undefined){
                			alert("該工作中心已存在!!");
                		}else{
                			station_chk=true;
                			$('#btnWork').click();
                		}
                		break;
                	case 'station_btnok':
                		var as = _q_appendData("cug", "", true);
                		if(as[0]!=undefined){
                			alert("該工作中心已存在!!");
                		}else{
                			station_btnok=true;
                			$('#btnOk').click();
                		}
                		break;	
                	case 'cug_work':
                		var as = _q_appendData("view_cugu", "", true);
                		if(as[0]!=undefined){
                			for ( var i = 0; i < as.length; i++) {
                				//製令
                				if(as[i].noq=='99999999999'){
                					as[i].noq='';
                					as[i].cuadate=as[i].orgcuadate;
                				}
                				//cugu
                				if(as[i].nos=='9000'){
                					var tmp_nos='ZZZZ'
                					for ( var j = i+1; j < as.length; j++) {
                						if(as[i].cuadate==as[i].cuadate &&tmp_nos>as[j].nos){
                							tmp_nos=as[j].nos;
                						}
                					}
                					if(tmp_nos=='ZZZZ')//表示當天沒有其他排程
                						as[j].nos='0010'
                					
                					
                				}
                			}
                			
                			//判斷是否已被匯入
                			for (var i = 0; i < q_bbsCount; i++) {
								for (var j = 0; j < as.length; j++) {
									if($('#txtWorkno_' + i).val()==as[j].workno && $('#txtProcess_'+i).val()==as[j].process){
										as.splice(j, 1);
                                    	j--;
										break;	
									}
								}
							}
							
							q_gridAddRow(bbsHtm, 'tbbs'
							,'txtNos,txtNoq,txtProcessno,txtProcess,txtProductno,txtProduct,txtSpec,txtStyle,txtMount,txtHours,txtCuadate,txtUindate,txtOrgcuadate,txtOrguindate,txtWorkno,txtWorkgno,txtOrdeno,txtPretime,txtCugunoq', as.length, as,
							'nos,noq,processno,process,productno,product,spec,style,mount,hours,cuadate,uindate,orgcuadate,orguindate,workno,workgno,ordeno,pretime,cugunoq','txtProductno,txtProcess,txtWorkno');
							
							for (var i = 0; i < q_bbsCount; i++) {
								$('#txtCuadate_'+i).attr('disabled', 'disabled');
								$('#txtUindate_'+i).attr('disabled', 'disabled');
								$('#txtCuadate_'+i).css('background-color','rgb(237, 237, 238)');
								$('#txtUindate_'+i).css('background-color','rgb(237, 237, 238)');
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
						
						if(as[0]!=undefined){
							$('#textEarlyday').val('');
							var child_row = 0;
							for (var i = 0; i < as.length; i++) {
								var tr = document.createElement("tr");
								tr.id = "bbs_" + j;
								tr.innerHTML = "<td><input id='child_txtWorkno_" + child_row + "' type='text' class='txt c1' value='" + as[i].noa + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td><input id='child_txtProductno_" + child_row + "' type='text' class='txt c1' value='" + as[i].productno + "' disabled='disabled' /><input id='child_txtProduct_" + child_row + "' type='text' class='txt c1' value='" + as[i].product + "' disabled='disabled' /></td>";
								tr.innerHTML += "<td><input id='child_txtStation_" + child_row + "' type='text' class='txt c1' value='" + as[i].station + "' disabled='disabled' /><input id='child_txtProcess_" + child_row + "' type='text' class='txt c1' value='" + as[i].process + "' disabled='disabled' /></td>";
								tr.innerHTML += "<td><input id='child_txtStyle_" + child_row + "' type='text' class='txt c1' value='" + as[i].style + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td><input id='child_txtMount_" + child_row + "' type='text' class='txt c1 num' value='" + FormatNumber(as[i].mount) + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td><input id='child_txtHours_" + child_row + "' type='text' class='txt c1 num' value='" + FormatNumber(as[i].hours) + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td><input id='child_txtCuadate_" + child_row + "' type='text' class='txt c1' value='" + as[i].cuadate + "' disabled='disabled'/></td>";
								var tmp = document.getElementById("child_close");
								tmp.parentNode.insertBefore(tr, tmp);
								child_row++;
							}
							$('#btnEarlydayok').removeAttr('disabled');
							$('#div_child').css('top', mouse_point.pageY);
							$('#div_child').css('left', mouse_point.pageX);
							$('#div_child').toggle();
						}else{
							alert("無子階資料");
							$('#btnEarlydayok').attr('disabled', 'disabled');
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
                
                //檢查station 是否已存在
                /*if(q_cur==1 && !station_btnok){
                	q_gt('cug', "where=^^stationno='"+$('#txtStationno').val()+"'^^", 0, 0, 0, "station_btnok", r_accy);
                	return;
                }*/
                
                if(!cngisbtnok){
                	cngisbtnok=true;
                	q_gt('view_cugt', "where=^^stationno='"+$('#txtStationno').val()+"' and datea>='"+$('#txtBdate').val()+"' ^^", 0, 0, 0, "cugt", r_accy);
                	return;
                }
                
                //station_chk=false;
                cngisbtnok=false;
                sum();
                
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

				
                /*var t_noa = trim($('#txtStationno').val());
                $('#txtNoa').val(t_noa);

                wrServer(t_noa);*/
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cug_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtBdate').val(q_date());
                $('#txtKdate').val(q_date());
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
				$('#txtStationno').attr('disabled', 'disabled');
				$('#lblStationk').css('display', 'inline').text($('#lblStation').text());
				$('#lblStation').css('display', 'none');
				$('#txtBdate').val(q_date());
				//first_cur2=true;
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
			var mouse_point;
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
		                
		                $('#txtNos_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                	if(q_cur==1 || q_cur==2){}
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
									$('#textEarlyworkno').val($('#txtWorkno_' + b_seq).val());
									mouse_point = e;
									//查詢子階work
									var t_where = "where=^^ cuano+'-'+cuanoq=(select cuano+'-'+cuanoq from view_work where noa='"+$('#txtWorkno_' + b_seq).val()+"')"
									t_where=t_where+"and rank=(select cast(rank as int)+1 from view_work where noa='"+$('#txtWorkno_' + b_seq).val()+"') and stationno!='' ^^";
									q_gt('view_work', t_where, 0, 0, 0, "child_work", r_accy);
								}
							}
						});
                    }
                }
                _bbsAssign();
				
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					$('#txtUindate_'+i).attr('disabled', 'disabled');
					$('#txtCuadate_'+i).css('background-color','rgb(237, 237, 238)');
					$('#txtUindate_'+i).css('background-color','rgb(237, 237, 238)');
					
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
							$('#btnMinus_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5 && $('#txtNoq_'+i).val().length==12){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#textDatea_'+i).datepicker('destroy');
							$('#btnMinus_'+i).attr('disabled', 'disabled');
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
							$('#btnMinus_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}else{
						if(!emp($('#txtWorkno_'+i).val())){
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else{
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}
				}
            }
            
            function getmaxnos(seq) {//seq 表示排除的noq
            	var maxnos='0000';
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($('#txtNoq_'+i).val().substr(0,7)==replaceAll($('#txtDatea').val(), '/','')
            		&&i!=dec(seq)&&$('#txtNos_' +i).val()>maxnos &&$('#txtNos_' +i).val().length==4){
            			maxnos=$('#txtNos_' +i).val();
            		}
            	}
            	return maxnos;
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
                for (var i = 0; i < q_bbsCount; i++) {
					if($('#txtNoq_'+i).val()!=undefined){
						if(($('#txtNoq_'+i).val().substr(0,7)!=replaceAll($('#txtDatea').val(), '/','') &&$('#txtNoq_'+i).val().substr(0,7)!='')
							|| ($('#txtNos_'+i).val().length==5 && $('#txtNoq_'+i).val().length==12)){
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
                	$('.dbbs').css('width','1900px');
                }else{
                	$('.isstyle').hide();
                	$('.dbbs').css('width','1710px');
                }
                
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtCuadate_'+i).attr('disabled', 'disabled');
					$('#txtUindate_'+i).attr('disabled', 'disabled');
					$('#txtCuadate_'+i).css('background-color','rgb(237, 237, 238)');
					$('#txtUindate_'+i).css('background-color','rgb(237, 237, 238)');
					
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
							$('#btnMinus_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else if ($('#txtNos_'+i).val().length==5 && $('#txtNoq_'+i).val().length==12){
							$('#txtProcess_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtHours_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtNos_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#textDatea_'+i).removeClass('hasDatepicker');
							$('#textDatea_'+i).datepicker();
							$('#textDatea_'+i).datepicker('destroy');
							$('#btnMinus_'+i).attr('disabled', 'disabled');
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
							$('#btnMinus_'+i).removeAttr('disabled');
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}else{
						if(!emp($('#txtWorkno_'+i).val())){
							$('#btnChildchange_'+i).removeAttr('disabled');
						}else{
							$('#btnChildchange_'+i).attr('disabled', 'disabled');
						}
					}
				}
				if(issave){
            		issave=false;
            		var s2=new Array('cug_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
					q_boxClose2(s2);
				}
				$('.ui-datepicker').css('margin-left','100px');
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
		   
		   function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.earlyday':
                		alert("更新完成!!");
                		//重新開啟新的資料
                		$('#div_child').toggle();
						var t_where = "where=^^ cuano+'-'+cuanoq=(select cuano+'-'+cuanoq from view_work where noa='"+$('#txtWorkno_' + b_seq).val()+"')"
						t_where=t_where+"and rank=(select cast(rank as int)+1 from view_work where noa='"+$('#txtWorkno_' + b_seq).val()+"') and stationno!='' ^^";
						q_gt('view_work', t_where, 0, 0, 0, "child_work", r_accy);
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
		<div id="div_child" style="position:absolute; top:0px; left:0px; display:none; width:1000px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_child" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">提前天數</td>
					<td colspan="6" style="background-color: #f8d463;" id='child_earlyday'>
						<input id='textEarlyday' type='text' class='txt' style='width: 100px;' onkeyup="value=value.substring(0,1)=='-'?'-'+value.replace(/[^\d]/g,''):value.replace(/[^\d]/g,'') "/>
						<input id='textEarlyworkno' type='hidden'/>
						<input id="btnEarlydayok" type="button" value="更新">
					</td>
				</tr>
				<tr id='child_top'>
					<td style="background-color: #CDFFCE;width:16%;" align="center">子階製令單號</td>
					<td style="background-color: #CDFFCE;width:30%;" align="center">製品編號/製品名稱</td>
					<td style="background-color: #CDFFCE;width:15%;" align="center">工作中心/製程</td>
					<td style="background-color: #CDFFCE;width:11%;" align="center">機型</td>
					<td style="background-color: #CDFFCE;width:9%;" align="center">數量</td>
					<td style="background-color: #CDFFCE;width:9%;" align="center">工時</td>
					<td style="background-color: #CDFFCE;width:10%;" align="center">應開工日</td>
				</tr>
				<tr id='child_close'>
					<td align="center" colspan='7'>
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
						<td class="td2" style="width: 176px;"><input id="txtDatea"  type="hidden" class="txt c1"/></td>
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
					<td align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td>
						<input id="txtNos.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" class="txt c1"/>
						<input id="txtCugunoq.*" type="hidden" class="txt c1"/>
						<input id="txtStationno.*" type="hidden" class="txt c1"/>
						<input id="txtStation.*" type="hidden" class="txt c1"/>
					</td>
					<td>
						<input id="textDatea.*" type="text" class="txt c1"/>
						<input id="btnChildchange.*" type="button" style="float: center;" value="子階提前異動"/>
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
