<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "stampuse";
            var q_readonly = ['txtNoa','txtTnoa','txtKeya'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 12;
            aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']
            , ['txtRsssno', 'lblRsss', 'sss', 'noa,namea', 'txtRsssno,txtRnamea', 'sss_b.aspx']
            , ['txtTsssno', 'lblTsss', 'sss', 'noa,namea', 'txtTsssno,txtTnamea', 'sss_b.aspx']);
			
			t_stamp = new Array();//q_getPara('stamp.typea')	
			t_acomp = new Array();//q_gt('acomp', '', 0, 0, 0, "");

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtRdate', r_picd], ['txtTdate', r_picd]];
                q_mask(bbmMask);
				
				q_gt('acomp', '', 0, 0, 0, "");
				
				$('#cmbCno').change(function(e) {
					display();
				}).click(function(e) {
					display();
				});
				$('#lblTnoa').click(function() {
					if($('#txtKeya').val().length>0)
                    	q_pop('txtKeya', "stampuse2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";keya='" + $('#txtKeya').val() + "';" + r_accy + '_' + r_cno, 'stampuse', 'noa', 'datea', "92%", "92%", q_getMsg('popStampuse'), true);
                	else
                		alert('無'+q_getMsg('lblTnoa')+'。');
                });
				
				var m,n;
				t_stamp = q_getPara('stamp.typea').split(',');
				n = 3;//一行可放幾個
				for(var i=0;i<t_stamp.length;i++){
					m = Math.floor(i/n);
					if(i%n==0){
						//add tr
						$('.schema_tr').clone().insertBefore($('#xxzz').nextAll().eq(m)).css('display','').removeClass('schema_tr').addClass('stamp_tr').attr('id','stamp_tr_'+ m);
					}
					if(i==0){
						//add lbl
						$('.schema_td').clone().appendTo($('#stamp_tr_'+ m)).removeClass('schema_td').addClass('stamp_td str');
						$('.schema_span').clone().appendTo($('.stamp_td.str')).removeClass('schema_span').addClass('stamp_span');
						$('.schema_lbl').clone().appendTo($('.stamp_td.str')).removeClass('schema_lbl').css('float','right').html(q_getMsg('lblStamp')).attr('title','印章需在公司主檔設定。');
					}
					else if(i%n==0)
						$('.schema_td').clone().appendTo($('#stamp_tr_'+ m)).removeClass('schema_td').addClass('stamp_td');
					//add checkbox	
					$('.schema_chk').clone().appendTo($('.schema_td').clone().appendTo($('#stamp_tr_'+ m)).removeClass('schema_td').attr('id','stamp_td_'+i)).removeClass('schema_chk').addClass('stamp_chk').attr('id','stamp_chk_'+i);	
					//add lbl
					$('#stamp_td_'+ i).append($('.schema_lbl').clone().removeClass('schema_lbl').addClass('stamp_lbl').css('float','left').attr('id','stamp_lbl_'+i).html(t_stamp[i]).css('cursor','pointer').click(function(e){
						if(q_cur==1 || q_cur==2){
							if($(this).css('color').toUpperCase().replace(/ /g,'')=='RGB(0,0,0)'){
								if($(this).prev().eq(0).attr('disabled')=='')
									$(this).prev().eq(0).prop('checked',!$(this).prev().eq(0).prop('checked'));
								var string = '';
				            	for(var i in t_stamp){
				            		if($('#stamp_chk_'+ i).prop('checked'))
				            			string += (string.length>0?',':'')+t_stamp[i];
								}
				            	$('#txtStamp').val(string);	
							}
						}
							
					}));	
				}
				$('.stamp_chk').click(function(e){
					if(q_cur==1 || q_cur==2){
						var string = '';
		            	for(var i in t_stamp){
		            		if($('#stamp_chk_'+ i).prop('checked'))
		            			string += (string.length>0?',':'')+t_stamp[i];
						}
		            	$('#txtStamp').val(string);	
	            	}	
            	});		
            }
            
            function display(){
            	$('.stamp_lbl').css('color','rgb(237,237,237)');      
                $('.stamp_chk').prop('checked',false);
                $('.stamp_chk').attr('disabled','disabled');
                for(var i in t_acomp){
                	if(t_acomp[i].noa==$('#cmbCno').val()){
                		//t_stamp  全部的印章種類
                		//t_stamp2 該公司有的印章種類
                		t_stamp2 = t_acomp[i].stamp.split(',');
                		for(var j in t_stamp2){
							n = t_stamp.indexOf(t_stamp2[j]);
							if(n>=0){								
								$('#stamp_lbl_'+n).css('color','RGB(0,0,0)');   
								if(q_cur==1 || q_cur==2)
									$('#stamp_chk_'+ n).removeAttr('disabled');
							}
						}	
						//t_stamp3 該單據已勾選的印章
						var t_stamp3 = $('#txtStamp').val().split(',');	
						for(var i in t_stamp3){
							n = t_stamp.indexOf(t_stamp3[i]);
							if(n>=0)
								$('#stamp_chk_'+ n).prop('checked',true);
						}
                	}
                }
                if(q_cur==2 && !($('#txtRdate').val().length==0 && $('#txtTdate').val().length==0)){
                	$('.stamp_chk').attr('disabled','disabled');
                	$('#cmbCno').attr('disabled','disabled');
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                                t_acomp.push({
                                	noa:as[i].noa,
                                	acomp:as[i].acomp,
                                	nick:as[i].nick,
                                	stamp:as[i].stamp
                                });
                            }
                            q_cmbParse("cmbCno", t_item);
                            if(abbm[q_recno] != undefined)
                            //if(q_recno>=0)
                           		$("#cmbCno").val(abbm[q_recno].cno);
                            display();
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
                if(abbm[q_recno]['tnoa'].length==0 && xmlString.length>0){
                	abbm[q_recno]['tnoa'] = xmlString;
                	$('#txtTnoa').val(xmlString);	
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('stampuse_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                display();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                display();
            }

            function btnPrint() {

            }

            function btnOk() {
            	for(var i in t_stamp){
            		if($('#stamp_chk_'+ i).prop('checked') && $('#stamp_lbl_'+ i).css('color').toUpperCase().replace(/ /g,'')!='RGB(0,0,0)'){
            			alert($('#stamp_lbl_'+ i).html()+' 無法選擇。');
            			return;
            		}
				}

            	for(var i in t_acomp){
            		if($('#cmbCno').val()==t_acomp[i].noa){
            			$('#txtAcomp').val(t_acomp[i].acomp);
            			$('#txtNick').val(t_acomp[i].nick);	
            			break;
            		}
            	}
            	
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if (!q_cd($('#txtRdate').val())) {
                    alert(q_getMsg('lblRdate') + '錯誤。');
                    return;
                }
                var t_err = '';
                t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')], ['txtSssno', q_getMsg('lblSss')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('S' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);    
                display();     
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1 || q_cur==2)
                	$('.stamp_chk').removeAttr('disabled');
                else
                	$('.stamp_chk').attr('disabled','disabled');
            }

            function btnMinus(id) {
                _btnMinus(id);
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 600px;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 9%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNamea'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewAcomp'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='namea' style="text-align: left;">~namea</td>
						<td id='nick' style="text-align: left;">~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSss' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSssno"  type="text"  style="float:left; width:40%;"/>
							<input id="txtNamea"  type="text"  style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr id="xxzz">
						<td><span> </span><a id='lblAcomp' class="lbl"> </a></td>
						<td colspan="2">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp"  type="text" style="display:none;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
							<input id="txtStamp"  type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>				
					<tr>
						<td><span> </span><a id='lblRdate' class="lbl"> </a></td>
						<td><input id="txtRdate"  type="text" class="txt c1" />	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRsss' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtRsssno"  type="text"  style="float:left; width:40%;"/>
							<input id="txtRnamea"  type="text"  style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTdate' class="lbl"> </a></td>
						<td><input id="txtTdate"  type="text" class="txt c1" />	</td>
						<td><span> </span><a id='lblTnoa' class="lbl btn"> </a></td>
						<td>
							<input id="txtTnoa"  type="text" class="txt c1" />	
							<input id="txtKeya"  type="text" style="display:none;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTsss' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtTsssno"  type="text"  style="float:left; width:40%;"/>
							<input id="txtTnamea"  type="text"  style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr class="schema_tr" style="display:none;"> </tr>
					<tr style="display:none;">
						<td class="schema_td"> </td>
						<td>
							<span class="schema_span"> </span>
							<a class="schema_lbl"> </a>
						</td>					
						<td><input type="checkbox" class="schema_chk" style="float:left;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
