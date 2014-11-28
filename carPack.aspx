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

            var q_name = "carpack";
            var q_readonly = ['txtNoa', 'txtDatea', 'txtWorker', 'txtWorker2','txtCarmount'];
            var bbmNum = [['txtMoney', 10, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                brwCount2 = 10;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(0);
                // 1=Last  0=Top

                $('#txtNoa').focus();

            }///  end Main()
			
			var cartype=' @,A@曳引車,B@半拖車,C@大小貨車';
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                
                $('#txtPlace').focusout(function() {
                	$('#cmbTypea_0').focus();
				});
                
                /*$('#txtMount').change(function() {
                    $('#txtCarmount').val(dec($('#txtMount').val()) * dec($('#txtRate').val()));
                });
                
                $('#txtRate').change(function() {
                    $('#txtCarmount').val(dec($('#txtMount').val()) * dec($('#txtRate').val()));
                });*/
                
                //bbs
                $('#btnPluss').click(function() {
                	if(q_cur==1 || q_cur==2){
                		var rowslength = document.getElementById("table_bbs").rows.length - 2;
                		var tr = document.createElement("tr");
                		var rows=rowslength
						tr.id = "bbs_"+rows;
						tr.innerHTML = "<td><input class='btn'  id='btnMinus_"+rows+"' type='button' value='-' style='font-weight: bold;'  /></td>";
						tr.innerHTML += "<td><select id='cmbTypea_"+rows+"' class='txt c1'> </select></td>";
						tr.innerHTML += "<td><input id='txtMount_"+rows+"' type='text' class='txt num c1' /></td>";
						tr.innerHTML += "<td><input id='txtRate_"+rows+"' type='text' class='txt num c1' /></td>";
						tr.innerHTML += "<td><input id='txtCarmount_"+rows+"' type='text' class='txt num c1' style='background: rgb(237, 237, 238);color: green;' disabled='disabled'/></td>";
						var tmp = document.getElementById("bbs_bottom");
						tmp.parentNode.insertBefore(tr, tmp);
						q_cmbParse("cmbTypea_"+rows+"",cartype);
                	}
                	bbsfocus();
				});
            }
            
            function bbsfocus() {
            	var rowslength = document.getElementById("table_bbs").rows.length - 2;
                for (var i = 0; i < rowslength; i++) {
                	$('#btnMinus_'+i).click(function() {
                		if(q_cur==1 || q_cur==2){
	                		var n=$(this).attr('id').split('_')[1];
	                		$('#cmbTypea_'+n).val('');
	                		$('#txtMount_'+n).val('');
	                		$('#txtRate_'+n).val('');
	                		$('#txtCarmount_'+n).val('');
                		}
					});
					
					$('#txtMount_'+i).change(function() {
						var n=$(this).attr('id').split('_')[1];
                    	$('#txtCarmount_'+n).val(dec($('#txtMount_'+n).val()) * dec($('#txtRate_'+n).val()));
                    	sum();
	                }).keyup(function() {
	                	var tmp=$(this).val().replace(/[^\d]/g,'');
						$(this).val(tmp);
					});
	                
	                $('#txtRate_'+i).change(function() {
	                	var n=$(this).attr('id').split('_')[1];
	                    $('#txtCarmount_'+n).val(dec($('#txtMount_'+n).val()) * dec($('#txtRate_'+n).val()));
	                    sum();
	                }).keyup(function() {
	                	var tmp=$(this).val().replace(/[^\d]/g,'');
						$(this).val(tmp);
					});
	                
	                $('#cmbTypea_'+i).change(function() {
	                	var n=$(this).attr('id').split('_')[1];
	                	var t_type=$('#cmbTypea_'+n).val();
	                	if(t_type=='A')
	                    	$('#txtRate_'+n).val(16);
	                    if(t_type=='B' || t_type=='C')
	                    	$('#txtRate_'+n).val(8);
	                    $('#txtCarmount_'+n).val(dec($('#txtMount_'+n).val()) * dec($('#txtRate_'+n).val()));
	                    sum();
	                });
                }
            	
            	var SeekF= new Array();
				$('#table_bbs td').children("input:text,select").each(function() {
					SeekF.push($(this).attr('id'));
				});
				
				SeekF.push('btnOk');
								
				$('#table_bbs td').children("input:text,select").each(function() {
					$(this).mousedown(function(e) {
						$(this).focus();
						$(this).select();
					});
										
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, SeekF[$.inArray($(this).attr('id'),SeekF)+1]);	
					});
				});
            }
            
            function sum() {
                var rowslength = document.getElementById("table_bbs").rows.length - 2;
                var t_carmount=0;
				for (var j = 0; j < rowslength; j++) {
					if(!emp($('#cmbTypea_'+j).val())){
						t_carmount=q_add(t_carmount,q_float('txtCarmount_'+j));
					}
				}
                q_tr('txtCarmount',t_carmount);
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('carpack_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date());
                $('#txtCardealno').focus();
				
				var rowslength = document.getElementById("table_bbs").rows.length - 1;
				for (var j = 1; j < rowslength; j++) {
					document.getElementById("table_bbs").deleteRow(1);
				}
				//預設開5行
				for (var i = 0; i < 5; i++) {
					$('#btnPluss').click();
				}
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtCardealno').focus();
            }

            function btnPrint() {
                q_box('z_car2.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                var t_err = '';

                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                var rowslength = document.getElementById("table_bbs").rows.length - 2;
                var t_typea='',t_mount='',t_rate='',t_carmount=0;
				for (var j = 0; j < rowslength; j++) {
					if(!emp($('#cmbTypea_'+j).val())){
						t_typea=t_typea+(t_typea.length>0?',':'')+$('#cmbTypea_'+j).val();
						t_mount=t_mount+(t_mount.length>0?',':'')+$('#txtMount_'+j).val();
						t_rate=t_rate+(t_rate.length>0?',':'')+$('#txtRate_'+j).val();
						t_carmount=q_add(t_carmount,q_float('txtCarmount_'+j));
					}
				}
                $('#txtTypea').val(t_typea);
                $('#txtMount').val(t_mount);
                $('#txtRate').val(t_rate);
                q_tr('txtCarmount',t_carmount);
				
				if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('P' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
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
                for (var i = 0; i < brwCount; i++) {
                		if($("#chkBrow_"+i).prop('checked')){
                			$("#chkBrow_"+i).parent().parent().addClass("vewSel");
                		}else{
                			$("#chkBrow_"+i).parent().parent().removeClass("vewSel")
                		}
                }
                
                var rowslength = document.getElementById("table_bbs").rows.length - 1;
				for (var j = 1; j < rowslength; j++) {
					document.getElementById("table_bbs").deleteRow(1);
				}
                var t_typea=$('#txtTypea').val().split(',');
                var t_mount=$('#txtMount').val().split(',');
                var t_rate=$('#txtRate').val().split(',');
                var maxrow=Math.max(t_typea.length,t_mount.length,t_rate.length)
                if(maxrow==0){
                	var tr = document.createElement("tr");
					tr.id = "bbs_0";
					tr.innerHTML = "<td><input class='btn'  id='btnMinus_0' type='button' value='-' style='font-weight: bold;'  /></td>";
					tr.innerHTML += "<td><select id='cmbTypea_0' class='txt c1'> </select></td>";
					tr.innerHTML += "<td><input id='txtMount_0' type='text' class='txt num c1' /></td>";
					tr.innerHTML += "<td><input id='txtRate_0' type='text' class='txt num c1' /></td>";
					tr.innerHTML += "<td><input id='txtCarmount_0' type='text' class='txt num c1' /></td>";
					var tmp = document.getElementById("bbs_bottom");
					tmp.parentNode.insertBefore(tr, tmp);
					
					q_cmbParse("cmbTypea_0",cartype);
                }else{
                	for (var i = 0; i < maxrow; i++) {
                		var tr = document.createElement("tr");
						tr.id = "bbs_" + i;
						tr.innerHTML = "<td><input class='btn'  id='btnMinus_"+i+"' type='button' value='-' style='font-weight: bold;'  /></td>";
						tr.innerHTML += "<td><select id='cmbTypea_"+i+"' class='txt c1' style='background: rgb(237, 237, 238); ' disabled='disabled'> </select></td>";
						tr.innerHTML += "<td><input id='txtMount_" + i + "' type='text' class='txt num c1' style='background: rgb(237, 237, 238);' disabled='disabled'/></td>";
						tr.innerHTML += "<td><input id='txtRate_" + i + "' type='text' class='txt num c1' style='background: rgb(237, 237, 238);' disabled='disabled'/></td>";
						tr.innerHTML += "<td><input id='txtCarmount_" + i + "' type='text' class='txt num c1' style='background: rgb(237, 237, 238);color: green;' disabled='disabled'/></td>";
						var tmp = document.getElementById("bbs_bottom");
						tmp.parentNode.insertBefore(tr, tmp);
						
						q_cmbParse("cmbTypea_"+i,cartype);
						if(t_typea[i])
							$('#cmbTypea_'+i).val(t_typea[i]);
						if(t_mount[i])
							$('#txtMount_'+i).val(t_mount[i]);
						if(t_rate[i])
							$('#txtRate_'+i).val(t_rate[i]);
							
						if(t_mount[i] && t_rate[i])
							$('#txtCarmount_'+i).val(dec(t_rate[i])*dec(t_mount[i]));
                	}
                }
                
                bbsfocus();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                var rowslength = document.getElementById("table_bbs").rows.length - 2;
                for (var i = 0; i < rowslength; i++) {
	                if(t_para){
	                	$('#cmbTypea_'+i).css('background','rgb(237, 237, 238)').attr('disabled', 'disabled');
	                	$('#txtMount_'+i).css('background','rgb(237, 237, 238)').attr('disabled', 'disabled');
	                	$('#txtRate_'+i).css('background','rgb(237, 237, 238)').attr('disabled', 'disabled');
	                }else{
	                	$('#cmbTypea_'+i).css('background','white').removeAttr('disabled');
	                	$('#txtMount_'+i).css('background','white').removeAttr('disabled');
	                	$('#txtRate_'+i).css('background','white').removeAttr('disabled');
	                }
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
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
                width: 98%;
            }
            .vewSel {
               background-color: lightpink;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66; width: 100%;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:41%"><a id='vewCardeal'> </a></td>
						<td align="center" style="width:12%"><a id='vewBdate'> </a></td>
						<td align="center" style="width:10%"><a id='vewMount'> </a></td>
						<td align="center" style="width:12%"><a id='vewEdate'> </a></td>
						<td align="center" style="width:20%"><a id='vewPlace'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='cardeal'>~cardeal</td>
						<td align="right" id='bdate'>~bdate</td>
						<td align="center" id='mount'>~mount</td>
						<td align="right" id='edate'>~edate</td>
						<td align="center" id='place'>~place</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblCardeal" class="lbl btn" > </a></td>
						<td class="td4">
							<input id="txtCardealno"  type="text" class="txt c2" />
							<input id="txtCardeal" type="text" class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td6"><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td class="td2"><input id="txtBdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td4"><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td class="td1"><span> </span><a id="lblEdate" class="lbl"> </a></td>
						<td class="td2"><input id="txtEdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td3"><span> </span><a id="lblCarmount" class="lbl"> </a></td>
						<td class="td4"><input id="txtCarmount" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblPlace" class="lbl"> </a></td>
						<td class="td6" colspan="3"><input id="txtPlace" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td class="td5">
							<input id="txtTypea" type="hidden" class="txt c1"/>
							<input id="txtMount" type="hidden" class="txt c1"/>
							<input id="txtRate" type="hidden" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="div_bbs" style="width:500px;">
			<table id="table_bbs" border="1" cellpadding='2' cellspacing='0' style="font-size: medium;width:100%;text-align: center;background:#cad3ff;">
				<tr id='bbs_top' style='color:White; background:#003366;'>
					<td style="width:34px;"><input class="btn"  id="btnPluss" type="button" value='+' style="font-weight: bold;"  /></td>
					<td style="width:100px;"><span> </span><a id="lblTypea" class="lbl"> </a></td>
					<td style="width:100px;"><span> </span><a id="lblMount" class="lbl"> </a></td>
					<td style="width:100px;"><span> </span><a id="lblRate" class="lbl"> </a></td>
					<td style="width:100px;"><span> </span><a id="lblCarmounts" class="lbl">可停車數</a></td>
				</tr>
				<tr id='bbs_bottom' style='color:White; background:#003366;'> </tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
