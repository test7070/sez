<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
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
            var q_name = "acomp";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];
     
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
			brwCount2 = 20;
			t_stamp = new Array();//q_getPara('stamp.typea')
			aPop = new Array(['txtAddr', '', 'view_road', 'memo', '0txtAddr', 'road_b.aspx']);
            				
			function acomp(noa,stamp) {
				try{
					this.noa = noa;
					if(stamp.length>0)
						this.stamp = stamp.split(',');
					else
						this.stamp = new Array();
					this.stampuse = new Array();
					t_where = "where=^^ cno='"+this.noa+"' and len(isnull(rdate,''))=0 and len(isnull(tdate,''))=0 and len(ltrim(stamp))>0 ^^";		
					q_gt('stampuse', t_where, 0, 0, 0, "", r_accy);
				}catch(e){
					alert('1_'+e.message);
				}
			}
			acomp.prototype = {
				noa: '',
				stamp : new Array(),
				stampuse : new Array()
			}
			t_acomp = new Array();
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('acomp', t_where, 0, 0, 0, "checkAcompno_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
                });
                $('#txtSerial').change(function(e){
					$('#txtSerial').val($.trim($('#txtSerial').val()));
					checkId($('#txtSerial').val());
				});
				var m,n;
				t_stamp = q_getPara('stamp.typea').split(',');
	
				n = 3;//一行可放幾個
				for(var i=0;i<t_stamp.length;i++){
					m = Math.floor(i/n);
					if(i%n==0){
						$('.schema_tr').clone().appendTo($('#tbbm tbody')).css('display','').removeClass('schema_tr').addClass('stamp_tr').attr('id','stamp_tr_'+ m);
					}
					if(i==0){
						$('.schema_td').clone().appendTo($('#stamp_tr_'+ m)).removeClass('schema_td').addClass('stamp_td str');
						$('.schema_span').clone().appendTo($('.stamp_td.str')).removeClass('schema_span').addClass('stamp_span');
						$('.schema_lbl').clone().appendTo($('.stamp_td.str')).removeClass('schema_lbl').addClass('stamp_lbl').css('float','right').html(q_getMsg('lblStamp'));
					}
					else if(i%n==0)
						$('.schema_td').clone().appendTo($('#stamp_tr_'+ m)).removeClass('schema_td').addClass('stamp_td');
						
					$('.schema_chk').clone().appendTo($('.schema_td').clone().appendTo($('#stamp_tr_'+ m)).removeClass('schema_td').attr('id','stamp_td_'+i)).removeClass('schema_chk').addClass('stamp_chk').attr('id','stamp_chk_'+i);	
					$('#stamp_td_'+ i).append($('.schema_lbl').clone().removeClass('schema_lbl').addClass('stamp_lbl').css('float','left').attr('id','stamp_lbl_'+i).html(t_stamp[i]).css('color','black').css('cursor','pointer').click(function(e){
						if(q_cur==1 || q_cur==2)
							$(this).prev().eq(0).prop('checked',!$(this).prev().eq(0).prop('checked'));
					}));
				}	
				
				if(q_getPara('sys.comp').indexOf('大昌')>-1){ 
					$('.stamp_tr').show();
				}else{
					$('.stamp_tr').hide();
				}
            }
            function display(){
            	$('.stamp_chk').prop('checked',false);
                var t_stamp2 = $('#txtStamp').val().split(',');	
				for(var i in t_stamp2){
					n = t_stamp.indexOf(t_stamp2[i]);
					if(n>=0)
						$('#stamp_chk_'+ n).prop('checked',true);
				}
				for(var i in t_stamp){
					$('#stamp_lbl_'+i).html(t_stamp[i]).css('color','black');
				}
				var t_index = -1;
				for(var i in t_acomp){
					if($.trim($('#txtNoa').val())==t_acomp[i].noa){
						for(var j in t_acomp[i].stampuse){
							t_index = t_stamp.indexOf(t_acomp[i].stampuse[j].stamp);
							if(t_index>=0){
								$('#stamp_lbl_'+t_index).html(t_stamp[t_index]+'('+t_acomp[i].stampuse[j].namea+')').css('color','red').attr('title',t_acomp[i].stampuse[j].datea+' '+t_acomp[i].stampuse[j].memo);
							}	
						}
						break;
					}
				}
            }
            function checkId(str){
            	if((/^[a-z,A-Z][0-9]{9}$/g).test(str)){
            		var key='ABCDEFGHJKLMNPQRSTUVWXYZIO';
            		var s = (key.indexOf(str.substring(0,1))+10)+str.substring(1,10);
            		var n = parseInt(s.substring(0,1))*1 
            			+ parseInt(s.substring(1,2))*9
            			+ parseInt(s.substring(2,3))*8
            			+ parseInt(s.substring(3,4))*7
            			+ parseInt(s.substring(4,5))*6
            			+ parseInt(s.substring(5,6))*5
            			+ parseInt(s.substring(6,7))*4
            			+ parseInt(s.substring(7,8))*3
            			+ parseInt(s.substring(8,9))*2
            			+ parseInt(s.substring(9,10))*1
            			+ parseInt(s.substring(10,11))*1;
					if ((n%10)!=0)
            			alert('身分證字號錯誤。') ;       		
            	}else if((/^[0-9]{8}$/g).test(str)){
            		var key = '12121241';
            		var n = 0;
            		var m = 0;
            		for(var i=0;i<8;i++){
            			n = parseInt(str.substring(i,i+1)) * parseInt(key.substring(i,i+1));
            			m += Math.floor(n/10)+n%10;
            		}
            		if( !((m%10)==0 || ((str.substring(6,7)=='7'?m+1:m)%10)==0))
            			alert('統一編號錯誤。') ; 
            	}else{
            		alert('undefined');
            	}
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                } 
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'checkAcompno_change':
                		var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].acomp);
                        }
                		break;
                	case 'checkAcompno_btnOk':
                		var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].acomp);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                	case 'stampuse':           		
                		var as = _q_appendData("stampuse", "", true);
                        if (as[0] != undefined) {
                        	if(as[0].cno.length==0)
                        		return;
                        	var index_acomp = -1;
                        	for(var i in t_acomp){
                        		if(as[0].cno == t_acomp[i].noa){
                        			index_acomp = i;
                        			break;
                        		}
                        	}
                        	if(index_acomp==-1)
                        		return;
                        	var index_stampuse = -1;           
                        	for(var i in as) {
                        		if(as[i].stamp == undefined)
                        			continue;
                       			tmp_stamp = $.trim(as[i].stamp).split(',');
                        		for(var j in tmp_stamp){
                        			for(var k in t_acomp[index_acomp].stampuse){
                        				if(tmp_stamp[j]==t_acomp[index_acomp].stampuse[k].stamp){
                        					index_stampuse = k;
                        					break;
                        				}	
                        			}
                        			if(index_stampuse==-1){       
										t_acomp[index_acomp].stampuse.push({
	                            			stamp : tmp_stamp[j],
	                            			datea : as[i].datea,
	                            			sssno : as[i].sssno,
	                            			namea : as[i].namea,
	                            			memo : as[i].memo
	                            		});    				
                        			}else if(as[i].datea>=t_acomp[index_acomp].stampuse[index_stampuse].datea){
                        				t_acomp[index_acomp].stampuse[index_stampuse].datea = as[i].datea;
                        				t_acomp[index_acomp].stampuse[index_stampuse].sssno = as[i].sssno;
                        				t_acomp[index_acomp].stampuse[index_stampuse].namea = as[i].namea;
                        				t_acomp[index_acomp].stampuse[index_stampuse].memo = as[i].memo;
                        			}
                        		}
                        	}
                        }
                        display();
                		break;
                    case q_name:
                    	var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {                   
                            for (var i = 0; i < as.length; i++) {
                            	isFound = false;
                            	for(var j in t_acomp){
                            		if(t_acomp[j].noa == as[i].noa){
                            			isFound = true;
                            			break;
                            		}
                            	}
                            	if(!isFound)
                            		t_acomp.push(new acomp(as[i].noa,$.trim(as[i].stamp)));
                            }
                        }
                    
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('acomp_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                refreshBbm();
                $('#txtNoa').attr('readonly', true);
                $('#txtAcomp').focus();
            }

            function btnPrint() {

            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
            	var string = '';
            	for(var i in t_stamp){
            		if($('#stamp_chk_'+ i).prop('checked'))
            			string += (string.length>0?',':'')+t_stamp[i];
				}
            	$('#txtStamp').val(string);
            	
            	Lock(); 
            	$('#txtNoa').val($.trim($('#txtNoa').val()));   	
            	if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock();
					return;
				}
        	
                if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('acomp', t_where, 0, 0, 0, "checkAcompno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
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
                refreshBbm();
                display();	
            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
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
                width: 250px; 
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
                width: 700px;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 61%;
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
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:40px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:180px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: left;">~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm">
					<tbody>
						<tr style="height:1px;">
							<td> </td>
							<td> </td>
							<td> </td>
							<td> </td>
							<td class="tdZ"> </td>
						</tr>
						<tr>
							<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
							<td colspan="3"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblAcomp' class="lbl"> </a></td>
							<td colspan="3"><input id="txtAcomp"  type="text" class="txt c1" />	</td>
						</tr>
						<tr>
							<td><span> </span><a id='lblNick' class="lbl"> </a></td>
							<td><input id="txtNick"  type="text" class="txt c1" /></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblEname' class="lbl"> </a></td>
							<td colspan="3"><input id="txtEname"  type="text" class="txt c1" />	</td>
						</tr>
						<tr>
							<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
							<td><input id="txtBoss"  type="text" class="txt c1" /></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
							<td><input id="txtSerial"  type="text" class="txt c1" /></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblTel' class="lbl"> </a></td>
							<td><input id="txtTel"  type="text" class="txt c1" /></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblFax' class="lbl"> </a></td>
							<td><input id="txtFax"  type="text" class="txt c1" /></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
							<td colspan="3"><input id="txtAddr"  type="text" class="txt c1" />	</td>
						</tr>
						<tr>
							<td><span> </span><a id='lblAddr_invo' class="lbl"> </a></td>
							<td colspan="3"><input id="txtAddr_invo"  type="text" class="txt c1" />	</td>
						</tr>
						<tr>
							<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
							<td colspan="3"><textarea id="txtMemo" cols="10" rows="5" style="width: 100%;height: 127px;"> </textarea></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblHealthno' class="lbl"> </a></td>
							<td><input id="txtHealthno"  type="text" class="txt c1" />	</td>
							<td><span> </span><a id='lblLaborno' class="lbl"> </a></td>
							<td><input id="txtLaborno"  type="text" class="txt c1" />	</td>
						</tr>
						<tr>
							<td><span> </span><a id='lblInsur_disaster' class="lbl"> </a></td>
							<td><input id="txtInsur_disaster"  type="text" class="txt c1" /></td>
						</tr>
						<tr class="schema_tr" style="display:none;"> </tr>
						<tr style="display:none;">
							<td><input id="txtStamp"  type="text" class="txt c1"/></td>
							<td class="schema_td"> </td>
							<td>
								<span class="schema_span"> </span>
								<a class="schema_lbl"> </a>
							</td>					
							<td><input type="checkbox" class="schema_chk" style="float:left;"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
