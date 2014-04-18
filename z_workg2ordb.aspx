<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
		
		var isorda=true; //選擇要產生orde還是orda 要產生orda=ture,要產生orde=false
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_workg2ordb');
                
                $('#q_report').click(function(e) {
										
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						if($('.radio.select').next().text()==$('#q_report').data().info.reportData[i].reportName){
							//下面註解取得q_lang的z_xxxxx
							var txtreport=$('#q_report').data().info.reportData[i].report;
						}
					}
										
					if(txtreport=='z_workg2ordb1'){
						/*if(isorda){
							$('#btnOrdb').hide();
							$('#btnOrda').show();
							$('#btnOrda2ordb').hide();
						}else{
							$('#btnOrdb').show();
							$('#btnOrda').hide();
							$('#btnOrda2ordb').hide();
						}
					}else{
						$('#btnOrdb').hide();
						$('#btnOrda').hide();
						if(isorda){
							$('#btnOrda2ordb').show();
						}else{
							$('#btnOrda2ordb').hide();
						}*/
					}
				});
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workg2ordb',
                    options : [{
						type : '0',
						name : 'accy',
                        value : q_getId()[4] //[1]
                    },{
                        type : '1', //[2][3]
                        name : 'odate'
                    },{
                        type : '1', //[4][5]
                        name : 'workgno'
                    },{
                        type : '2',//[6][7]
                        name : 'xproductno',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                     },{
                        type : '8', //[8]
                        name : 'workgall',
                        value : ("1@全部未請購的排產計畫").split(',')
                    },{
                        type : '6', //[9]
                        name : 'enddate'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtOdate1').mask('999/99/99');
                $('#txtOdate1').datepicker();
                $('#txtOdate2').mask('999/99/99');
                $('#txtOdate2').datepicker();
                $('#txtEnddate').mask('999/99/99');
                $('#txtEnddate').datepicker();
                $('#txtEnddate').val(q_date());
                
                if (window.parent.q_name == 'workg') {
					var wParent = window.parent.document;
					$('#txtWorkgno1').val(wParent.getElementById("txtNoa").value);
					$('#txtWorkgno2').val(wParent.getElementById("txtNoa").value);
					if(wParent.getElementById("txtEdate").value!='')
					$('#txtEnddate').val(wParent.getElementById("txtEdate").value);
				}
                
                var btn = document.getElementById('btnOk');
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrdb' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='無簽核轉請購'>");
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrda2ordb' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='簽核轉請購'>");
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrda' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='送簽核'>");
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnCheck' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='查詢'>");
                
                $('#btnOk').hide();
                /*if(isorda){
					$('#btnOrdb').hide();
					$('#btnOrda').show();
					$('#btnOrda2ordb').hide();
				}else{
					$('#btnOrdb').show();
					$('#btnOrda').hide();
					$('#btnOrda2ordb').hide();
				}*/
                
                $('#btnOrdb').click(function(){
                	if($('#chkWorkgall [type]=checkbox').prop('checked'))
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')=''^^", 0, 0, 0, "ordb", r_accy);
                	else
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')='' and noa between '"+$('#txtWorkgno1').val()+"' and '"+$('#txtWorkgno2').val()+"' ^^ ", 0, 0, 0, "ordb", r_accy);
	            });
	            
	           $('#btnOrda').click(function(){
                	if($('#chkWorkgall [type]=checkbox').prop('checked'))
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')=''^^", 0, 0, 0, "orda", r_accy);
                	else
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')='' and noa between '"+$('#txtWorkgno1').val()+"' and '"+$('#txtWorkgno2').val()+"' ^^ ", 0, 0, 0, "orda", r_accy);
	            });
	            
	            $('#btnOrda2ordb').click(function(){
                	q_gt('orda', "where=^^isnull(workgno,'')!='' and isnull(ordbno,'')='' and noa in (select zno from sign where enda='Y' and left(zno2,4)='orda') and noa in (select ordano from view_workg where noa between '"+$('#txtWorkgno1').val()+"' and '"+$('#txtWorkgno2').val()+"') ^^ ", 0, 0, 0, "orda2ordb", r_accy);
	            });
	            
	            $('#btnCheck').click(function(){
	            	if($('#chkWorkgall [type]=checkbox').prop('checked'))
	            		q_gt('workg', "where=^^ isnull(ordano,'')='' and isnull(ordbno,'')='' ^^", 0, 0, 0, "check", r_accy);
	            	else
	            		q_gt('workg', "where=^^ isnull(ordano,'')='' and isnull(ordbno,'')='' and noa between '"+$('#txtWorkgno1').val()+"' and '"+$('#txtWorkgno2').val()+"'^^", 0, 0, 0, "check", r_accy);
	            });
	            
	            $('.q_report .option div .c3').css("width","180px");
	            $('.q_report .option div .c6').css("width","110px");
	            $('#Workgall .c6').css('width','0px');
	            $('#chkWorkgall').css('width','290px');
	            $('#Workgall').css('width','300px');
	            
	            if (window.parent.q_name == 'workg') {
					var wParent = window.parent.document;
					if(wParent.getElementById("txtOrdbno").value.length==0&&wParent.getElementById("txtOrdano").value.length==0)
						$('#btnOk').click();
					else
						$('#btnCheck').click();
				}
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
				switch (t_name) {
					case 'check':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
		                	var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
		                	var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
		                	var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
							var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
		                	var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
		                	var workgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
		                	var enddate=!emp($('#txtEnddate').val())?$('#txtEnddate').val():'#non';
		                	
							var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno+ ';' + workgall+';'+enddate+';'+r_userno+';'+q_getPara('sys.key_ordb');
							var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
							q_gtx("z_workg2ordb1", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
						}else{
							var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
		                	var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
		                	var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
		                	var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
							var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
		                	var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
		                	var workgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
		                	var enddate=!emp($('#txtEnddate').val())?$('#txtEnddate').val():'#non';
		                	
							var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno+ ';' + workgall+';'+enddate+';'+r_userno+';'+q_getPara('sys.key_ordb');
							var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
							q_gtx("z_workg2ordb3", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
						}
						
						break;
					case 'ordb':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							if(confirm("確定要轉至請購?"))
							{
								var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
		                		var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
		                		var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
		                		var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
								var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
		                		var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
		                		//$('#chkWorkgall input[type=checkbox]').prop('checked')
		                		var workgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
		                		var enddate=!emp($('#txtEnddate').val())?$('#txtEnddate').val():'#non';
		                		
								var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno+ ';' + workgall+';'+enddate+';'+r_userno+';'+q_getPara('sys.key_ordb');
								var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
				                q_gtx("z_workg2ordb2", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
							}
						}else{
							alert('已產生請購。');
						}
						break;
					case 'orda':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							if(confirm("確定要轉至簽核?"))
							{
								var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
		                		var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
		                		var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
		                		var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
								var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
		                		var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
		                		//$('#chkWorkgall input[type=checkbox]').prop('checked')
		                		var workgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
		                		var enddate=!emp($('#txtEnddate').val())?$('#txtEnddate').val():'#non';
		                		
								var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno+ ';' + workgall+';'+enddate+';'+r_userno+';'+q_getPara('sys.key_orda');
								var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
				                //q_gtx("z_workg2ordb4", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
				                q_func('qtxt.query.sign', 'orda.txt,sign,' + t_where);
							}
						}else{
							alert('已產生過簽核。');
						}
						break;
					case 'orda2ordb':
						var as = _q_appendData("orda", "", true);
						if (as[0] != undefined) {
							if(confirm("確定將簽核轉至請購?"))
							{
								var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
		                		var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
		                		var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
		                		var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
								var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
		                		var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
		                		//$('#chkWorkgall input[type=checkbox]').prop('checked')
		                		var workgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
		                		var enddate=!emp($('#txtEnddate').val())?$('#txtEnddate').val():'#non';
		                		
								var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno+ ';' + workgall+';'+enddate+';'+r_userno+';'+q_getPara('sys.key_ordb');
								var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
				                q_gtx("z_workg2ordb5", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
							}
						}else{
							alert('簽核未核准。');
						}
						break;
				}
			}
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.sign':
                		var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							q_func('sign.q_signForm', 'orda,,'+  as[0].ordano);
							alert('簽核送出。');
						}
                	break;
                }
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>