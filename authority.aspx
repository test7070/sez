<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script type="text/javascript">

		var q_name = 'authority', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 100;
		var t_sqlname = 'authority_load'; t_postname = q_name; q_alias = 'a';
		var isBott = false;  /// 是否已按過 最後一頁
		var afield, t_htm;
		var i, s1;
		var decbbs = [];
		var decbbm = [];
		var q_readonly = [];
		var q_readonlys = ['txtSssno', 'txtNamea'];
		var bbmNum = [];
		var bbmNum_comma = [];
		var bbsNum = [];
		var bbsNum_comma = [];
		var bbmMask = [];
		var bbsMask = [];
		
		$(document).ready(function () {
			bbmKey = [];
			bbsKey = ['noa', 'sssno'];
			
			q_bbsFit = 1;
			
			if (location.href.indexOf('?') < 0)   // debug
			{
				location.href = location.href + "?;;;a.noa='accc'";
				return;
			}
			
			if (!q_paraChk())
				return;
			main();
		});              /// end ready
		
		function main() {
			if (dataErr)  /// 載入資料錯誤
			{
				dataErr = false;
				return;
			}
			mainBrow(6, t_content, t_sqlname, t_postname);
			scroll("tbbs","box",1);
		}
		
		function bbsAssign() {  /// 表身運算式
			for (var j = 0; j < q_bbsCount; j++) {
				$('#check_All_'+j).click(function() {
					t_noq=$(this).attr('id').split('check_All_')[1];
					$('#chkPr_run_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					$('#chkPr_ins_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					$('#chkPr_modi_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					$('#chkPr_dele_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					$('#chkPr_seek_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					$('#chkPr_repo_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					$('#chkPrice_show_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					$('#chkPrice_modi_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
				});
			}
			_bbsAssign();
			for (var j = 0; j < q_bbsCount; j++) {
				if(q_cur==1||q_cur==2){
					$('#check_All_'+j).removeAttr('disabled');
				}else{
					$('#check_All_'+j).attr('disabled', 'disabled');
				}
			}
		}
		
		function btnOk() {
			sum();
			_btnOk('', bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
		}
		
		var t_noa;
		function bbsSave(as) {
			return true;
			
			if (!as['namea']) {  // Dont Save Condition
				as[bbsKey[0]] = '';   /// noa  empty --> dont save
				return;
			}
		
			if (!t_noa) {
				var s2 = q_getId(), s3, s4, x, y;   ///  write all Para to Array
				if (s2.length > 3) {
					s3 = s2[3].split('and');
					for (x = 0; x < s3.length; x++) {
						s4 = s3[x].split('=');
						if (s4[0].indexOf('>') == -1 && s4[0].indexOf('<') == -1) {  /// ignore  > <
							as[bbsKey[x]] = replaceAll(s4[1], "'", '');
						}
					}
				}
			
				t_noa = as[bbsKey[0]];
			}else
				as[bbsKey[0]] = t_noa;
		
			t_err = '';
			if (t_err) {
				alert(t_err)
				return false;
			}
			
			return true;
		}
		
		function btnModi() {
			var t_key = q_getHref();
			
			if (!t_key)
				return;
			
			_btnModi(1);
			
			//        for (i = 0; i < abbsDele.length; i++) {
			//            abbsDele[i][bbsKey[0]] = t_key[1];
			//        }
		}
		
		function btnModi2() {
			var s2 = q_getId(), s3, s4, x, y;   /// 網址篩選 條件
			if (s2.length < 4) {
				alert("Need Parameter  ? ; ; ; noa='bbb'");
				return;
			}
			_btnModi2();
			
			s3 = s2[3].split('and');
			for (x = 0; x < s3.length; x++) {
				s4 = s3[x].split('=');
				break;
			}
		
			s4[1] = replaceAll(s4[1], "'", '');
			for (i = 0; i < abbsDele.length; i++) {
				abbsDele[i][bbsKey[0]] = s4[1];
			}
		}
		
		function boxStore() {
		
		}
		
		function refresh() {
			_refresh();
			if (brwAct == 6)
				_readonlys((q_cur > 0 ? false : true));
		}
		
		function sum() { }
		
		var asss = [], t_key;
		function q_gtPost(t_postname) {  /// 資料下載後 ...
			var t_table = 'nhpe';
			//        var s1 = xmlDoc.getElementsByTagName(t_table)[0];
			//        fsssAll = q_xmlToField(xmlDoc.getElementsByTagName(t_table + '_f')[0]);
			//        asss = q_xmlToArray(s1, fsssAll);
			var asss = _q_appendData('nhpe', '', true);
			var i, j, k, t_found, anew = [], s1;
			t_key = q_getHref();
			for (i = 0; i < asss.length; i++) {
				t_found = false;
				for (j = 0; j < abbs.length; j++) {
					if (abbs[j]['sssno'] == asss[i]['noa']) {
						t_found = true;
						break;
					}
				}
				if (!t_found) {
					for (k = 0; k < asss['field'].length; k++) {
						s1 = asss['field'][k];
						anew[i] = [];
						anew[i][s1] = '';
					}
					anew[i]['sssno'] = asss[i]['noa'];
					anew[i]['namea'] = asss[i]['namea'];
				}
				else
				anew[i] = abbs[j];
				
				anew[i]['noa'] = t_key[1];
			}
			
			abbs = anew;
			q_bbsCount = abbs.length;
			refresh();
			_readonlys(true);
		}
		
		function readonly(t_para, empty) {
			_readonly(t_para, empty);
			
			
			for (var j = 0; j < q_bbsCount; j++) {
				if(t_para){
					$('#check_All_'+j).attr('disabled', 'disabled');
				}else{
					$('#check_All_'+j).removeAttr('disabled');
				}
			}
		}
		
		function btnMinus(id) {
			_btnMinus(id);
			sum();
		}
		
		function btnPlus(org_htm, dest_tag, afield) {
			_btnPlus(org_htm, dest_tag, afield);
			if (q_tables == 's')
				bbsAssign();  /// 表身運算式
		}
		
		var scrollcount=1;
		function scroll(viewid,scrollid,size){
			if(scrollcount>1)
				$('#box_'+(scrollcount-1)).remove();
			var scroll = document.getElementById(scrollid);
			var tb2 = document.getElementById(viewid).cloneNode(true);
			var len = tb2.rows.length;
			for(var i=tb2.rows.length;i>size;i--){
				tb2.deleteRow(size);
			}
			var bak = document.createElement("div");
			bak.id="box_"+scrollcount
			scrollcount++;
			scroll.appendChild(bak);
			bak.appendChild(tb2);
			bak.style.position = "absolute";
			bak.style.backgroundColor = "#cfc";
			bak.style.display = "block";
			bak.style.left = 0;
			bak.style.top = "0px";
			scroll.onscroll = function(){
				bak.style.top = this.scrollTop+"px";
			}
		}
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            #box {
                height: 600px;
                width: 100%;
                overflow-y: auto;
                position: relative;
            }
		</style>
	</head>
	<body>
		<div id="box">
			<div  id="dbbs"  >
				<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:690px'  >
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:6%;"><a id='lblChk_all'> </a></td>
						<td align="center" style="width:12%;"><a id='lblSssno'> </a></td>
						<td align="center" style="width:15%;"><a id='lblNamea'> </a></td>
						<td align="center" style="width:6%;"><a id='lblPr_run'> </a></td>
						<td align="center" style="width:6%;"><a id='lblPr_ins'> </a></td>
						<td align="center" style="width:6%;"><a id='lblPr_modi'> </a></td>
						<td align="center" style="width:6%;"><a id='lblPr_dele'> </a></td>
						<td align="center" style="width:6%;"><a id='lblPr_seek'> </a></td>
						<td align="center" style="width:6%;"><a id='lblPr_repo'> </a></td>
						<td align="center" style="width:10%;"><a id='lblPrice_show'> </a></td>
						<td align="center" style="width:10%;"><a id='lblPrice_modi'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center"><input id="check_All.*" type="checkbox" /></td>
						<td><input class="txt" id="txtSssno.*" type="text" maxlength='90' style="font-size:medium;width:96%;"   /></td>
						<td><input class="txt"  id="txtNamea.*" maxlength='30'type="text" style="font-size:medium;width:96%;" /></td>
						<td><input id="chkPr_run.*" type="checkbox" /></td>
						<td><input id="chkPr_ins.*" type="checkbox" /></td>
						<td><input id="chkPr_modi.*" type="checkbox" /></td>
						<td><input id="chkPr_dele.*" type="checkbox" /></td>
						<td><input id="chkPr_seek.*" type="checkbox" /></td>
						<td ><input id="chkPr_repo.*" type="checkbox" /></td>
						<td style="text-align:center;"><input id="chkPrice_show.*" type="checkbox"/></td>
						<td style="text-align:center;">
							<input id="chkPrice_modi.*" type="checkbox"/>
							<input id="recno.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div  id="dbbtail" style=" text-align:right" >
			<p></p>
			<a id='lblPrice'> </a>
			<input class="txt" id="textPrice" type="text" style="width:25%;" />
			<a id='lblMemo'> </a>
			<input class="txt"  id="textMemo" type="text" style="width:25%;" />
		</div>
		<!--#include file="../inc/pop_modi.inc"-->
		<input id="q_sys" type="hidden" />
	</body>
</html>
