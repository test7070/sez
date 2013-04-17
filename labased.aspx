<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
            var q_name = 'labased', t_bbsTag = 'tbbs', t_content = "", afilter = [] , bbmKey = [], bbsKey = ['noa,noq'], as, brwCount2 = 10;
            var t_sqlname = 'labased_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [['txtHealth_bdate', '999/99/99'], ['txtHealth_edate', '999/99/99'], ['txtLabor_bdate', '999/99/99'], ['txtLabor_edate', '999/99/99'], ['txtRetire_bdate', '999/99/99'], ['txtRetire_edate', '999/99/99']];

            aPop = new Array(['txtCno_', 'btnCno_', 'acomp', 'noa,acomp', 'txtCno_,txtAcomp_', 'acomp_b.aspx']);

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='0015'";
                    return;
                }
                if(!q_paraChk())
                    return;

                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                q_mask(bbmMask);
                bbsMask = [['txtHealth_bdate', '999/99/99'], ['txtHealth_edate', '999/99/99'], ['txtLabor_bdate', '999/99/99'], ['txtLabor_edate', '999/99/99'], ['txtRetire_bdate', '999/99/99'], ['txtRetire_edate', '999/99/99']];
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse('cmbCno', t_item,'s');
                        for(var j = 0;j < q_bbsCount;j++){
                        	if(abbs[j].cno != 'undefined'){
                        		$('#cmbCno_'+j).val(abbs[j].cno);
                        	}
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch

            }
            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            		$('#txtHealth_bdate_' + j).blur(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(!emp($('#txtHealth_bdate_'+b_seq).val()) && emp($('#txtLabor_bdate_'+b_seq).val()))
               				$('#txtLabor_bdate_'+b_seq).val($('#txtHealth_bdate_'+b_seq).val());
               			if(!emp($('#txtHealth_bdate_'+b_seq).val()) && emp($('#txtRetire_bdate_'+b_seq).val()))
               				$('#txtRetire_bdate_'+b_seq).val($('#txtHealth_bdate_'+b_seq).val());
				    });
				    $('#txtHealth_edate_' + j).blur(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(!emp($('#txtHealth_edate_'+b_seq).val()) && emp($('#txtLabor_edate_'+b_seq).val()))
               				$('#txtLabor_edate_'+b_seq).val($('#txtHealth_edate_'+b_seq).val());
               			if(!emp($('#txtHealth_edate_'+b_seq).val()) && emp($('#txtRetire_edate_'+b_seq).val()))
               				$('#txtRetire_edate_'+b_seq).val($('#txtHealth_edate_'+b_seq).val());
				    });
            	}
                _bbsAssign();//_bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
            				
            	if(q_getHref()[0] == 'noa' && q_getHref()[1] != '' ){
	            	for(var i = 0 ;i < q_bbsCount;i++){
	            		if($('#txtHealth_bdate_' + i).val() == ''){
							$('#txtHealth_bdate_' + i).val($('#txtHealth_bdate_' + (i+1)).val());
	            		}
	            		if($('#txtLabor_bdate_' + i).val() == ''){
							$('#txtLabor_bdate_' + i).val($('#txtLabor_bdate_' + (i+1)).val());
	            		}
	            		if($('#txtRetire_bdate_' + i).val() == ''){
							$('#txtRetire_bdate_' + i).val($('#txtRetire_bdate_' + (i+1)).val());
	            		}
	            if($('#txtHealth_bdate_' + i).val().length>0 && !q_cd($('#txtHealth_bdate_' + i).val()))
            		alert(q_getMsg('lblHealth_bdate')+'錯誤。');  
            	if($('#txtHealth_edate_' + i).val().length>0 && !q_cd($('#txtHealth_edate_' + i).val()))
            		alert(q_getMsg('lblHealth_edate')+'錯誤。');
            	if($('#txtLabor_bdate_' + i).val().length>0 && !q_cd($('#txtLabor_bdate_' + i).val()))
            		alert(q_getMsg('lblLabor_bdate')+'錯誤。');  
            	if($('#txtLabor_edate_' + i).val().length>0 && !q_cd($('#txtLabor_edate_' + i).val()))
            		alert(q_getMsg('lblLabor_edate')+'錯誤。');
            	if($('#txtRetire_bdate_' + i).val().length>0 && !q_cd($('#txtRetire_bdate_' + i).val()))
            		alert(q_getMsg('lblRetire_bdate')+'錯誤。');  
            	if($('#txtRetire_edate_' + i).val().length>0 && !q_cd($('#txtRetire_edate_' + i).val()))
            		alert(q_getMsg('lblRetire_edate')+'錯誤。');
	            	}
            	}else{
            		alert("read error!");
            		return;
            	}
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
                
            }

            function bbsSave(as) {
                if(!as['cno']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }
            function refresh() {
                _refresh();
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
                if(q_tables == 's')
                    bbsAssign();
            }

		</script>
		<style type="text/css">
            td a {
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    <input id="txtNoq.*" type="hidden" />
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:18%;"><a id='lblAcomp_s'></a></td>
					<td class="td3" align="center" style="width:8%;"><a id='lblHealth_bdate'></a></td>
					<td class="td4" align="center" style="width:8%;"><a id='lblHealth_edate'></a></td>
					<td class="td5" align="center" style="width:8%;"><a id='lblLabor_bdate'></a></td>
					<td class="td6" align="center" style="width:8%;"><a id='lblLabor_edate'></a></td>
					<td class="td7" align="center" style="width:8%;"><a id='lblRetire_bdate'></a></td>
					<td class="td8" align="center" style="width:8%;"><a id='lblRetire_edate'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td class="td2">
						<input class="txt" id="txtCno.*" type="text" style="width:20%"/>
						<input class="txt" id="txtAcomp.*"type="text" style="width:65%;"/>
						<input id="btnCno.*" type="button" value="." style="width: 1%;" />
					</td>
					<td class="td3"><input id="txtHealth_bdate.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td4"><input id="txtHealth_edate.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td5"><input id="txtLabor_bdate.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td6"><input id="txtLabor_edate.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td7"><input id="txtRetire_bdate.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td8"><input id="txtRetire_edate.*" type="text" class="txt c1" style="width:95%;"/></td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
