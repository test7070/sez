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
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtStation','txtProcess','txtGen','txtHours'];
            var q_readonlys = ['txtProcess','txtProductno','txtProduct','txtHours','txtDays','txtMount','txtWorkno','txtOrgcuadate','txtOrguindate'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'uca', 'noa,product', 'txtProductno_,txtProduct_', 'uca_b.aspx']
            ,['txtStationno', 'lblStation', 'station', 'noa,station,gen', 'txtStationno,txtStation,txtGen', 'station_b.aspx']
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

            function mainPost() {
                bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd]];
                bbsMask = [['txtCuadate', r_picd],['txtUindate', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                
                $('#btnWork').click(function() {
                	if(emp($('#txtStationno').val())){
                		alert(q_getMsg('lblStation')+'請先填寫。');
                		return;
                	}else{
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
                		t_where=t_where+"order by case when a.cuadate='' then '999/99/99' else a.cuadate end,case when a.uindate='' then '999/99/99' else a.uindate end,a.processno,a.noa desc,a.hours";
						q_gt('cug_work', t_where, 0, 0, 0, "", r_accy);
                	}
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
                	case 'cug_work':
                		var as = _q_appendData("view_work", "", true);
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
                			/*for ( var i = 0; i < as.length; i++) {
                				as[i].noq=('000'+(i+1)+'0').substr(-4);	
                				//as[i].days=round(as[i].hours/24,0)
                			}*/
                			q_gridAddRow(bbsHtm, 'tbbs'
							,'txtProcessno,txtProcess,txtProductno,txtProduct,txtMount,txtHours,txtDays,txtCuadate,txtUindate,txtOrgcuadate,txtOrguindate,txtWorkno', as.length, as,
							'processno,process,productno,product,mount,hours,days,cuadate,uindate,cuadate,uindate,workno','txtProductno');
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

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                //檢查排程序號
                for (var i = 0; i < q_bbsCount; i++) {
                	for (var j = i+1; j < q_bbsCount; j++) {
                		if (i!=j &&!emp($('#txtWorkno_'+i).val())&&!emp($('#txtNoq_'+i).val())&&$('#chkIssel_'+i).prop('checked')&&$('#chkIssel_'+j).prop('checked')&& $('#txtNoq_'+i).val()==$('#txtNoq_'+j).val()){
                			alert(q_getMsg('lblNoq_s')+'['+$('#txtNoq_'+i).val()+']重覆')
                			return;
                		}
                	}
                }
                //處理有排程但沒有排程序號的資料
                for (var i = 0; i < q_bbsCount; i++) {
                	if ($('#chkIssel_'+i).prop('checked')&&emp($('#txtNoq_'+i).val())&&!emp($('#txtWorkno_'+i).val())){
                		$('#txtNoq_'+i).val(('000'+(dec(getmaxnoq(-1).substr(0,3))+1)).substr(-3)+'0');
                	}
                }
                
                //重新編排沒有排程的noq放在有排程的下面
                var maxnoq=getmaxnoq(-1),count=1;
                for (var i = 0; i < q_bbsCount; i++) {
                	if(!$('#chkIssel_'+i).prop('checked')&&!emp($('#txtWorkno_'+i).val())){
                		$('#txtNoq_'+i).val(('000'+(dec(maxnoq.substr(0,3))+count)).substr(-3)+'0');
                		count++;
                	}
                }
                
                sum();
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
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                q_box('z_cugp.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
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
		                
		                $('#chkIssel_' + i).click(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#chkIssel_'+b_seq).prop('checked')){	//判斷是否被選取
								$('#trSel_'+ b_seq).addClass('chkIssel');//變色
								$('#txtNoq_'+ b_seq).val(('000'+(dec(getmaxnoq(b_seq).substr(0,3))+1)).substr(-3)+'0');
							}else{
				                $('#trSel_'+b_seq).removeClass('chkIssel');//取消變色
							}
							sum();
						});
		                
                    }
                }
                _bbsAssign();
            }
            
            function getmaxnoq(seq) {//seq 表示排除的noq
            	var maxnoq='0000';
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($('#chkIssel_'+i).prop('checked')&&i!=dec(seq)&&$('#txtNoq_' +i).val()>maxnoq){
            			maxnoq=$('#txtNoq_' +i).val();
            		}
            	}
            	return maxnoq;
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']&& !as['workno']) {//不存檔條件
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
					if($('#chkIssel_'+j).prop('checked'))
						t1=t1+q_float('txtHours_'+j);
                } // j
                $('#txtHours').val(t1);
            }

            function refresh(recno) {
                _refresh(recno);
                for (var i = 0; i < q_bbsCount; i++) {
		        	if($('#chkIssel_'+i).prop('checked')){	//判斷是否被選取
		               	$('#trSel_'+ i).addClass('chkIssel');//變色
		            }else{
		            	$('#trSel_'+i).removeClass('chkIssel');//取消變色
					}
				}
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
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
                width: 1860px;
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
						<td class="td1" style="width: 130px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td3" style="width: 130px;"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td4"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td5"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStation' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtStationno"  type="text" class="txt c2"/>
							<input id="txtStation"  type="text" class="txt c3"/>
						</td>
						<td class="td3" style="width: 130px;"><span> </span><a id='lblGen' class="lbl"> </a></td>
						<td class="td4"><input id="txtGen"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblProcess' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtProcessno"  type="text" class="txt c2"/>
							<input id="txtProcess"  type="text" class="txt c3"/>
						</td>
						<td class="td3" style="width: 130px;"><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
						<td class="td4"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCuadate' class="lbl"> </a></td>
						<td class="td2">
							<input id="txtBdate"  type="text" class="txt c2"/><a style="float: left;">~</a>
							<input id="txtEdate"  type="text" class="txt c2"/>
						</td>
						<td class="td3" style="width: 130px;"><span> </span><a id='lblHours' class="lbl"> </a></td>
						<td class="td4"><input id="txtHours"  type="text" class="txt num c1"/></td>
						<td class="td5"><input id="btnWork" type="button"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtMemo"  type="text" class="txt c5"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2"  type="text" class="txt c1"/></td>
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
					<td align="center" style="width:145px;"><a id='lblProcess_s'> </a></td>
					<td align="center" style="width:185px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:275px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblHours_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblDays_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblOrgcuadate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblOrguindate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblCuadate_s'> </a></td>
					<td align="center" style="width:105px;"><a id='lblUindate_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblWorkno_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr id="trSel.*">
					<td align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td align="center"><input id="chkIssel.*" type="checkbox"/></td>
					<td>
						<input id="txtNoq.*" type="text" class="txt c1"/>
						<input id="txtStationno.*" type="hidden" class="txt c1"/>
						<input id="txtStation.*" type="hidden" class="txt c1"/>
					</td>
					<td><input id="txtProcess.*" type="text" class="txt c1"/><input id="txtProcessno.*" type="hidden" class="txt c1"/></td>
					<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtHours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDays.*" type="text" class="txt num c1"/></td>
					<td><input id="txtOrgcuadate.*" type="text" class="txt c1"/></td>
					<td><input id="txtOrguindate.*" type="text" class="txt c1"/></td>
					<td><input id="txtCuadate.*" type="text" class="txt c1"/></td>
					<td><input id="txtUindate.*" type="text" class="txt c1"/></td>
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
